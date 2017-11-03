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
  and i32_t    = L.i32_type    context
  and i8_t     = L.i8_type     context
  and i1_t     = L.i1_type     context
  (* TODO: tests for floating point parsing/scanning, printing *)
  and float_t  = L.double_type context (* TODO: fix LRM to say double precision *)
  and sprite_t = L.pointer_type (L.named_struct_type context "sfSprite")
  and sound_t  = L.pointer_type (L.named_struct_type context "sfSound")
  and void_t   = L.void_type   context in

  let gameobj_types =          (* TODO: test. *)
    let lltype_of m gdecl =
      let name = gdecl.A.Gameobj.name in
      StringMap.add name (L.named_struct_type context name, gdecl) m
    in
    List.fold_left lltype_of StringMap.empty gameobjs
  in

  let ltype_of_typ = function
    | A.Int -> i32_t
    | A.Bool -> i1_t
    | A.Float -> float_t        (* FIXME: FLOAT OPERATIONS DISALLOWED & UNSUPPORTED. *)
    | A.Arr _ -> failwith "not implemented"
    | A.String -> L.pointer_type i8_t
    (* | A.Arr (typ, len) -> L.array_type (ltype_of_typ typ) len *)
    | A.Sprite -> sprite_t
    | A.Sound -> sound_t
    | A.Object o -> let (t, _) = StringMap.find o gameobj_types in L.pointer_type t
    | A.Void -> void_t
  in

  StringMap.iter
    (fun _ (t, gdecl) ->
       let members = gdecl.A.Gameobj.members in
       let ll_members = List.map (fun (typ, _) -> ltype_of_typ typ) members in
       L.struct_set_body t (Array.of_list ll_members) false)
    gameobj_types;

  (* Declare each global variable; remember its value in a map *)
  let global_vars =
    let global_var m (t, n) =
      let init = L.const_null (ltype_of_typ t)
      in StringMap.add n (L.define_global n init the_module, t) m in
    List.fold_left global_var StringMap.empty globals in

  let gameobj_members ll objname builder = (* TODO: test member access; try accessing nonexistent *)
    let (_, objtype) = StringMap.find objname gameobj_types in
    let add_member (map, ind) (typ, name) =
      let member_var = L.build_struct_gep ll ind name builder in
      (StringMap.add name (member_var, typ) map, ind + 1)
    in
    let (members, _) =
      List.fold_left add_member (StringMap.empty, 0) objtype.A.Gameobj.members
    in
    members
  in

  (* Declare printf(), which the print built-in function will call *)
  let printf_t = L.var_arg_function_type i32_t [| L.pointer_type i8_t |] in
  let printf_func = L.declare_function "printf" printf_t the_module in

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
    List.fold_left function_decl StringMap.empty functions in

  (* Fill in the body of the given function *)
  let build_function_body the_function formals block return_type =
    let builder = L.builder_at_end context (L.entry_block the_function) in

    let int_format_str   = L.build_global_stringptr "%d\n" "fmt" builder in
    let float_format_str = L.build_global_stringptr "%f\n" "fmt" builder in
    let str_format_str   = L.build_global_stringptr "%s\n" "fmt" builder in

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

      let add = StringMap.union (fun _ f _ -> Some f) in
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
          let lltop = L.build_load top n builder in
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
      | A.Binop (e1, op, e2) ->
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
      | A.Unop(op, e) ->
        let e' = expr builder e in
        (match op with
           A.Neg     -> L.build_neg
         | A.Not     -> L.build_not) e' "tmp" builder
      | A.Assign ((hd, tl), e) -> let e' = expr builder e in
        ignore (L.build_store e' (lookup builder scope hd tl) builder); e'
      | A.Call ("printstr", [e]) ->
        L.build_call printf_func [| str_format_str; (expr builder e) |] "printf" builder
      | A.Call ("print", [e]) | A.Call ("printb", [e]) ->
        L.build_call printf_func [| int_format_str ; (expr builder e) |] "printf" builder
      | A.Call ("print_float", [e]) -> (* TODO: test this fn *)
        L.build_call printf_func [| float_format_str ; expr builder e |] "printf" builder
      (* TODO: unify print names and their tests *)
      | A.Call (f, act) ->
        let (fdef, fdecl) = StringMap.find f function_decls in
        (* TODO: can arguments have side effects? what's the order-currently LtR *)
        let actuals = List.map (expr builder) act in
        let result =
          match fdecl.A.typ with A.Void -> "" | _ -> f ^ "_result"
        in
        L.build_call fdef (Array.of_list actuals) result builder
    in

    (* Invoke "f builder" if the current block doesn't already
       have a terminal (e.g., a branch). *)
    let add_terminal builder f =
      match L.block_terminator (L.insertion_block builder) with
        Some _ -> ()
      | None -> ignore (f builder) in

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

  let build_gameobj_fns g =     (* TODO: test *)
    let open A.Gameobj in
    let build_fn (f_name, block) =
      let llfn_t = L.function_type void_t [|ltype_of_typ (A.Object(g.name))|] in
      let llfn = L.define_function (g.name ^ "_" ^ f_name) llfn_t the_module in
      build_function_body llfn [A.Object(g.name), "this"] block A.Void
    in
    List.iter build_fn [("create", g.create); ("step", g.step); ("destroy", g.destroy); ("draw", g.draw)]
  in

  List.iter build_function functions;
  List.iter build_gameobj_fns gameobjs;
  the_module
