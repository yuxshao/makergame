(* Semantic checking for the MicroC compiler *)

open Ast

module Filename = Core.Core_filename
module StringMap = Map.Make(String)

(* Raise an exception if the given list has a duplicate *)
let report_duplicate exceptf list =
  let rec helper = function
    | n1 :: n2 :: _ when n1 = n2 -> failwith (exceptf n1)
    | _ :: t -> helper t
    | [] -> ()
  in helper (List.sort compare list)

(* Raise an exception if a given binding is to a void type *)
let check_not_void exceptf = function
  | (n, Void) -> failwith (exceptf n)
  | _ -> ()

(* Add to the scope. But only if we're not using the identifier 'this' *)
(* TODO: mention where 'this'/super can be used. anywhere but assignment, declaration as a regular obj identifier *)
let add_to_scope ?loc m (n, t) =
  let failstr s = ("cannot shadow or overwrite identifier '" ^ s ^ "'") in
  match loc, n with
  | None,   "super" -> failwith (failstr "super")
  | None,   "this"  -> failwith (failstr "this")
  | Some l, "super" -> failwith ((failstr "super") ^ " in " ^ l)
  | Some l, "this"  -> failwith ((failstr "this") ^ " in " ^ l)
  | _ -> StringMap.add n t m

(* Raise an exception if the two types are unequal. *)
let check_assign_strict lvaluet rvalue rvaluet err =
  if lvaluet = rvaluet then (lvaluet, rvalue)
  else failwith err

let resolve_file f curr_dir =
  try
    (* Attempt to resolve filenames in the following fashion:
       1) If the path is absolute, load that.
       2) If the path is relative, try:
          a) The current directory of the file loading you.
          c) MAKERGAME_PATH
       TODO: document in LRM
    *)
    if Filename.is_absolute f then Filename.realpath f
    else
      let cdir_f = Filename.concat curr_dir f in
      let sdir_f = Filename.concat (Sys.getenv "MAKERGAME_PATH") f in
      if Sys.file_exists cdir_f then Filename.realpath cdir_f
      else if Sys.file_exists sdir_f then Filename.realpath sdir_f
      else raise Not_found
  with
  | Unix.Unix_error (e, _, _) ->
    failwith ("unable to open file \'" ^ f ^ "\' for namespace: \'" ^ Unix.error_message e ^ "\'")
  | Not_found | Sys_error _ ->
    failwith ("unable to open file \'" ^ f ^ "\' for namespace.")

(* Build an AST given a resolved filename. For use in namespaces for file-loading. *)
let ast_of_file f short_f =
  let channel =
    try open_in f
    with
    | Unix.Unix_error (e, _, _) ->
      failwith ("unable to open file \'" ^ f ^ "\' for namespace: \'" ^ Unix.error_message e ^ "\'")
    | Not_found | Sys_error _ ->
      failwith ("unable to open file \'" ^ f ^ "\' for namespace.")
  in
  try Parser.program Scanner.token (Lexing.from_channel channel)
  with Parsing.Parse_error -> failwith ("failed to parse file " ^ short_f)
;;

(* Access a namespace inside another namespace (top) through a chain. Prevent
   access to private namespaces.

   files should contain every file that could possibly be accessed in the
   chain. prev accumulates previous namespace accesses to detect loops. cname
   is a name for the chain in error messages. *)
let rec namespace_of_chain top prev files can_private chain cname =
  match chain with
  | [] -> top
  | hd :: tl ->
    (* Check for permissions and get the next namespace *)
    let inner_ns =
      let is_private, ns =
        try List.assoc hd top.Namespace.namespaces
        with Not_found ->
          failwith ("unrecognized namespace " ^ hd ^
                    " encountered when resolving " ^ cname)
      in
      if is_private && (not can_private)
      then failwith ("attempted access to private namespace " ^
                     hd ^ " in resolving " ^ cname)
      else ns
    in
    (* Check for loops using name reference. Update prev *)
    let prev' =
      if List.mem (top, chain) prev
      then failwith ("namespace " ^ cname ^ " never resolves")
      else (top, chain) :: prev
    in
    (* Recurse down depending on nature of next namespace *)
    let top', chain', private' =
      match inner_ns with
      | Namespace.Concrete c -> c, tl, false
      | Namespace.Alias a -> top, (a @ tl), true
      | Namespace.File f -> List.assoc f files, tl, false
    in
    namespace_of_chain top' prev' files private' chain' cname
