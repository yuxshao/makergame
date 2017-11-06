(* Code generation: translate takes a semantically checked AST and
   produces LLVM IR

   LLVM tutorial: Make sure to read the OCaml version of the tutorial

   http://llvm.org/docs/tutorial/index.html

   Detailed documentation on the OCaml LLVM library:

   http://llvm.moe/
   http://llvm.moe/ocaml/

*)

module L = Llvm
module A = Ast

module StringMap = Map.Make(String)

let translate ((globals, functions, gameobjs) : Ast.program) =
  let context = L.global_context () in
  let the_module = L.create_module context "MicroC"
  and i64_t    = L.i64_type    context
  and i32_t    = L.i32_type    context
  and i8_t     = L.i8_type     context
  and i1_t     = L.i1_type     context
  (* TODO: tests for floating point parsing/scanning, printing *)
  and float_t  = L.double_type context (* TODO: fix LRM to say double precision *)
  and sprite_t = L.pointer_type (L.named_struct_type context "sfSprite")
  and sound_t  = L.pointer_type (L.named_struct_type context "sfSound")
  and void_t   = L.void_type   context in

  (* Declare types for each object type *)
  let gameobj_types =          (* TODO: test. *)
    let lltype_of m gdecl =
      let name = gdecl.A.Gameobj.name in
      StringMap.add name (L.named_struct_type context name, gdecl) m
    in
    List.fold_left lltype_of StringMap.empty gameobjs
  in

  (* Define generic types for linked lists and game objects *)
  let node_t = L.named_struct_type context "node" in
  let nodeptr_t = L.pointer_type node_t in
  L.struct_set_body node_t [|nodeptr_t; nodeptr_t|] false;

  let objref_t = L.named_struct_type context "objref" in
  L.struct_set_body objref_t [|i64_t; nodeptr_t|] false;

  let gameobj_t = L.named_struct_type context "gameobj" in
  let objptr_t = L.pointer_type gameobj_t in
  let eventptr_t = L.pointer_type (L.function_type void_t [|objref_t|]) in
  L.struct_set_body gameobj_t [|node_t; i64_t; eventptr_t; eventptr_t; eventptr_t; eventptr_t|] false;

  (* Define linked list heads *)
  let (gameobj_head, obj_heads) =
    let make_head name =
      let n = L.declare_global node_t (name ^ "_head") the_module in
      L.set_initializer (L.const_named_struct node_t [|n; n|]) n; n
    in
    let add_head map name = StringMap.add name (make_head name) map in
    let names = List.map (fun x -> x.A.Gameobj.name) gameobjs in
    (make_head "gameobj", List.fold_left add_head StringMap.empty names)
  in
  let obj_head n = StringMap.find n obj_heads in

  let global_objid = L.define_global "last_objid" (L.const_int i64_t 0) the_module in

  let ltype_of_typ = function
    | A.Int -> i32_t
    | A.Bool -> i1_t
    | A.Float -> float_t        (* FIXME: FLOAT OPERATIONS DISALLOWED & UNSUPPORTED. *)
    | A.Arr _ -> failwith "not implemented"
    | A.String -> L.pointer_type i8_t
    (* | A.Arr (typ, len) -> L.array_type (ltype_of_typ typ) len *)
    | A.Sprite -> sprite_t
    | A.Sound -> sound_t
    | A.Object _ -> objref_t
    | A.Void -> void_t
  in

  (* Define object type structs *)
  StringMap.iter
    (fun _ (t, gdecl) ->
       let members = gdecl.A.Gameobj.members in
       let ll_members = List.map (fun (typ, _) -> ltype_of_typ typ) members in
       L.struct_set_body t (Array.of_list (gameobj_t :: node_t :: ll_members)) false)
    gameobj_types;

  (* Declare each global variable; remember its value in a map *)
  let global_vars =
    let global_var m (t, n) =
      let init = L.const_null (ltype_of_typ t)
      in StringMap.add n (L.define_global n init the_module, t) m in
    List.fold_left global_var StringMap.empty globals in

  (* Given value ll for an object of type objname, builds and returns scope of
     that object in StringMap. *)
  let gameobj_members ll objname builder =
    let (_, objtype) = StringMap.find objname gameobj_types in
    let add_member (map, ind) (typ, name) =
      let member_var = L.build_struct_gep ll ind name builder in
      (StringMap.add name (member_var, typ) map, ind + 1)
    in
    let (members, _) =
      (* object type struct: gameobj_t :: node_t :: members *)
      List.fold_left add_member (StringMap.empty, 2) objtype.A.Gameobj.members
    in
    members
  in

  (* Declare printf(), which the print built-in function will call *)
  let printf_t = L.var_arg_function_type i32_t [| L.pointer_type i8_t |] in
  let printf_func = L.declare_function "printf" printf_t the_module in

  (* Helper function for assigning struct values. *)
  let build_struct_assign str values builder =
    let assign (llv, ind) value =
      match value with
      | Some v -> (L.build_insertvalue llv v ind "" builder, ind+1)
      | None -> (llv, ind+1)
    in
    let (ret, _) = Array.fold_left assign (str, 0) values in ret
  in

  (* Helper function for assigning struct values given a pointer. *)
  let build_struct_ptr_assign ptr values builder =
    let assign ind value =
      match value with
      | Some v ->
        ignore (L.build_store v (L.build_struct_gep ptr ind "" builder) builder)
      | None -> ()
    in Array.iteri assign values
  in

  (* Define list_add(new, head), which puts new to the end of the list
     marked by head. *)
  let list_add_func =
    let f =
      let t = L.function_type void_t [|nodeptr_t; nodeptr_t|] in
      L.define_function "list_add" t the_module
    in
    let builder = L.builder_at_end context (L.entry_block f) in
    let node, head = L.param f 0, L.param f 1 in
    let following_prev_ptr = L.build_struct_gep head 0 "prev_ptr" builder in
    let fprev = L.build_load following_prev_ptr "prev" builder in
    let preceding_next_ptr = L.build_struct_gep fprev 1 "next_ptr" builder in
    (* let pnext = L.build_load preceding_next_ptr "next" builder in *)
    let pnext = head in
    ignore (L.build_store node following_prev_ptr builder);
    ignore (L.build_store node preceding_next_ptr builder);
    build_struct_ptr_assign node [|Some fprev; Some pnext|] builder;
    ignore (L.build_ret_void builder);
    f
  in

  (* Removes a node from a linked list. Does not free. *)
  let list_rem_func =
    let f =
      let t = L.function_type void_t [|nodeptr_t|] in
      L.define_function "list_rem" t the_module
    in
    let builder = L.builder_at_end context (L.entry_block f) in
    let node = L.param f 0 in
    let prev_ptr = L.build_struct_gep node 0 "prev_ptr" builder in
    let prev = L.build_load prev_ptr "prev" builder in
    let next_ptr = L.build_struct_gep node 1 "next_ptr" builder in
    let next = L.build_load next_ptr "next" builder in
    let next_prev = L.build_struct_gep next 0 "next_prev" builder in
    ignore (L.build_store prev next_prev builder);
    let prev_next = L.build_struct_gep prev 1 "prev_next" builder in
    ignore (L.build_store next prev_next builder);
    ignore (L.build_ret_void builder); f
  in

  let destroy_func =
    let f =
      let t = L.function_type void_t [|objref_t|] in
      L.define_function "destroy" t the_module
    in
    let builder = L.builder_at_end context (L.entry_block f) in
    let objref = L.param f 0 in
    let node = L.build_extractvalue objref 1 "node" builder in
    let _ =
      let objptr = L.build_bitcast node objptr_t "objptr" builder in
      let destroy_event = L.build_load (L.build_struct_gep objptr 4 "" builder) "event" builder in
      L.build_call destroy_event [|objref|] "" builder
    in
    (* TODO: also need to remove object-particular node *)
    ignore (L.build_call list_rem_func [|node|] "" builder);
    ignore (L.build_free node builder);
    ignore (L.build_ret_void builder); f
  in

  (* Define each function (arguments and return type) so we can call it *)
  let function_decls =
    let function_decl m fdecl =
      let name = fdecl.A.fname
      and formal_types =
        Array.of_list (List.map (fun (t,_) -> ltype_of_typ t) fdecl.A.formals)
      in let ftype = L.function_type (ltype_of_typ fdecl.A.typ) formal_types in
      let d_function name =
        match fdecl.A.block with
        | Some _ -> L.define_function ("f_" ^ name)
        | None -> L.declare_function name
      in
      StringMap.add name (d_function name ftype the_module, fdecl) m in
    List.fold_left function_decl StringMap.empty functions
  in

  let gameobj_func_decls =
    let func_decls g =     (* TODO: test *)
      let open A.Gameobj in
      let decl_fn (f_name, _) =
        let name = g.name ^ "_" ^ f_name in
        let llfn_t = L.function_type void_t [|ltype_of_typ (A.Object(g.name))|] in
        (name, L.define_function name llfn_t the_module)
      in
      List.map decl_fn [("create", g.create); ("step", g.step); ("destroy", g.destroy); ("draw", g.draw)]
    in
    List.concat (List.map func_decls gameobjs)
    |> List.fold_left (fun map (k, v) -> StringMap.add k v map) StringMap.empty
  in

  let fmt_str name contents =
    L.define_global (name ^ "_fmt") (L.const_stringz context contents) the_module
  in
  let int_fmt_str   = fmt_str "int"   "%d\n" in
  let float_fmt_str = fmt_str "float" "%f\n" in
  let str_fmt_str   = fmt_str "str"   "%s\n" in
  let fmt_str global builder =
    L.build_gep global
      [|L.const_int i32_t 0; L.const_int i32_t 0|] "" builder
  in

  (* Invoke "f builder" if the current block doesn't already
     have a terminal (e.g., a branch). *)
  let add_terminal builder f =
    match L.block_terminator (L.insertion_block builder) with
      Some _ -> ()
    | None -> ignore (f builder) in

  (* Fill in the body of the given function *)
  let build_function_body the_function formals block return_type =
    let builder = L.builder_at_end context (L.entry_block the_function) in

    (* Construct the function's "locals": formal arguments and locally
       declared variables.  Allocate each on the stack, initialize their
       value, if appropriate, and remember their values in the "locals" map *)
    let scope =
      let formals =
        let add_formal m (t, n) p =
          L.set_value_name n p;
          let local = L.build_alloca (ltype_of_typ t) n builder in
          ignore (L.build_store p local builder);
          StringMap.add n (local, t) m in
        List.fold_left2
          add_formal StringMap.empty formals
          (Array.to_list (L.params the_function))
      in

      let locals =
        let add_local m (t, n) =
          let local_var = L.build_alloca (ltype_of_typ t) n builder
          in StringMap.add n (local_var, t) m in
        List.fold_left add_local StringMap.empty block.A.locals
      in

      let add =
        StringMap.merge (fun _ a b -> match a, b with Some a, _ -> Some a | _ -> b)
      in
      global_vars |> add formals |> add locals
    in

    (* Return the value for a variable or formal argument *)
    let rec lookup builder scope n chain =
      let (top, top_type) = StringMap.find n scope in
      match chain with
      | [] -> top
      | hd :: tl ->
        match top_type with
        | A.Object objname ->
          let nodeptr = L.build_struct_gep top 1 (n ^ "_nodeptr") builder in
          let node = L.build_load nodeptr (n ^ "_node") builder in
          let (obj_type, _) = StringMap.find objname gameobj_types in
          let lltop = L.build_bitcast node (L.pointer_type obj_type) n builder in
          lookup builder (gameobj_members lltop objname builder) hd tl
        | _ -> assert false (* failwith "cannot get member of non-object type" *)
    in

    (* Construct code for an expression; return its value *)
    let rec expr builder = function
      | A.Literal i -> L.const_int i32_t i
      | A.BoolLit b -> L.const_int i1_t (if b then 1 else 0)
      | A.StringLit l -> L.build_global_stringptr l "literal" builder
      | A.FloatLit f -> L.const_float float_t f
      | A.Noexpr -> L.const_int i32_t 0
      | A.Id (hd, tl) -> L.build_load (lookup builder scope hd tl) hd builder
      | A.Binop (e1, op, _, e2) ->
        let e1' = expr builder e1
        and e2' = expr builder e2 in
        (match op with
         | A.Add     -> L.build_add
         | A.Sub     -> L.build_sub
         | A.Mult    -> L.build_mul
         | A.Div     -> L.build_sdiv
         | A.Expo    -> failwith "not implemented"
         | A.Modulo  -> failwith "not implemented"
         | A.And     -> L.build_and (* TODO: SHOULD WE SHORT CIRCUIT? *)
         | A.Or      -> L.build_or
         | A.Equal   -> L.build_icmp L.Icmp.Eq
         | A.Neq     -> L.build_icmp L.Icmp.Ne
         | A.Less    -> L.build_icmp L.Icmp.Slt
         | A.Leq     -> L.build_icmp L.Icmp.Sle
         | A.Greater -> L.build_icmp L.Icmp.Sgt
         | A.Geq     -> L.build_icmp L.Icmp.Sge
        ) e1' e2' "tmp" builder
      | A.Unop(op, _, e) ->
        let e' = expr builder e in
        (match op with
           A.Neg     -> L.build_neg
         | A.Not     -> L.build_not) e' "tmp" builder
      | A.Assign ((hd, tl), e) -> let e' = expr builder e in
        ignore (L.build_store e' (lookup builder scope hd tl) builder); e'
      | A.Call ("printstr", [e]) ->
        L.build_call printf_func
          [| fmt_str str_fmt_str builder; (expr builder e) |] "printf" builder
      | A.Call ("print", [e]) | A.Call ("printb", [e]) ->
        L.build_call printf_func
          [| fmt_str int_fmt_str builder; (expr builder e) |] "printf" builder
      | A.Call ("print_float", [e]) -> (* TODO: test this fn *)
        L.build_call printf_func
          [| fmt_str float_fmt_str builder; (expr builder e) |] "printf" builder
      (* TODO: unify print names and their tests *)
      | A.Call (f, act) ->
        let (fdef, fdecl) = StringMap.find f function_decls in
        (* TODO: can arguments have side effects? what's the order-currently LtR *)
        let actuals = List.map (expr builder) act in
        let result =
          match fdecl.A.typ with A.Void -> "" | _ -> f ^ "_result"
        in
        L.build_call fdef (Array.of_list actuals) result builder
      | A.Create objname ->
        let (objtype, _) = StringMap.find objname gameobj_types in
        let llobj = L.build_malloc objtype objname builder in
        let llnode = L.build_bitcast llobj nodeptr_t (objname ^ "_node") builder in
        let llobjnode =
          L.build_bitcast (L.build_struct_gep llobj 1 "" builder)
            nodeptr_t (objname ^ "_objnode") builder
        in
        ignore (L.build_call list_add_func [|llobjnode; obj_head objname|] "" builder);
        ignore (L.build_call list_add_func [|llnode; gameobj_head|] "" builder);
        let llid = L.build_load global_objid "old_id" builder in
        let llid = L.build_add llid (L.const_int i64_t 1) "new_id" builder in
        ignore (L.build_store llid global_objid builder);
        let events =
          ["create"; "step"; "destroy"; "draw"]
          |> List.map (fun x ->
              Some (L.build_bitcast
                      (StringMap.find (objname ^ "_" ^ x) gameobj_func_decls)
                      eventptr_t (objname ^ "_" ^ x) builder))
        in
        let llobj_gen = L.build_bitcast llobj objptr_t (objname ^ "_gen") builder in
        build_struct_ptr_assign llobj_gen (Array.of_list (None :: Some llid :: events)) builder;
        let objref = build_struct_assign (L.undef objref_t) [|Some llid; Some llnode|] builder in
        let create_event = match List.hd events with | Some ev -> ev | None -> assert false in
        (* TODO: include something in LRM about non-initialized values *)
        ignore (L.build_call create_event [|objref|] "" builder);
        objref
      | A.Destroy e ->
        L.build_call destroy_func [|expr builder e|] "" builder
    in

    (* Build the code for the given statement; return the builder for
       the statement's successor *)
    let rec stmt builder = function
        A.Block sl -> List.fold_left stmt builder sl
      | A.Expr e -> ignore (expr builder e); builder
      | A.Return e -> ignore (match return_type with
          | A.Void -> L.build_ret_void builder
          | _ -> L.build_ret (expr builder e) builder); builder
      | A.If (predicate, then_stmt, else_stmt) ->
        let bool_val = expr builder predicate in
        let merge_bb = L.append_block context "merge" the_function in

        let then_bb = L.append_block context "then" the_function in
        add_terminal (stmt (L.builder_at_end context then_bb) then_stmt)
          (L.build_br merge_bb);

        let else_bb = L.append_block context "else" the_function in
        add_terminal (stmt (L.builder_at_end context else_bb) else_stmt)
          (L.build_br merge_bb);

        ignore (L.build_cond_br bool_val then_bb else_bb builder);
        L.builder_at_end context merge_bb

      | A.While (predicate, body) ->
        let pred_bb = L.append_block context "while" the_function in
        ignore (L.build_br pred_bb builder);

        let body_bb = L.append_block context "while_body" the_function in
        add_terminal (stmt (L.builder_at_end context body_bb) body)
          (L.build_br pred_bb);

        let pred_builder = L.builder_at_end context pred_bb in
        let bool_val = expr pred_builder predicate in

        let merge_bb = L.append_block context "merge" the_function in
        ignore (L.build_cond_br bool_val body_bb merge_bb pred_builder);
        L.builder_at_end context merge_bb

      | A.For (e1, e2, e3, body) ->
        stmt builder (A.Block [A.Expr e1; A.While (e2, A.Block [body; A.Expr e3])])
      | A.Foreach _ -> failwith "not implemented"
    in

    (* Build the code for each statement in the function *)
    let builder = stmt builder (A.Block block.A.body) in

    (* Add a return if the last block falls off the end *)
    add_terminal builder (match return_type with
        | A.Void -> L.build_ret_void
        | t -> L.build_ret (L.const_int (ltype_of_typ t) 0))
  in

  let build_function f =
    match f.A.block with
    | Some block ->
      let (the_function, _) = StringMap.find f.A.fname function_decls in
      let formals = f.A.formals in
      let return_type = f.A.typ in
      build_function_body the_function formals block return_type
    | None -> ()
  in

  List.iter build_function functions;

  let build_gameobj_fn g =
    let open A.Gameobj in
    let build_fn (f_name, block) =
      let name = g.name ^ "_" ^ f_name in
      let llfn = StringMap.find name gameobj_func_decls in
      build_function_body llfn [A.Object(g.name), "this"] block A.Void (* TODO: make sure you can't reassign this *)
    in
    List.iter build_fn [("create", g.create); ("step", g.step); ("destroy", g.destroy); ("draw", g.draw)]
  in
  List.iter build_gameobj_fn gameobjs;

  let create_gb = L.define_function "global_create" (L.function_type void_t [||]) the_module in
  build_function_body create_gb [] { A.locals = []; body = [A.Expr (A.Create "main")]} A.Void;

  let global_event (name, offset) =
    let step_gb = L.define_function ("global_" ^ name) (L.function_type void_t [||]) the_module in
    let builder = L.builder_at_end context (L.entry_block step_gb) in
    let node_ptr = L.build_alloca nodeptr_t "node" builder in
    (* ignore (L.build_call printf_func [|L.build_global_stringptr ("%s\n") "strfmt" builder; L.build_global_stringptr name name builder|] "" builder); *)
    ignore (L.build_store gameobj_head node_ptr builder);
    let pred_bb = L.append_block context "check" step_gb in
    ignore (L.build_br pred_bb builder);

    let pred_builder = L.builder_at_end context pred_bb in
    let curr = L.build_load node_ptr "cur_node" pred_builder in
    let next = L.build_load (L.build_struct_gep curr 0 "" pred_builder) "next_ptr" pred_builder in
    (* let next_int = L.build_ptrtoint next i64_t "" pred_builder in *)
    (* let head_int = L.build_ptrtoint gameobj_head i64_t "" pred_builder in *)
    (* ignore (L.build_call printf_func [|L.build_global_stringptr "%d %d\n" "ptrfmt" pred_builder; next_int; head_int|] "" pred_builder); *)
    ignore (L.build_store next node_ptr pred_builder);
    let diff = L.build_ptrdiff next gameobj_head "diff" pred_builder in
    let bool_val = L.build_icmp L.Icmp.Eq diff (L.const_null (L.i64_type context)) "cont" pred_builder in

    let body_bb = L.append_block context "body" step_gb in
    let body_builder = L.builder_at_end context body_bb in
    let objptr = L.build_bitcast next objptr_t "objptr" body_builder in
    let sf = L.build_load (L.build_struct_gep objptr offset "" body_builder) ("this_" ^ name) body_builder in
    let id = L.build_load (L.build_struct_gep objptr 1 "id_ptr" body_builder) "id" body_builder in
    let next_ref = build_struct_assign (L.undef objref_t) [|Some id; Some next|] body_builder in
    ignore (L.build_call sf [|next_ref|] "" body_builder);
    ignore (L.build_br pred_bb body_builder);

    let merge_bb = L.append_block context "merge" step_gb in
    ignore (L.build_cond_br bool_val merge_bb body_bb pred_builder);
    ignore (L.build_ret_void (L.builder_at_end context merge_bb))
  in
  List.iter global_event ["step", 3; "draw", 5];

  the_module

(* think about how to check if destroyed. extra id field? then separate linked lists for diff obj types? *)
