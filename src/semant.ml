(* Semantic checking for the MicroC compiler *)

open Ast

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
(* TODO: mention where 'this' can be used. anywhere but assignment but declaration as a regular obj identifier *)
let add_to_scope ?loc m (n, t) =
  let failstr = "cannot shadow or overwrite identifier 'this'" in
  match loc, n with
  | None, "this" -> failwith failstr
  | Some l, "this" -> failwith (failstr ^ " in " ^ l)
  | _ -> StringMap.add n t m

(* Raise an exception of the given rvalue type cannot be assigned to
   the given lvalue type *)
let check_assign lvaluet rvaluet err =
  if lvaluet = rvaluet then lvaluet else failwith err

(* Semantic checking of a program. Returns void if successful,
   throws an exception if something is wrong.

   Check each global variable, then check each function *)

let rec check_namespace (nname, { Namespace.variables = globals;
                                  functions ; gameobjs; namespaces }) =
  (**** Checking Global Variables ****)

  List.iter (check_not_void (fun n -> "illegal void global " ^ n)) globals;

  report_duplicate (fun n -> "duplicate global " ^ n) (List.map fst globals);

  (**** Checking Functions ****)

  (* Add built-in function declarations *)
  let functions =
    let add ~fname ~arg_type list =
      (fname, { typ = Void; formals = [("x", arg_type)]; block = None; gameobj = None }) :: list
    in
    functions
    |> add ~fname:"print"       ~arg_type:Int
    |> add ~fname:"printb"      ~arg_type:Bool
    |> add ~fname:"print_float" ~arg_type:Float
    |> add ~fname:"printstr"    ~arg_type:String
  in

  report_duplicate (fun n -> "duplicate function " ^ n) (List.map fst functions);
  report_duplicate (fun n -> "duplicate gameobj " ^ n) (List.map fst gameobjs);

  let global_functions =
    List.fold_left (add_to_scope ~loc:"function declarations")
      StringMap.empty functions
  in

  let gameobj_decls =
    List.fold_left (add_to_scope ~loc:"gameobj declarations")
      StringMap.empty gameobjs
  in

  let gameobj_decl s =
    try StringMap.find s gameobj_decls
    with Not_found -> failwith ("unrecognized game object " ^ s)
  in

  let gameobj_functions o =
    List.fold_left (add_to_scope ~loc:(o ^ " gameobj function declarations"))
      StringMap.empty (gameobj_decl o).Gameobj.methods
  in

  let gameobj_scope name =
    List.fold_left (add_to_scope ~loc:(name ^ " members"))
      StringMap.empty (gameobj_decl name).Gameobj.members
  in

  (* Check that the expression can indeed be assigned to *)
  let check_lvalue loc = function
    | Id("this") -> failwith ("'this' cannot be assigned in '" ^ loc ^ "'")
    | Id _ | Member _ | Assign _ -> ()
    | _ -> failwith ("LHS ineligible for assignment in " ^ loc)
  in
  (* Return the type of an expression and the new expression or throw an exception *)
  let rec expr scope e = match e with
    | Literal _ -> Int, e
    | BoolLit _ -> Bool, e
    | FloatLit _ -> Float, e
    | StringLit _ -> String, e
    | Id name ->
      (try let vscope, _ = scope in StringMap.find name vscope, e
      with Not_found -> failwith ("undeclared identifier " ^ name))
    | Member(e, _, name) ->
      (match expr scope e with
       | Object s, e' ->
         let t =
           try StringMap.find name (gameobj_scope s)
           with Not_found ->
             failwith ("undefined member " ^ name ^ " in " ^
                       string_of_expr e ^ " of type " ^ s)
         in
         t, Member(e', s, name)
       | _ -> failwith ("cannot get member of non-object " ^ (string_of_expr e)))
    | Binop(e1, op, _, e2) -> let (t1, e1') = expr scope e1 and (t2, e2') = expr scope e2 in
      (match op with
         Add | Sub | Mult | Div when t1 = Int && t2 = Int -> Int, Binop(e1', op, Int, e2')
       | Add | Sub | Mult | Div when t1 = Float && t2 = Float -> Float, Binop(e1', op, Float, e2')
       (* TODO: restrict allowed types for boolean comparison. e.g. should we support string equality? *)
       | Equal | Neq when t1 = t2  -> Bool, Binop(e1', op, t1, e2')
       | Less | Leq | Greater | Geq when t1 = Int && t2 = Int -> Bool, Binop(e1', op, Int, e2')
       | Less | Leq | Greater | Geq when t1 = Float && t2 = Float -> Bool, Binop(e1', op, Float, e2')
       | And | Or when t1 = Bool && t2 = Bool -> Bool, Binop(e1', op, Bool, e2')
       | _ -> failwith ("illegal binary operator " ^
                        string_of_typ t1 ^ " " ^ string_of_op op ^ " " ^
                        string_of_typ t2 ^ " in " ^ string_of_expr e)
      )
    | Unop(op, _, ex) -> let (t, ex') = expr scope ex in
      (match op with
         Neg when t = Int -> Int, Unop(op, Int, ex')
       | Neg when t = Int -> Float, Unop(op, Float, ex')
       | Not when t = Bool -> Bool, Unop(op, Bool, ex')
       | _ -> failwith ("illegal unary operator " ^ string_of_uop op ^
                        string_of_typ t ^ " in " ^ string_of_expr e))
    | Noexpr -> Void, e
    | Assign(l, r) ->
      check_lvalue (string_of_expr e) l;
      let (lt, l') = expr scope l and (rt, r') = expr scope r in
      check_assign lt rt ("illegal assignment " ^ string_of_typ lt ^
                          " = " ^ string_of_typ rt ^ " in " ^
                          string_of_expr e), Assign(l', r')
    | Call(fname, actuals) as call ->
      let fd =
        try let _, fscope = scope in StringMap.find fname fscope
        with Not_found -> failwith ("unrecognized function " ^ fname)
      in
      let actuals' = check_call_actuals (string_of_expr call) actuals scope fd in
      fd.typ, Call(fname, actuals')
    | MemberCall(e, _, fname, actuals) as call ->
      let fd, oname, e' = match expr scope e with
        | Object s, e' ->
          (try StringMap.find fname (gameobj_functions s), s, e'
           with Not_found ->
             failwith ("undefined member " ^ fname ^ " in " ^
                       string_of_expr e ^ " of type " ^ s))
        | _ -> failwith ("cannot get member of non-object " ^ (string_of_expr e))
      in
      let actuals' = check_call_actuals (string_of_expr call) actuals scope fd in
      fd.typ, MemberCall(e', oname, fname, actuals')
    | Create(obj_type) -> ignore(gameobj_decl obj_type); Object(obj_type), e
    | Destroy(e, _) ->
      match expr scope e with
      | Object n, e' -> Void, Destroy(e', n)
      | _ -> failwith ("cannot destroy non-object")
  and check_call_actuals loc actuals scope fd =
    if List.length actuals != List.length fd.formals then
      failwith ("expecting " ^
                string_of_int (List.length fd.formals) ^
                " arguments in " ^ loc)
    else
      List.map2
        (fun (_, ft) ex -> let (et, ex') = expr scope ex in
          ignore (check_assign ft et
                    ("illegal actual argument found " ^ string_of_typ et ^
                     " expected " ^ string_of_typ ft ^ " in " ^ string_of_expr ex)); ex')
        fd.formals actuals
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
        check_not_void (fun n -> "illegal void local " ^ n ^ " in " ^ name) d;
        s, (add_to_scope ~loc:name vscope d, fscope)
      | Break -> Break, scope
      | Block b -> Block (check_block b ~scope ~name ~return), scope
      | Expr e -> let (_, e') = expr scope e in Expr e', scope
      | Return e ->             (* TODO in LRM say stuff can follow returns *)
        let t, e' = expr scope e in
        if t = return then Return e', scope
        else failwith ("return gives " ^ string_of_typ t ^ " expected " ^
                       string_of_typ return ^ " in " ^ string_of_expr e)
      | If(p, b1, b2) ->
        let (b1', _), (b2', _) = stmt scope b1, stmt scope b2 in
        If (check_bool_expr scope p, b1', b2'), scope
      | For(e1, e2, e3, st) ->
        let (_, e1') = expr scope e1 in let e2' = check_bool_expr scope e2 in
        let (_, e3') = expr scope e3 in let st', _ = stmt scope st in
        For (e1', e2', e3', st'), scope
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

  let check_function ~scope (name, func) =
    List.iter
      (check_not_void (fun n -> "illegal void formal " ^ n ^ " in " ^ name))
      func.formals;

    let scope =
      let vscope, fscope = scope in
      List.fold_left (add_to_scope ~loc:("formals of " ^ name))
        vscope func.formals, fscope
    in

    (* formals can have the same name as locals. is this okay? think about these
       edge cases *)
    report_duplicate
      (fun n -> "duplicate formal " ^ n ^ " in " ^ name)
      (List.map fst func.formals);

    let block =
      match func.block with
      | Some block ->
        Some (check_block ~scope ~name ~return:func.typ block)
      | None -> None
    in
    name, { func with block = block }
  in

  let check_gameobj ~scope (name, obj) =
    let open Gameobj in
    let obj_fn_list obj =
      [("create", Gameobj.Create, obj.create);
       ("step", Gameobj.Step, obj.step);
       ("draw", Gameobj.Draw, obj.draw);
       ("destroy", Gameobj.Destroy, obj.destroy)]
    in

    report_duplicate
      (fun n -> "duplicate members " ^ n ^ " in " ^ name)
      (List.map fst obj.members);

    (* Add "this" and gameobj members to scope *)
    (* gameobj_scope also checks that no members are named 'this' *)
    let scope =
      let vscope, fscope = scope in
      StringMap.fold StringMap.add vscope (gameobj_scope name)
      |> StringMap.add "this" (Object(name)),
      StringMap.fold StringMap.add fscope (gameobj_functions name)
    in
    let check_obj_fn (fname, func) =
      match func.block with
      | Some _ -> check_function ~scope (fname, func)
      | _ -> failwith ("illegal extern function " ^ name ^ "::" ^ fname)
    in
    let check_event (fname, eventtype, block) =
      eventtype,
      check_block ~scope ~name:(name ^ "::" ^ fname) ~return:Void block
    in
    let methods' = List.map check_obj_fn obj.methods in
    let blocks' = List.map check_event (obj_fn_list obj) in
    make name (obj.members, methods', blocks')
  in

  let scope =
    List.fold_left (add_to_scope ~loc:"globals") StringMap.empty globals,
    global_functions
  in
  let functions = List.map (check_function ~scope) functions in
  let gameobjs = List.map (check_gameobj ~scope) gameobjs in

  (* add gameobj main if it doesn't exist but a void main() function does *)
  let gameobjs =
    if StringMap.mem "main" gameobj_decls
    then gameobjs
    else
      let undef_err = "either main game object or function must be defined" in
      let not_void_err = "main function must return void" in
      let arg_err = "main function must take no arguments" in
      let _, fn =
        try check_function ~scope ("main", (StringMap.find "main" global_functions))
        with Not_found -> failwith undef_err in
      let block =
        match fn.block with Some b -> b | None -> failwith undef_err
      in
      (match fn.typ with Void -> () | _ -> failwith not_void_err);
      (match fn.formals with [] -> () | _ -> failwith arg_err);
      (Gameobj.make "main" ([], [], [Gameobj.Create, block])) :: gameobjs
  in

  let namespaces = List.map check_namespace namespaces in

  nname, { Namespace.variables = globals; functions; gameobjs; namespaces }