;;

(* Semantic checking of a namespace. Returns checked AST if successful, throws
   an exception if something is wrong.

   - nname is used just for error output
   - forbidden_files are files that if opened would cause a circular dependency
   - files are a list of filename-namespace associations
   - curr_dir is used for resolving file opens in this namespace

   Check each inner namespace, global variable, function, and then gameobj. *)

let rec check_namespace (nname, namespace) forbidden_files files curr_dir =
  let { Namespace.variables = globals; functions ; gameobjs; namespaces = _ } = namespace in

  (**** Checking Namespaces ****)
  (* Add the standard namespace and mark private *)
  let namespace =
    if List.mem (resolve_file "std.mg" curr_dir) forbidden_files
    then namespace
    else
      let namespaces = ("std", (true, Namespace.File "std.mg")) :: namespace.Namespace.namespaces in
      { namespace with Namespace.namespaces }
  in

  report_duplicate (fun n -> "duplicate namespace " ^ nname ^ "::" ^ n)
    (List.map fst namespace.Namespace.namespaces);

  (* Check inner namespaces and populate list of files *)
  let namespace, files =
    let open Namespace in
    (* Check and update nested concrete namespaces *)
    let namespaces =
      let check_concrete = function
        | n, (p, Concrete ns) ->
          let (n, ns), _ = check_namespace (n, ns) forbidden_files files curr_dir in
          (n, (p, Concrete ns))
        | _ as ns -> ns
      in
      List.map check_concrete namespace.namespaces
    in
    let namespace = { namespace with namespaces } in
    (* Update list of file-namespace associations by opening each file namespace *)
    let check_file_ns (accum, ns_accum) = function
      | n, (is_private, File f) ->
        (* Convert to absolute file path and use that in the namespace reference now *)
        let abs_f = resolve_file f curr_dir in
        let f_dir = Filename.dirname abs_f in
        let new_accum =
          if List.mem_assoc abs_f accum then accum
          else
            let { main = file_prog; files = _ } = ast_of_file abs_f f in
            let new_forbidden =
              if List.mem abs_f forbidden_files
              then failwith ("circular file dependency with " ^ f)
              else abs_f :: forbidden_files
            in
            let (_, file_prog), files =
              check_namespace ("file-" ^ f, file_prog) new_forbidden accum f_dir
            in
            (abs_f, file_prog) :: files
        in
        new_accum, (n, (is_private, File abs_f)) :: ns_accum
      | _ as next_ns -> accum, (next_ns :: ns_accum)
    in
    let files, namespaces = List.fold_left check_file_ns (files, []) namespaces in
    (* undo the reverse from the fold_left. should be right either way but this has fewer changes *)
    let namespaces = List.rev namespaces in
    let namespace = { namespace with namespaces } in
    (* Verify that each alias indeed resolves to a namespace *)
    let () =
      let aliases =
        List.fold_left
          (fun a (_, (_, x)) -> match x with Alias chain -> chain :: a | _ -> a) []
          namespace.namespaces
      in
      let check_resolve chain =
        ignore (namespace_of_chain namespace [] files true chain (String.concat "::" chain))
      in
      List.iter check_resolve aliases
    in
    namespace, files
  in
  let namespace_of_chain chain =
    namespace_of_chain namespace [] files true chain (String.concat "::" chain)
  in

  (**** Checking Global Variables ****)

  List.iter (check_not_void (fun n -> "illegal void global " ^ nname ^ "::" ^ n)) globals;

  report_duplicate (fun n -> "duplicate global " ^ nname ^ "::" ^ n) (List.map fst globals);

  (**** Checking Functions ****)

  report_duplicate (fun n -> "duplicate function " ^ nname ^ "::" ^ n) (List.map fst functions);
  report_duplicate (fun n -> "duplicate gameobj " ^ nname ^ "::" ^ n) (List.map fst gameobjs);

  let global_functions =
    List.fold_left (add_to_scope ~loc:(nname ^ " function declarations"))
      StringMap.empty functions
  in

  (* TODO: stop using add_to_scope *)
  (* Check each gameobj declaration *)
  ignore (List.fold_left (add_to_scope ~loc:(nname ^ "gameobj declarations"))
            StringMap.empty gameobjs);

  let gameobj_decl (chain, s) =
    match (chain, s) with
    | _, "object" -> Gameobj.generic
    | _ ->
      try List.assoc s (namespace_of_chain chain).Namespace.gameobjs
      with Not_found -> failwith ("unrecognized game object " ^ nname ^ "::" ^ s)
  in
  let is_gameobj_parent p c =
    let pdecl = gameobj_decl p in
    let rec helper c =
      let decl = gameobj_decl c in
      if decl == pdecl then true
      else match decl.Gameobj.parent with
        | None -> false
        | Some c -> helper c
    in
    helper c
  in

  (* Raise an exception if the given rvalue type cannot be assigned to
     the given lvalue type, or else return a new expression with conversion. *)
  let check_assign lvaluet rvalue rvaluet err =
    match lvaluet, rvaluet with
    | Float, Int -> (Float, Conv(Float, rvalue, Int))
    | Int, Float -> (Int, Conv(Int, rvalue, Float))
    | Object p, Object c when is_gameobj_parent p c ->
      (Object p, Conv(Object p, rvalue, Object c))
    (* TODO: array conversions? e.g. int[3] to/from int[5]? int[3] to float[3]? *)
    | _ -> if lvaluet = rvaluet then (lvaluet, rvalue) else failwith err
  in

  (* Helper for getting a set of things from a gameobj and its parents. *)
  let rec gscope_helper name retrieve so_far loc =
    let chain, _ = name in
    let decl = gameobj_decl name in
    (* Physical equality as a kind of 'comparing handles' *)
    (if List.memq decl so_far
     then failwith ("inheritance cycle with " ^ string_of_chain name)
     else ());
    let indiv_scope =
      List.fold_left (add_to_scope ~loc:(nname ^ "::" ^ string_of_chain name ^ " " ^ loc))
        StringMap.empty (retrieve decl)
    in
    let parent_scope =
      match decl.Gameobj.parent with
      | Some (pchain, pname) ->
        gscope_helper ((chain @ pchain), pname) retrieve (decl :: so_far) loc
      | None -> StringMap.empty
    in
    StringMap.fold StringMap.add indiv_scope parent_scope
  in

  let gameobj_functions name =
    gscope_helper name (fun x -> x.Gameobj.methods) [] "method declarations"
  in

  let gameobj_scope name =
    gscope_helper name (fun x -> x.Gameobj.members) [] "members"
  in

  (* Object types from inner namespaces need to include the outer calling
     namespace to remain valid references. Anything expr that could resolve to a
     type defined in an inner namespace needs this added. *)
  let add_typ_ns chain = function
    | Object (c, n) -> Object (List.append chain c, n)
    | _ as t -> t
  in
  (* Check that the expression can indeed be assigned to *)
  let rec check_lvalue loc = function
    | Id([], "this") -> failwith ("'this' cannot be assigned in '" ^ loc ^ "'")
    | Id([], "super") -> failwith ("'super' cannot be assigned in '" ^ loc ^ "'")
    | Subscript(arr, _) -> check_lvalue loc arr (* subscr is lvalue iff arr is *)
    | Id _ | Member _ | Assign _ | Asnop _ | Idop _ -> ()
    | _ as e -> failwith ("lvalue " ^ string_of_expr e ^ " expected in " ^ loc)
  in
  (* Return the type of an expression and the new expression or throw an exception *)
  let rec expr scope e = match e with
    | Literal _ -> Int, e
    | BoolLit _ -> Bool, e
    | FloatLit _ -> Float, e
    | StringLit _ -> String, e
    | Conv(t1, e, _) ->
      let (t2, e') = expr scope e in
      check_assign t1 e' t2 ("Cannot convert " ^ string_of_typ t2 ^ " to " ^
                             string_of_typ t1 ^ " in " ^ string_of_expr e')
    | ArrayLit l ->
      (* Check array size and equality of element types *)
      (* TODO: in LRM say that implicit conversions do not apply to array literals *)
      (match l with
       | [] -> failwith ("illegal empty array " ^ string_of_expr e)
       | hd :: tl ->
         let (lt, hd') = expr scope hd in
         let tl' = List.map (fun l ->
             let t, e' = expr scope l in
             let _, e'' = check_assign_strict lt e' t
               ("array literal " ^ string_of_expr e ^
                " contains elements of unequal types "
                ^ string_of_typ lt ^ " and " ^ string_of_typ t)
             in e'') tl
         in
         Arr (lt, List.length l), ArrayLit(hd' :: tl'))
    | Binop(e1, op, _, e2) ->
      let (t1, e1') = expr scope e1 and (t2, e2') = expr scope e2 in
      let is_object t = match t with Object _ -> true | _ -> false in
      let err = "illegal binary operator " ^ string_of_typ t1 ^ " " ^ string_of_op op ^ " " ^
                string_of_typ t2 ^ " in " ^ string_of_expr e
      in
      (match op with
       | Add | Sub | Mult | Div when t1 = Int && t2 = Int -> Int, Binop(e1', op, Int, e2')
       | Add | Sub | Mult | Div when t1 = Float && t2 = Float -> Float, Binop(e1', op, Float, e2')
       | Add | Sub | Mult | Div when t1 = Float && t2 = Int ->
         let (_, e2'') = check_assign t1 e2' t2 err
         in Float, Binop(e1', op, Float, e2'')
       | Add | Sub | Mult | Div when t1 = Int && t2 = Float ->
         let (_, e1'') = check_assign t2 e1' t1 err
         in Float, Binop(e1'', op, Float, e2')
       (* TODO: mention in LRM that we are not converting bools *)
       (* TODO: string, obj equality *)
       | Equal | Neq when t1 = t2 && (t1 = Float || t1 = Int) -> Bool, Binop(e1', op, t1, e2')
       | Equal | Neq when is_object t1 && is_object t2 ->
         (match t1, t2 with
          | Object o1, Object o2 ->
            if is_gameobj_parent o1 o2
            then let (_, e2') = check_assign t1 e2' t2 err in Bool, Binop(e1', op, t1, e2')
            else let (_, e1') = check_assign t2 e1' t1 err in Bool, Binop(e1', op, t2, e2')
          | _ -> assert false)
       | Equal | Neq when t1 = Float && t2 = Int ->
         let (_, e2'') = check_assign t1 e2' t2 err
         in Bool, Binop(e1', op, Float, e2'')
       | Equal | Neq when t1 = Int && t2 = Float ->
         let (_, e1'') = check_assign t2 e1' t1 err
         in Bool, Binop(e1'', op, Float, e2')
       | Less | Leq | Greater | Geq when t1 = Int && t2 = Int -> Bool, Binop(e1', op, Int, e2')
       | Less | Leq | Greater | Geq when t1 = Float && t2 = Float -> Bool, Binop(e1', op, Float, e2')
       | Less | Leq | Greater | Geq when t1 = Float && t2 = Int ->
         let (_, e2'') = check_assign t1 e2' t2 err
         in Bool, Binop(e1', op, Float, e2'')
       | Less | Leq | Greater | Geq when t1 = Int && t2 = Float ->
         let (_, e1'') = check_assign t2 e1' t1 err
         in Bool, Binop(e1'', op, Float, e2')
       | And | Or when t1 = Bool && t2 = Bool -> Bool, Binop(e1', op, Bool, e2')
       | _ -> failwith err)
    | Unop(op, _, ex) -> let (t, ex') = expr scope ex in
      (match op, t with
       | Neg, Int | Neg, Float -> t, Unop(op, t, ex')
       | Not, Bool -> Bool, Unop(op, Bool, ex')
       | _ -> failwith ("illegal unary operator " ^ string_of_uop op ^
                        string_of_typ t ^ " in " ^ string_of_expr e))
    | Idop (opid, _, e1) ->
      check_lvalue (string_of_expr e) e1;
      let (t, e1') = expr scope e1 in
      (match t with
       | Int -> Int, Idop(opid, Int, e1')
       | Float -> Float, Idop(opid, Float, e1')
       | _ -> failwith ("illegal Increment/Decrement operator " ^
                        string_of_typ t ^ " " ^ string_of_idop opid))
    | Noexpr -> Void, e
    | Assign(l, r) ->
      check_lvalue (string_of_expr e) l;
      let (lt, l') = expr scope l and (rt, r') = expr scope r in
      let (t'', r'') = check_assign lt r' rt ("illegal assignment " ^ string_of_typ lt ^
                                              " = " ^ string_of_typ rt ^ " in " ^
                                              string_of_expr e)
      in t'', Assign(l', r'')
    | Asnop(e1, opasn, _, e2) ->
      check_lvalue (string_of_expr e1) e1;
      let (t1, e1') = expr scope e1 and (t2, e2') = expr scope e2 in
      (match t1, t2 with
       | Int, Int     -> Int,   Asnop(e1', opasn, Int, e2')
       | Float, Float -> Float, Asnop(e1', opasn, Float, e2')
       | _ -> failwith ("illegal assign operator " ^
                        string_of_typ t1 ^ " " ^ string_of_asnop opasn ^ " " ^
                        string_of_typ t2 ^ " in " ^ string_of_expr e))
    | Id (chain, name) ->
      let t =
        try match chain with
          | [] -> let vscope, _ = scope in StringMap.find name vscope
          | _ -> add_typ_ns chain (List.assoc name (namespace_of_chain chain).Namespace.variables)
        with Not_found -> failwith ("undeclared identifier " ^ (string_of_chain (chain, name)))
      in t, e
    | Subscript(arr, ind) ->
      let ind' =
        match expr scope ind with
        | Int, ind' -> ind'
        | _ -> failwith ("expected integer index " ^ string_of_expr ind ^
                         " in " ^ string_of_expr e)
      in
      let elem_type, arr' =
        match expr scope arr with
        | Arr (t, _), arr' -> t, arr'
        | _ -> failwith ("expected array " ^ string_of_expr arr ^
                         " in " ^ string_of_expr e)
      in
      elem_type, Subscript(arr', ind')
    | Member(e, _, name) ->
      (match expr scope e with
       | Object s, e' ->
         let t =
           try StringMap.find name (gameobj_scope s)
           with Not_found ->
             failwith ("undefined member " ^ name ^ " in " ^
                       string_of_expr e ^ " of type " ^ string_of_chain s)
         in
         let ochain, _ = s in add_typ_ns ochain t, Member(e', s, name)
       | _ -> failwith ("cannot get member of non-object " ^ (string_of_expr e)))
    | Call((chain, fname), actuals) as call ->
      let fd =
        try match chain with
          | [] -> let _, fscope = scope in StringMap.find fname fscope
          | _ -> List.assoc fname (namespace_of_chain chain).Namespace.functions
        with Not_found -> failwith ("unrecognized function " ^ (string_of_chain (chain, fname)))
      in
      let actuals' = check_call_actuals (string_of_expr call) actuals scope fd.Func.formals in
      add_typ_ns chain fd.Func.typ, Call((chain, fname), actuals')
    | MemberCall(e, _, fname, actuals) as call ->
      let fd, (ochain, oname), e' = match expr scope e with
        | Object s, e' ->
          (try StringMap.find fname (gameobj_functions s), s, e'
           with Not_found ->
             failwith ("undefined member " ^ fname ^ " in " ^
                       string_of_expr e ^ " of type " ^ string_of_chain s))
        | _ -> failwith ("cannot get member of non-object " ^ (string_of_expr e))
      in
      let actuals' = check_call_actuals (string_of_expr call) actuals scope fd.Func.formals in
      add_typ_ns ochain fd.Func.typ, MemberCall(e', (ochain, oname), fname, actuals')
    | Create(obj_type, actuals) ->
      let formals =
        try (List.assoc "create" (gameobj_decl obj_type).Gameobj.events).Func.formals
        with Not_found -> []
      in
      let actuals' = check_call_actuals (string_of_expr e) actuals scope formals in
      Object(obj_type), Create(obj_type, actuals')
    | Destroy(e, _) ->
      match expr scope e with
      | Object n, e' -> Void, Destroy(e', n)
      | _ -> failwith ("cannot destroy non-object")
  and check_call_actuals loc actuals scope formals =
    if List.length actuals != List.length formals then
      failwith ("expecting " ^ string_of_int (List.length formals) ^
                " arguments in " ^ loc)
    else
      List.map2
        (fun (_, ft) ex -> let (et, ex') = expr scope ex in
          let (_, ex'') = check_assign ft ex' et
              ("illegal actual argument found " ^ string_of_typ et ^
               " expected " ^ string_of_typ ft ^ " in " ^ string_of_expr ex) in ex'')
        formals actuals
  in

  let check_bool_expr scope e = let (t, e') = expr scope e in if t != Bool
    then failwith ("expected Boolean expression in " ^ string_of_expr e)
    else e' in

  let rec check_block ~scope ~name ~return block =
    (* TODO: say in LRM it's okay to duplicate locals/formals now *)
    (* TODO: clarify in LRM where STATIC scope starts and ends for decls *)

    (* Check duplicate locals *)
    List.fold_left
      (fun a n -> match n with Decl (n, _) -> n :: a | _ -> a) [] block
    |> report_duplicate
      (fun n -> "duplicate local '" ^ n ^ "' in single block of " ^ name);

    (* Verify a statement or throw an exception *)
    let rec stmt scope = function
      | Decl d as s ->
        let vscope, fscope = scope in
        (* Make sure it's actually an object *)
        (match d with | _, Object o -> ignore(gameobj_decl o) | _ -> ());
        check_not_void (fun n -> "illegal void local " ^ n ^ " in " ^ name) d;
        s, (add_to_scope ~loc:name vscope d, fscope)
      | Vdef((id, t), e) ->
        let (et, e') = expr scope e in
        let (_, e'') = check_assign t e' et ("illegal assignment " ^ string_of_typ t ^
                                             " = " ^ string_of_typ et ^ " in " ^
                                             string_of_expr e) in
        let vscope, fscope = scope in
        check_not_void (fun n -> "illegal void local " ^ n ^ " in " ^ name) (id, t);
        Vdef((id, t), e''), (add_to_scope ~loc:name vscope (id, t), fscope)
      | Break -> Break, scope
      | Block b -> Block (check_block b ~scope ~name ~return), scope
      | Expr e -> let (_, e') = expr scope e in Expr e', scope
      | Return e ->             (* TODO in LRM say stuff can follow returns *)
        let t, e' = expr scope e in
        let (_, e'') = check_assign return e' t ("return gives " ^ string_of_typ t ^ " expected " ^
                                                 string_of_typ return ^ " in " ^ string_of_expr e) in
        Return e'', scope
      | If(p, b1, b2) ->
        let (b1', _), (b2', _) = stmt scope b1, stmt scope b2 in
        If (check_bool_expr scope p, b1', b2'), scope
      | For(s1, e2, e3, st) ->
        let s1', scope' = stmt scope s1 in let e2' = check_bool_expr scope' e2 in
        let (_, e3') = expr scope' e3 in let st', _ = stmt scope' st in
        For (s1', e2', e3', st'), scope
      | While(p, s) ->
        let p' = check_bool_expr scope p in let s', _ = stmt scope s in
        While(p', s'), scope
      | Foreach(obj_t, id, s) ->
        ignore(gameobj_decl obj_t);
        let vscope, fscope = scope in
        let s', _ = stmt (StringMap.add id (Object(obj_t)) vscope, fscope) s in
        Foreach(obj_t, id, s'), scope
    in

    let _, block' =
      List.fold_left
        (fun (sym, accum) s -> let s', sym' = stmt sym s in (sym', s' :: accum))
        (scope, []) block
    in
    List.rev block'
  in
  let check_block ~scope ~name ~return block =
    List.iter
      (function Break ->
         failwith ("cannot break in top level block of " ^ name) | _ -> ())
      block;
    check_block ~scope ~name ~return block
  in

  let check_function ~scope ~objname (name, func) =
    let open Func in
    let loc = match objname with
      | Some objname -> nname ^ "::" ^ objname ^ "::" ^ name
      | None -> nname ^ "::" ^ name
    in
    List.iter
      (check_not_void (fun n -> "illegal void formal " ^ n ^ " in " ^ loc))
      func.formals;

    let scope =
      let vscope, fscope = scope in
      List.fold_left (add_to_scope ~loc:("formals of " ^ loc))
        vscope func.formals, fscope
    in

    (* formals can have the same name as locals. is this okay? think about these
       edge cases *)
    report_duplicate
      (fun n -> "duplicate formal " ^ n ^ " in " ^ loc)
      (List.map fst func.formals);

    let block =
      match func.block with
      | Some block ->
        Some (check_block ~scope ~name:loc ~return:func.typ block)
      | None -> None
    in
    name, { func with block = block }
  in

  let check_gameobj ~scope (name, obj) =
    let open Gameobj in
    report_duplicate
      (fun n -> "duplicate members " ^ n ^ " in " ^ name)
      (List.map fst obj.members);

    report_duplicate
      (fun n -> "duplicate methods " ^ n ^ " in " ^ name)
      (List.map fst obj.methods);

    report_duplicate
      (fun n -> "duplicate events " ^ n ^ " in " ^ name)
      (List.map fst obj.events);

    let valid_events = ["create"; "step"; "draw"; "destroy"] in
    let check_event (name, ev) =
      (* Precautionary checks that shouldn't happen b/c of parser *)
      match (name, ev.Func.formals, ev.Func.typ) with
      | name, _, Void when name = "create" -> ()
      | name, args, Void when List.mem name valid_events && args = [] -> ()
      | _ -> assert false
    in
    List.iter check_event obj.events;

    let obj_fn_list =
      let add_if_absent events evname =
        if not (List.mem_assoc evname events)
        then (evname, Func.make Void [] (Some name) []) :: events
        else events
      in
      List.fold_left add_if_absent obj.events valid_events
    in

    (* Add "this" and gameobj members to scope *)
    (* gameobj_scope also checks that no members are named 'this' *)
    (* gameobj_scope also checks that the parent, if set, exists *)
    (* For creation, also add super() *)
    let scope, create_scope =
      let initial_vscope, initial_fscope = scope in
      let super_scope =
        match obj.parent with
        | None | Some (_, "object") -> StringMap.empty
        | Some (pchain, pname) ->
          let func =
            let events = (gameobj_decl (pchain, pname)).events in
            if List.mem_assoc "create" events
            then List.assoc "create" events
            else Func.make Void [] (Some pname) []
          in
          StringMap.singleton "super" func
      in
      let vscope =
        initial_vscope
        |> StringMap.fold StringMap.add (gameobj_scope ([], name))
        |> StringMap.add "this" (Object([], name))
      in
      let fscope =
        initial_fscope
        |> StringMap.fold StringMap.add (gameobj_functions ([], name))
      in
      (vscope, fscope), (vscope, fscope |> StringMap.fold StringMap.add super_scope)
    in

    let check_obj_fn (fname, func) =
      match func.Func.block with
      | Some _ ->
        let scope =
          if fname = "create" then create_scope else scope
        in
        check_function ~scope ~objname:(Some name) (fname, func)
      | _ -> failwith ("illegal extern function " ^ nname ^ "::" ^ name ^ "::" ^ fname)
    in
    let methods' = List.map check_obj_fn obj.methods in
    let events' = List.map check_obj_fn obj_fn_list in
    make name (obj.members, methods', events') obj.parent
  in

  let scope =
    List.fold_left (add_to_scope ~loc:(nname ^ " globals")) StringMap.empty globals,
    global_functions
  in
  let functions = List.map (check_function ~objname:None ~scope) functions in
  let gameobjs = List.map (check_gameobj ~scope) gameobjs in
  let namespaces = namespace.Namespace.namespaces in

  (nname, { Namespace.variables = globals; functions; gameobjs; namespaces }), files

let check_program program =
  let (_, main), files = check_namespace ("", program.main) [] program.files (Sys.getcwd ()) in

  if not (List.mem_assoc "main" main.Namespace.gameobjs)
  then failwith "main game object must be defined"
  else { main; files }
