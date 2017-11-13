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
  let gameobj_types =
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
  let (gameobj_end, obj_ends) =
    let make_end name =
      let h = L.declare_global node_t (name ^ "_head") the_module in
      let t = L.declare_global node_t (name ^ "_tail") the_module in
      L.set_initializer (L.const_named_struct node_t [|t; t|]) h;
      L.set_initializer (L.const_named_struct node_t [|h; h|]) t;
      h, t
    in
    let add_end map name = StringMap.add name (make_end name) map in
    let names = List.map (fun x -> x.A.Gameobj.name) gameobjs in
    make_end "gameobj", List.fold_left add_end StringMap.empty names
  in
  let obj_end n = StringMap.find n obj_ends in
  (* TODO: test case for order where i destroy myself and create a thing *)

  let global_objid = L.define_global "last_objid" (L.const_int i64_t 0) the_module in

  let ltype_of_typ = function
    | A.Int -> i32_t
    | A.Bool -> i1_t
    | A.Float -> float_t
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

  let fn_decls functions obj to_llname =
    let function_decl m fdecl =
      let name = fdecl.A.fname in
      let formals =
        match obj with
        | Some o -> (A.Object(o), "this") :: fdecl.A.formals
        | None -> fdecl.A.formals
      in
      let formal_types = Array.of_list (List.map (fun (t,_) -> ltype_of_typ t) formals) in
      let ftype = L.function_type (ltype_of_typ fdecl.A.typ) formal_types in
      let d_function name =
        match fdecl.A.block with
        | Some _ -> L.define_function (to_llname name)
        | None -> L.declare_function name
      in
      StringMap.add name (d_function name ftype the_module, fdecl) m in
    List.fold_left function_decl StringMap.empty functions
  in

  (* Declare each global variable; remember its value in a map *)
  let global_vars =
    let var m (t, n) =
      let init = L.const_null (ltype_of_typ t)
      in StringMap.add n (L.define_global n init the_module, t) m
    in
    List.fold_left var StringMap.empty globals
  in
  let global_fns =
    let global_fn_to_llname name = "function." ^ name in
    fn_decls functions None global_fn_to_llname
  in

  (* Define each function (arguments and return type) so we can call it *)
  let obj_events =
    let event_to_llname gname ename = "object." ^ gname ^ ".event." ^ ename in
    let open A.Gameobj in
    let event_decls g =
      let add_decl m (f_name, _) =
        let name = event_to_llname g.name f_name in
        let llfn_t = L.function_type void_t [|ltype_of_typ (A.Object(g.name))|] in
        StringMap.add f_name (L.define_function name llfn_t the_module) m
      in
      List.fold_left add_decl StringMap.empty
        [("create", g.create); ("step", g.step); ("destroy", g.destroy); ("draw", g.draw)]
    in
    List.fold_left (fun m g -> StringMap.add g.name (event_decls g) m)
      StringMap.empty gameobjs
  in

  let obj_fns =
    let open A.Gameobj in
    let obj_fn_to_llname gname ename = "object." ^ gname ^ ".function." ^ ename in
    let add_decls m g =
      let decls = fn_decls g.methods (Some g.name) (obj_fn_to_llname g.name) in
      StringMap.add g.name decls m
    in
    List.fold_left add_decls StringMap.empty gameobjs
  in

  let find_function_decl name =
    try StringMap.find name global_fns
    with Not_found -> failwith ("global " ^ name)
  in
  let find_obj_fn_decl oname fname =
    try StringMap.find fname (StringMap.find oname obj_fns)
    with Not_found -> failwith ("obj " ^ oname ^ "." ^ fname)
  in
  let find_obj_event_decl oname event =
    try StringMap.find event (StringMap.find oname obj_events)
    with Not_found -> failwith ("event " ^ oname ^ "." ^ event)
  in

  (* Given value ll for an object of type objname, builds and returns scope of
     that object in StringMap. *)
  let gameobj_members objref objname builder =
    let llobj =
      let node = L.build_extractvalue objref 1 (objname ^ "_node") builder in
      let (obj_type, _) = StringMap.find objname gameobj_types in
      L.build_bitcast node (L.pointer_type obj_type) objname builder
    in
    let (_, objtype) = StringMap.find objname gameobj_types in
    let add_member (map, ind) (typ, name) =
      let member_var = L.build_struct_gep llobj ind name builder in
      (StringMap.add name (member_var, typ) map, ind + 1)
    in
    let (members, _) =
      (* object type struct: gameobj_t :: node_t :: members *)
      List.fold_left add_member (StringMap.empty, 2) objtype.A.Gameobj.members
    in
    members
  in

  let add_to_scope to_add scope = StringMap.fold StringMap.add scope to_add in

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
    (* TODO: add to front so not skipped in lookahead (think of as circular + marker) *)
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
    (* TODO: do only if prev and next actually connect to node *)
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

  (* let build_print fmt elems builder = *)
  (*   ignore (L.build_call printf_func *)
  (*             (Array.of_list (L.build_global_stringptr (fmt ^ "\n") "" builder *)
  (*                             :: elems)) "" builder) *)
  (* in *)
  (* let build_printstr str builder = *)
  (*   build_print "%s" [L.build_global_stringptr str "" builder] builder *)
  (* in *)

  let build_if ~pred ~then_ ?(else_ = (fun b _ -> b)) builder the_function =
    let bool_val = pred builder the_function in
    let merge_bb = L.append_block context "merge" the_function in

    let then_bb = L.append_block context "then" the_function in
    let then_builder = then_ (L.builder_at_end context then_bb) the_function in
    ignore (L.build_br merge_bb then_builder);

    let else_bb = L.append_block context "else" the_function in
    let else_builder = else_ (L.builder_at_end context else_bb) the_function in
    ignore (L.build_br merge_bb else_builder);

    ignore (L.build_cond_br bool_val then_bb else_bb builder);
    L.builder_at_end context merge_bb
  in

  (* Builds a while LLVM construct given a predicate construct (returning a bool
     llvalue and possibly some information to body) and a body construct. *)
  let build_while ~pred ~body builder the_function =
    let pred_bb = L.append_block context "while" the_function in
    let body_bb = L.append_block context "while_body" the_function in
    let merge_bb = L.append_block context "merge" the_function in
    ignore (L.build_br pred_bb builder);

    let pred_builder = L.builder_at_end context pred_bb in
    let bool_val, transfer = pred pred_builder the_function in

    let body_builder =
      body (L.builder_at_end context body_bb) merge_bb the_function transfer
    in
    ignore (L.build_br pred_bb body_builder);

    ignore (L.build_cond_br bool_val body_bb merge_bb pred_builder);
    L.builder_at_end context merge_bb
  in

  let build_node_loop builder the_function ~ends ~body =
    let head, tail = ends in
    (* Keep track of curr and next in case curr is modified when body is run. *)
    (* If something's added right in front of the iterator, it'll be skipped. To
       ensure adding right behind head is always safe, an empty tail node is
       added to ensure a space between the iterator and the end. *)
    let curr_ptr = L.build_alloca nodeptr_t "curr_ptr" builder in
    let next_ptr = L.build_alloca nodeptr_t "next_ptr" builder in
    ignore (L.build_store head curr_ptr builder);
    (* build_printstr "loop" builder; *)

    let next = L.build_load (L.build_struct_gep head 1 "" builder) "" builder in
    ignore (L.build_store next next_ptr builder);

    let check_head builder _ =
      (* Move forward one *)
      let curr = L.build_load next_ptr "curr" builder in
      let next =
        L.build_load (L.build_struct_gep curr 1 "" builder) "next" builder
      in

      (* let curr_int = L.build_ptrtoint curr i64_t "" builder in *)
      (* let next_int = L.build_ptrtoint next i64_t "" builder in *)
      (* let head_int = L.build_ptrtoint head i64_t "" builder in *)
      (* let tail_int = L.build_ptrtoint tail i64_t "" builder in *)
      (* build_print "%d %d %d %d" [curr_int; next_int; head_int; tail_int] builder; *)

      ignore (L.build_store curr curr_ptr builder);
      ignore (L.build_store next next_ptr builder);
      L.build_icmp L.Icmp.Ne curr head "cont" builder, curr
    in

    let move_tail builder _ =
      ignore (L.build_call list_rem_func [|tail|] "" builder);
      ignore (L.build_call list_add_func [|tail; head|] "" builder);
      builder
    in

    let body builder break_bb _ curr =
      let check_tail builder _ = L.build_icmp L.Icmp.Ne curr tail "cont" builder in
      let body builder _ = body builder break_bb curr in
      build_if builder the_function ~pred:check_tail ~then_:body ~else_:move_tail
    in
    build_while builder the_function ~pred:check_head ~body
  in

  let build_container_of container_t ?(cast=container_t) offset v name builder =
    let null = L.const_null (L.pointer_type container_t) in
    let offset = L.build_struct_gep null offset "offset" builder in
    let offsetint = L.build_ptrtoint offset i64_t "offsetint" builder in
    let intptr = L.build_ptrtoint v i64_t "intptr" builder in
    let intnew = L.build_sub intptr offsetint "intnew" builder in
    (* build_print "%d %d %d" [offsetint; intptr; intnew] builder; *)
    L.build_inttoptr intnew (L.pointer_type cast) name builder
  in

  let build_object_loop builder the_function ~objname ~body =
    let objtype, _ = StringMap.find objname gameobj_types in
    let body builder break_bb node =
      (* Calculating offsets to get the object pointer *)
      let obj = build_container_of objtype 1 node objname builder ~cast:node_t in

      let pred builder _ =
        (* Get values for the removal check *)
        let genobj = L.build_bitcast obj objptr_t (objname ^ "_gen") builder in
        let id = L.build_load (L.build_struct_gep genobj 1 "id_ptr" builder) "id" builder in
        (* build_print "%d" id builder; *)
        L.build_icmp L.Icmp.Ne id (L.const_null i64_t) "is_removed" builder
      in
      let then_ builder _ = body builder break_bb obj in
      build_if ~pred ~then_ builder the_function
    in
    build_node_loop builder the_function ~ends:(obj_end objname) ~body
  in

  (* Construct code for an expression used for assignment; return its value *)
  let rec lexpr (vscope, fscope) builder = function
    | A.Id n -> let v, _ = StringMap.find n vscope in v
    | A.Member(e, objname, n) ->
      let vscope = gameobj_members (expr (vscope, fscope) builder e) objname builder in
      lexpr (vscope, fscope) builder (A.Id(n))
    | A.Assign (l, r) ->
      let l', r' = lexpr (vscope, fscope) builder l, expr (vscope, fscope) builder r in
      ignore (L.build_store r' l' builder); l'
    | A.Addasn (l, t, r) ->
      let lp = lexpr (vscope, fscope) builder l in
      let le = L.build_load lp "le" builder in
      let re = expr(vscope, fscope) builder r in
      let sum =
        match t with
        | A.Int | A.Bool -> L.build_add le re "addAsn" builder
        | A.Float -> L.build_fadd le re "addAsn" builder
        | _ -> assert false
      in
      ignore (L.build_store sum lp builder); lp
    | _ -> assert false (* Semant should catch other illegal attempts at assignment *)
  (* Construct code for an expression; return its value *)
  and expr scope builder = function
    | A.Literal i -> L.const_int i32_t i
    | A.BoolLit b -> L.const_int i1_t (if b then 1 else 0)
    | A.StringLit l -> L.build_global_stringptr l "literal" builder
    | A.FloatLit f -> L.const_float float_t f
    | A.Noexpr -> L.const_int i32_t 0
    | A.Id n | A.Member (_, _, n) as e -> L.build_load (lexpr scope builder e) n builder
    | A.Assign _ as e -> L.build_load (lexpr scope builder e) "" builder
    | A.Addasn (e1, _ ,e2) as e -> L.build_load (lexpr scope builder e) "" builder
  (*      let e1' = expr scope builder e1
      and e2' = expr scope builder e2 in
      let (iadd, fadd) = L.build_add, L.build_fadd in
      let sum = (match t with A.Int | A.Bool -> iadd | A.Float -> fadd | _ -> assert false) e1' e2' "" builder in
  *)
    | A.Binop (e1, op, t, e2) ->
      let e1' = expr scope builder e1
      and e2' = expr scope builder e2 in
      let (iop, fop) = (match op with
          | A.Add     -> L.build_add, L.build_fadd
          | A.Sub     -> L.build_sub, L.build_fsub
          | A.Mult    -> L.build_mul, L.build_fmul
          | A.Div     -> L.build_sdiv, L.build_fdiv
          | A.Expo    -> failwith "not implemented"
          | A.Modulo  -> failwith "not implemented"
          | A.And     -> L.build_and, L.build_and (* TODO: SHOULD WE SHORT CIRCUIT? *)
          | A.Or      -> L.build_or, L.build_or
          | A.Equal   -> L.build_icmp L.Icmp.Eq, L.build_fcmp L.Fcmp.Oeq
          | A.Neq     -> L.build_icmp L.Icmp.Ne, L.build_fcmp L.Fcmp.One
          | A.Less    -> L.build_icmp L.Icmp.Slt, L.build_fcmp L.Fcmp.Olt
          | A.Leq     -> L.build_icmp L.Icmp.Sle, L.build_fcmp L.Fcmp.Ole
          | A.Greater -> L.build_icmp L.Icmp.Sgt, L.build_fcmp L.Fcmp.Ogt
          | A.Geq     -> L.build_icmp L.Icmp.Sge, L.build_fcmp L.Fcmp.Oge
        )
      in
      (match t with A.Int | A.Bool -> iop | A.Float -> fop | _ -> assert false) e1' e2' "tmp" builder
    | A.Unop(op, t, e) ->
      let e' = expr scope builder e in
      (match op with
         A.Neg     -> if t=A.Int then L.build_neg else L.build_fneg
       | A.Not     -> L.build_not) e' "tmp" builder
    | A.Call ("printstr", [e]) ->
      L.build_call printf_func
        [| fmt_str str_fmt_str builder; (expr scope builder e) |]
        "printf" builder
    | A.Call ("print", [e]) | A.Call ("printb", [e]) ->
      L.build_call printf_func
        [| fmt_str int_fmt_str builder; (expr scope builder e) |]
        "printf" builder
    | A.Call ("print_float", [e]) -> (* TODO: test this fn *)
      L.build_call printf_func
        [| fmt_str float_fmt_str builder; (expr scope builder e) |]
        "printf" builder
    (* TODO: unify print names and their tests *)
    | A.Call (f, act) ->
      let _, fscope = scope in
      let (fdef, fdecl) = StringMap.find f fscope in
      (* TODO: can arguments have side effects? what's the order-currently LtR *)
      let actuals = List.map (expr scope builder) act in
      let actuals =             (* Add 'this' argument if member function *)
        match fdecl.A.gameobj with
        | Some _ -> (expr scope builder (A.Id("this"))) :: actuals
        | None -> actuals
      in
      let result =
        match fdecl.A.typ with A.Void -> "" | _ -> f ^ "_result"
      in
      L.build_call fdef (Array.of_list actuals) result builder
    | A.MemberCall (e, objname, f, act) ->
      let (fdef, fdecl) = find_obj_fn_decl objname f in
      let obj = expr scope builder e in
      let actuals = List.map (expr scope builder) act in
      let result =
        match fdecl.A.typ with A.Void -> "" | _ -> f ^ "_result"
      in
      L.build_call fdef (Array.of_list (obj :: actuals)) result builder
    | A.Create objname ->
      let (objtype, _) = StringMap.find objname gameobj_types in
      let llobj = L.build_malloc objtype objname builder in
      let llnode = L.build_bitcast llobj nodeptr_t (objname ^ "_node") builder in
      let llobjnode =
        L.build_bitcast (L.build_struct_gep llobj 1 "" builder)
          nodeptr_t (objname ^ "_objnode") builder
      in
      let obj_head, _ = obj_end objname in let gameobj_head, _ = gameobj_end in
      ignore (L.build_call list_add_func [|llobjnode; obj_head|] "" builder);
      ignore (L.build_call list_add_func [|llnode; gameobj_head|] "" builder);
      let llid = L.build_load global_objid "old_id" builder in
      let llid = L.build_add llid (L.const_int i64_t 1) "new_id" builder in
      ignore (L.build_store llid global_objid builder);
      let events =
        ["create"; "step"; "destroy"; "draw"]
        |> List.map (fun event ->
            Some (L.build_bitcast (find_obj_event_decl objname event)
                    eventptr_t (objname ^ "_" ^ event) builder))
      in
      let llobj_gen = L.build_bitcast llobj objptr_t (objname ^ "_gen") builder in
      build_struct_ptr_assign llobj_gen (Array.of_list (None :: Some llid :: events)) builder;
      let objref = build_struct_assign (L.undef objref_t) [|Some llid; Some llnode|] builder in
      let create_event = match List.hd events with | Some ev -> ev | None -> assert false in
      (* TODO: include something in LRM about non-initialized values *)
      ignore (L.build_call create_event [|objref|] "" builder);
      objref
    | A.Destroy (e, objtype) ->
      (* Destruction is lazy in that it involves just removing the
         object-specific link from an node's neighbours (i.e. used for foreach)
         and setting id to 0. When the main event loop encounters an object with
         id 0, it looks ahead to the next node and deletes the current. Other
         loops ignore 0-id objects.

         This way, a kind of induction can show that there's always a forward
         path from such an object to the head of the list (its neighbours don't
         point to it, but it still points to what it thinks are its neighbours
         have a forward path). So a loop like a foreach that might end up on a
         dead object still behaves well. The main event loop is guaranteed to
         run outside of any other loops, so it's safe to actually delete the
         nodes there. *)
      (* TODO: describe setup and effects in LRM. destroyed objs are immediately
         invisible to loops but refs to them still work until at least end of
         event. *)
      let objref = expr scope builder e in
      let node = L.build_extractvalue objref 1 "node" builder in
      let _ =
        (* Call its destroy event *)
        let objptr = L.build_bitcast node objptr_t "objptr" builder in
        let destroy_event = L.build_load (L.build_struct_gep objptr 4 "" builder) "event" builder in
        ignore (L.build_call destroy_event [|objref|] "" builder);
        (* Mark its id as 0 *)
        let idptr = L.build_struct_gep objptr 1 (objtype ^ "_id") builder in
        ignore (L.build_store (L.const_int i64_t 0) idptr builder)
      in
      (* Find the list node connecting objects of this particular type *)
      let llobjt, _ = StringMap.find objtype gameobj_types in
      let obj = L.build_bitcast node (L.pointer_type llobjt) objtype builder in
      (* Disconnect particular object neighbours' node links. *)
      let objnode = L.build_struct_gep obj 1 (objtype ^ "_node") builder in
      ignore (L.build_call list_rem_func [|objnode|] "" builder);
      expr scope builder (A.Noexpr) (* considered Void in semant *)
  in

  (* Build the code for the given statement, given the following:
     - the encapsulating function llvalue
     - the block to jump to in the case of a break
     - the return type
     - the builder to start at
     - the current scope.
     Returns the builder for the statement's successor. Builder is
     guaranteed to point to a block without a terminator. *)
  let rec stmt fn break_bb ret_t (builder, scope) = function
    | A.Decl (typ, name) ->
      let vscope, fscope = scope in
      let local_var = L.build_alloca (ltype_of_typ typ) name builder in
      builder, (StringMap.add name (local_var, typ) vscope, fscope)
    | A.Block b ->
      let merge_bb = L.append_block context "block_end" fn in
      let builder, _ =
        List.fold_left (stmt fn break_bb ret_t) (builder, scope) b
      in
      ignore (L.build_br merge_bb builder);
      L.builder_at_end context merge_bb, scope
    | A.Expr e -> ignore (expr scope builder e); builder, scope
    | A.Break -> ignore (L.build_br break_bb builder);
      let dead_bb = L.append_block context "postbreak" fn in
      L.builder_at_end context dead_bb, scope
    | A.Return e ->
      ignore (match ret_t with
          | A.Void -> L.build_ret_void builder
          | _ -> L.build_ret (expr scope builder e) builder);
      let dead_bb = L.append_block context "postret" fn in
      L.builder_at_end context dead_bb, scope
    | A.If (predicate, then_stmt, else_stmt) ->
      let run st b _ = fst (stmt fn break_bb ret_t (b, scope) st) in
      build_if builder fn ~then_:(run then_stmt) ~else_:(run else_stmt)
        ~pred:(fun b _ -> expr scope b predicate),
      scope
    | A.While (predicate, body) ->
      build_while builder fn
        ~pred:(fun b _ -> expr scope b predicate, ())
        ~body:(fun b br _ () -> fst (stmt fn br ret_t (b, scope) body)), scope
    | A.For (e1, e2, e3, body) ->
      let while_stmts = [A.Expr e1; A.While (e2, A.Block [body; A.Expr e3])] in
      let for_builder, _ =
        stmt fn break_bb ret_t (builder, scope) (A.Block while_stmts)
      in
      for_builder, scope
    | A.Foreach (objname, name, body_stmt) ->
      (* TODO: describe semantics. what if obj of type is destroyed or created in this? *)
      let body builder break_bb node =
        let objptr = L.build_bitcast node objptr_t "objptr" builder in
        let id = L.build_load (L.build_struct_gep objptr 1 "" builder) "id" builder in
        let obj = build_struct_assign (L.undef objref_t) [|Some id; Some node|] builder in
        let objref = L.build_alloca objref_t "ref" builder in
        ignore (L.build_store obj objref builder);
        let builder, _ =
          let vscope, fscope = scope in
          let vscope' = StringMap.add name (objref, A.Object(objname)) vscope in
          stmt fn break_bb ret_t (builder, (vscope', fscope)) body_stmt
        in
        builder
      in
      build_object_loop builder fn ~objname ~body, scope
  in

  let build_function_body the_function formals block ?gameobj return_type =
    let entry = L.entry_block the_function in
    let builder = L.builder_at_end context entry in

    (* If this is a function in a gameobj, add 'this' to the arguments *)
    let formals =
      match gameobj with
      | Some obj -> (A.Object(obj), "this") :: formals
      | None -> formals
    in
    let formal_scope =
      let add_formal m (t, n) p =
        L.set_value_name n p;
        let local = L.build_alloca (ltype_of_typ t) n builder in
        ignore (L.build_store p local builder);
        StringMap.add n (local, t) m
      in
      List.fold_left2 add_formal StringMap.empty formals
        (Array.to_list (L.params the_function))
    in
    let member_scope =
      match gameobj with
      | Some obj ->
        let this, _ = StringMap.find "this" formal_scope in
        let this = L.build_load this "thisref" builder in
        gameobj_members this obj builder
      | None -> StringMap.empty
    in
    let scope =
      global_vars |> add_to_scope member_scope |> add_to_scope formal_scope,
      match gameobj with
      | Some obj -> StringMap.fold StringMap.add (StringMap.find obj obj_fns) global_fns
      | _ -> global_fns
    in

    let builder, _ =
      stmt the_function entry return_type (builder, scope) (A.Block(block))
    in

    (* Add a precautionary return to the end *)
    ignore (match return_type with
        | A.Void -> L.build_ret_void builder
        | t -> L.build_ret (L.const_null (ltype_of_typ t)) builder)
  in

  let build_function { A.block; fname; formals; typ; gameobj = _ } =
    match block with
    | Some block ->
      let llfn, _ = find_function_decl fname in
      build_function_body llfn formals block typ
    | None -> ()
  in
  List.iter build_function functions;

  let build_obj_functions g =
    let open A.Gameobj in
    let build_fn { A.typ; fname; formals; block; gameobj = _ } =
      let llfn, _ = find_obj_fn_decl g.name fname in
      match block with
      | Some block -> build_function_body llfn formals block typ ~gameobj:g.name
      | None -> assert false    (* Semant ensures obj fns are not external *)
    in
    List.iter build_fn g.methods
  in
  List.iter build_obj_functions gameobjs;

  let build_obj_events g =
    let open A.Gameobj in
    let build_fn (f_name, block) =
      let llfn = find_obj_event_decl g.name f_name in
      build_function_body llfn [] block A.Void ~gameobj:g.name
    in
    List.iter build_fn [("create", g.create); ("step", g.step); ("destroy", g.destroy); ("draw", g.draw)]
  in
  List.iter build_obj_events gameobjs;

  let create_gb = L.define_function "global_create" (L.function_type void_t [||]) the_module in
  build_function_body create_gb [] [A.Expr (A.Create "main")] A.Void;

  (* TODO: test destroy self, next. destroy in foreach *)
  let global_event (name, offset) =
    let fn = L.define_function ("global_" ^ name) (L.function_type void_t [||]) the_module in
    let builder = L.builder_at_end context (L.entry_block fn) in
    let body builder _ node =
      let objptr = L.build_bitcast node objptr_t "objptr" builder in
      let id = L.build_load (L.build_struct_gep objptr 1 "id_ptr" builder) "id" builder in

      let pred b _ = L.build_icmp L.Icmp.Ne id (L.const_null i64_t) "is_removed" b in

      let call b _ =
        let this_fn =
          L.build_load (L.build_struct_gep objptr offset "" b) ("this_" ^ name) b
        in
        let objref = build_struct_assign (L.undef objref_t) [|Some id; Some node|] b in
        ignore (L.build_call this_fn [|objref|] "" b); b
      in

      let remove b _ =
        ignore (L.build_call list_rem_func [|node|] "" b);
        ignore (L.build_store (L.const_null node_t) node b); (* for safety/faster errors *)
        ignore (L.build_free node b); b
      in

      build_if ~pred ~then_:call ~else_:remove builder fn
    in
    let builder = build_node_loop builder fn ~ends:gameobj_end ~body in
    ignore (L.build_ret_void builder)
  in
  List.iter global_event ["step", 3; "draw", 5];

  the_module

(* think about how to check if destroyed. extra id field? then separate linked lists for diff obj types? *)
