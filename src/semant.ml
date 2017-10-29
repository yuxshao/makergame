(* Semantic checking for the MicroC compiler *)

open Ast

module StringMap = Map.Make(String)

(* Semantic checking of a program. Returns void if successful,
   throws an exception if something is wrong.

   Check each global variable, then check each function *)

let check ((globals, functions, game_objs) : Ast.program) =

  (* TODO: replace raise (Failure (...)) with failwith *)
  (* Raise an exception if the given list has a duplicate *)
  let report_duplicate exceptf list =
    let rec helper = function
      | n1 :: n2 :: _ when n1 = n2 -> failwith (exceptf n1)
      | _ :: t -> helper t
      | [] -> ()
    in helper (List.sort compare list)
  in

  (* Raise an exception if a given binding is to a void type *)
  let check_not_void exceptf = function
    | (Void, n) -> failwith (exceptf n)
    | _ -> ()
  in

  (* Raise an exception of the given rvalue type cannot be assigned to
     the given lvalue type *)
  let check_assign lvaluet rvaluet err =
    if lvaluet == rvaluet then lvaluet else failwith err
  in

  (**** Checking Global Variables ****)

  List.iter (check_not_void (fun n -> "illegal void global " ^ n)) globals;

  report_duplicate (fun n -> "duplicate global " ^ n) (List.map snd globals);

  (**** Checking Functions ****)

  if List.mem "print" (List.map (fun fd -> fd.fname) functions)
  then failwith "function print may not be defined" else ();

  (* Add built-in function declarations *)
  let functions =
    let add ~fname ~arg_type =
      List.cons { typ = Void; fname; formals = [(arg_type, "x")]; block = None }
    in
    functions
    |> add ~fname:"print"       ~arg_type:Int
    |> add ~fname:"printb"      ~arg_type:Bool
    |> add ~fname:"print_float" ~arg_type:Float
    |> add ~fname:"printstr"    ~arg_type:String
  in

  report_duplicate (fun n -> "duplicate function " ^ n)
    (List.map (fun fd -> fd.fname) functions);

  let function_decls =
    List.fold_left (fun m fd -> StringMap.add fd.fname fd m) StringMap.empty functions
  in

  let game_obj_decls =
    List.fold_left (fun m obj -> StringMap.add obj.name obj m) StringMap.empty game_objs
  in

  let function_decl s =
    try StringMap.find s function_decls
    with Not_found -> failwith ("unrecognized function " ^ s)
  in

  let game_obj_decl s =
    try StringMap.find s game_obj_decls
    with Not_found -> failwith ("unrecognized game object " ^ s)
  in

  let _ = function_decl "main" in (* Ensure "main" is defined *)

  let check_block ~symbols ~func block =
    List.iter
      (check_not_void (fun n -> "illegal void local " ^ n ^ " in " ^ func.fname))
      block.locals;

    report_duplicate
      (fun n -> "duplicate local " ^ n ^ " in " ^ func.fname)
      (List.map snd block.locals);

    let symbols =
      List.fold_left (fun m (t, n) -> StringMap.add n t m) symbols block.locals
    in

    (* Type of each variable (global, formal, or local *)
    let type_of_identifier s =
      try StringMap.find s symbols
      with Not_found -> failwith ("undeclared identifier " ^ s)
    in

    (* Return the type of an expression or throw an exception *)
    let rec expr = function
      | Literal _ -> Int
      | BoolLit _ -> Bool
      | FloatLit _ -> Float
      | StringLit _ -> String
      | Id s -> type_of_identifier s
      | Binop(e1, op, e2) as e -> let t1 = expr e1 and t2 = expr e2 in
        (match op with
           Add | Sub | Mult | Div when t1 = Int && t2 = Int -> Int
         | Equal | Neq when t1 = t2 -> Bool
         | Less | Leq | Greater | Geq when t1 = Int && t2 = Int -> Bool
         | And | Or when t1 = Bool && t2 = Bool -> Bool
         | _ -> failwith ("illegal binary operator " ^
                          string_of_typ t1 ^ " " ^ string_of_op op ^ " " ^
                          string_of_typ t2 ^ " in " ^ string_of_expr e)
        )
      | Unop(op, e) as ex -> let t = expr e in
        (match op with
           Neg when t = Int -> Int
         | Not when t = Bool -> Bool
         | _ -> failwith ("illegal unary operator " ^ string_of_uop op ^
                          string_of_typ t ^ " in " ^ string_of_expr ex))
      | Noexpr -> Void
      | Assign(var, e) as ex -> let lt = type_of_identifier var
        and rt = expr e in
        check_assign lt rt ("illegal assignment " ^ string_of_typ lt ^
                            " = " ^ string_of_typ rt ^ " in " ^ 
                            string_of_expr ex)
      | Call(fname, actuals) as call -> let fd = function_decl fname in
        if List.length actuals != List.length fd.formals then
          failwith ("expecting " ^
                    string_of_int (List.length fd.formals) ^
                    " arguments in " ^ string_of_expr call)
        else
          List.iter2
            (fun (ft, _) e -> let et = expr e in
              ignore (check_assign ft et
                        ("illegal actual argument found " ^ string_of_typ et ^
                         " expected " ^ string_of_typ ft ^ " in " ^ string_of_expr e)))
            fd.formals actuals;
        fd.typ
    in

    let check_bool_expr e = if expr e != Bool
      then failwith ("expected Boolean expression in " ^ string_of_expr e)
      else () in

    (* Verify a statement or throw an exception *)
    let rec stmt = function
      | Block sl -> let rec check_block = function
            [Return _ as s] -> stmt s
          | Return _ :: _ -> failwith "nothing may follow a return"
          | Block sl :: ss -> check_block (sl @ ss)
          | s :: ss -> stmt s ; check_block ss
          | [] -> ()
        in check_block sl
      | Expr e -> ignore (expr e)
      | Return e -> let t = expr e in if t = func.typ then () else
          failwith ("return gives " ^ string_of_typ t ^ " expected " ^
                    string_of_typ func.typ ^ " in " ^ string_of_expr e)

      | If(p, b1, b2) -> check_bool_expr p; stmt b1; stmt b2
      | For(e1, e2, e3, st) -> ignore (expr e1); check_bool_expr e2;
        ignore (expr e3); stmt st
      | While(p, s) -> check_bool_expr p; stmt s
      | Foreach(obj_t, _id, s) -> ignore(game_obj_decl obj_t); stmt s
    in

    stmt (Block block.body)

  in
  let check_function ~symbols func =
    List.iter
      (check_not_void (fun n -> "illegal void formal " ^ n ^ " in " ^ func.fname))
      func.formals;

    let symbols = List.fold_left (fun m (t, n) -> StringMap.add n t m) symbols func.formals in

    (* formals can have the same name as locals. is this okay? think about these
       edge cases *)
    report_duplicate
      (fun n -> "duplicate formal " ^ n ^ " in " ^ func.fname)
      (List.map snd func.formals);

    match func.block with
    | Some block -> check_block ~symbols ~func block
    | None -> ()
  in
  let symbols = List.fold_left (fun m (t, n) -> StringMap.add n t m) StringMap.empty globals in
  List.iter (check_function ~symbols) functions
