(* Semantic checking for the MicroC compiler *)

open Ast

module StringMap = Map.Make(String)

(* Semantic checking of a program. Returns void if successful,
   throws an exception if something is wrong.

   Check each global variable, then check each function *)

let check ((globals, functions, gameobjs) : Ast.program) =

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
    let add ~fname ~arg_type list =
      { typ = Void; fname; formals = [(arg_type, "x")]; block = None } :: list
    in
    functions
    |> add ~fname:"print"       ~arg_type:Int
    |> add ~fname:"printb"      ~arg_type:Bool
    |> add ~fname:"print_float" ~arg_type:Float
    |> add ~fname:"printstr"    ~arg_type:String
  in

  report_duplicate (fun n -> "duplicate function " ^ n)
    (List.map (fun fd -> fd.fname) functions);

  report_duplicate (fun n -> "duplicate gameobj " ^ n)
    (List.map (fun fd -> fd.Gameobj.name) gameobjs);

  let function_decls =
    List.fold_left (fun m fd -> StringMap.add fd.fname fd m) StringMap.empty functions
  in

  let gameobj_decls =
    List.fold_left (fun m obj -> StringMap.add obj.Gameobj.name obj m) StringMap.empty gameobjs
  in

  let function_decl s =
    try StringMap.find s function_decls
    with Not_found -> failwith ("unrecognized function " ^ s)
  in

  let gameobj_decl s =
    try StringMap.find s gameobj_decls
    with Not_found -> failwith ("unrecognized game object " ^ s)
  in

  let new_gameobjs =
    if StringMap.mem "main" gameobj_decls
    then gameobjs
    else
      let undef_err = "either main game object or function must be defined" in
      let not_void_err = "main function must return void" in
      let arg_err = "main function must take no arguments" in
      let fn =
        try StringMap.find "main" function_decls
        with Not_found -> failwith undef_err in
      let block =
        match fn.block with Some b -> b | None -> failwith undef_err
      in
      (match fn.typ with Void -> () | _ -> failwith not_void_err);
      (match fn.formals with [] -> () | _ -> failwith arg_err);
      (Gameobj.make "main" [] [Gameobj.Create, block]) :: gameobjs
  in

  let check_block ~symbols ~name ~return block =
    List.iter
      (check_not_void (fun n -> "illegal void local " ^ n ^ " in " ^ name))
      block.locals;

    report_duplicate
      (fun n -> "duplicate local " ^ n ^ " in " ^ name)
      (List.map snd block.locals);

    let with_binds = List.fold_left (fun m (t, n) -> StringMap.add n t m) in

    let symbols = with_binds symbols block.locals in

    (* Type of each variable (global, formal, local), maybe with member chain *)
    let rec type_of_identifier ~symbols (name, chain) =
      let typ =
        try StringMap.find name symbols
        with Not_found -> failwith ("undeclared identifier " ^ name)
      in
      match chain with
      | [] -> typ
      | hd :: tl ->
        match typ with
        | Object s ->
          let o = gameobj_decl s in
          let symbols = with_binds StringMap.empty o.Gameobj.members in
          type_of_identifier (hd, tl) ~symbols
        | _ -> failwith ("cannot get member of non-object " ^ name)
    in

    (* Return the type of an expression and the new expression or throw an exception *)
    let rec expr e = match e with 
      | Literal _ -> Int, e 
      | BoolLit _ -> Bool, e
      | FloatLit _ -> Float, e
      | StringLit _ -> String, e
      | Id(hd, tl) -> type_of_identifier ~symbols (hd, tl), e
      | Binop(e1, op, _, e2) -> let (t1, e1') = expr e1 and (t2, e2') = expr e2 in
        (match op with
           Add | Sub | Mult | Div when t1 = Int && t2 = Int -> Int, Binop(e1', op, Int, e2')
         | Add | Sub | Mult | Div when t1 = Float && t2 = Float -> Int, Binop(e1', op, Float, e2')
         | Equal | Neq when t1 = t2  -> Bool, Binop(e1', op, t1, e2')
         | Less | Leq | Greater | Geq when t1 = Int && t2 = Int -> Bool, Binop(e1', op, Int, e2')
         | Less | Leq | Greater | Geq when t1 = Float && t2 = Float -> Bool, Binop(e1', op, Float, e2')         
         | And | Or when t1 = Bool && t2 = Bool -> Bool, Binop(e1', op, Bool, e2')
         | _ -> failwith ("illegal binary operator " ^
                          string_of_typ t1 ^ " " ^ string_of_op op ^ " " ^
                          string_of_typ t2 ^ " in " ^ string_of_expr e)
        )
      | Unop(op, _, ex) -> let (t, ex') = expr ex in
        (match op with
           Neg when t = Int -> Int, Unop(op, Int, ex')
         | Neg when t = Int -> Float, Unop(op, Float, ex')
         | Not when t = Bool -> Bool, Unop(op, Bool, ex')
         | _ -> failwith ("illegal unary operator " ^ string_of_uop op ^
                          string_of_typ t ^ " in " ^ string_of_expr e))
      | Noexpr -> Void, e
      | Assign(var, ex) -> let lt = type_of_identifier ~symbols var
        and (rt, e') = expr ex in
        check_assign lt rt ("illegal assignment " ^ string_of_typ lt ^
                            " = " ^ string_of_typ rt ^ " in " ^
                            string_of_expr e), Assign(var, e')
      | Call(fname, actuals) as call -> let fd = function_decl fname in
        if List.length actuals != List.length fd.formals then
          failwith ("expecting " ^
                    string_of_int (List.length fd.formals) ^
                    " arguments in " ^ string_of_expr call)
        else
          let actuals' = List.map2
            (fun (ft, _) ex -> let (et, ex') = expr ex in
              ignore (check_assign ft et
                        ("illegal actual argument found " ^ string_of_typ et ^
                         " expected " ^ string_of_typ ft ^ " in " ^ string_of_expr ex)); ex')
            fd.formals actuals in
        fd.typ, Call(fname, actuals')
    in

    let check_bool_expr e = let (t, e') = expr e in if t != Bool
      then failwith ("expected Boolean expression in " ^ string_of_expr e)
      else e' in

    (* Verify a statement and return the new statement or throw an exception *)
    let rec stmt = function
      | Block sl ->
        let rec check_block = function
          | [Return _ as s] -> [stmt s]
          | Return _ :: _ -> failwith "nothing may follow a return" (* TODO: change this? *)
          | Block sl :: ss -> check_block (sl @ ss)
          | s :: ss -> (stmt s) :: (check_block ss)
          | [] -> []
        in Block (check_block sl)
      | Expr e -> let (_, e') = expr e in Expr(e')
      | Return e -> let (t, e') = expr e in if t = return then Return(e') else
          failwith ("return gives " ^ string_of_typ t ^ " expected " ^
                    string_of_typ return ^ " in " ^ string_of_expr e)

      | If(p, b1, b2) -> let p' = check_bool_expr p in let b1' = stmt b1 in let b2' = stmt b2 in If(p', b1', b2') 
      | For(e1, e2, e3, st) -> let (_, e1') = expr e1 in let e2' = check_bool_expr e2 in
        let (_, e3') = expr e3 in let st' = stmt st in For (e1', e2', e3', st')
      | While(p, s) -> let p' = check_bool_expr p in let s' = stmt s in While(p', s')
      | Foreach(obj_t, _id, s) -> ignore(gameobj_decl obj_t); let s' = stmt s in Foreach(obj_t, _id, s')
    in
    match stmt (Block block.body) with
    | Block b -> { locals = block.locals; body = b }
    | _ -> assert false
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
    
    let block =
      match func.block with
      | Some block -> Some (check_block ~symbols ~name:func.fname ~return:func.typ block)
      | None -> None
    in
    { func with block = block }
  in

  let check_gameobj ~symbols obj =
    let open Gameobj in
    let obj_fn_list obj =
      [("create", Create, obj.create);
       ("step", Step, obj.step);
       ("draw", Draw, obj.draw);
       ("destroy", Destroy, obj.destroy)]
    in
    report_duplicate
      (fun n -> "duplicate members " ^ n ^ " in " ^ obj.name)
      (List.map snd obj.members);
    
    let check_obj_fn (name, eventtype, block) =
      eventtype, check_block ~symbols ~name:(obj.name ^ "::" ^ name) ~return:Void block
    in
    let blocks' = List.map check_obj_fn (obj_fn_list obj) in
    make obj.name obj.members blocks'
  in

  let symbols = List.fold_left (fun m (t, n) -> StringMap.add n t m) StringMap.empty globals in
  let functions' = List.map (check_function ~symbols) functions in
  let gameobjs' = List.map (check_gameobj ~symbols) new_gameobjs in
  (globals, functions', gameobjs')
