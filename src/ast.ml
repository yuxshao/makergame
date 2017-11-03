(* Abstract Syntax Tree and functions for printing it *)

type op = Add | Sub | Mult | Div | Expo | Modulo | Equal | Neq | Less | Leq |
          Greater | Geq | And | Or

type uop = Neg | Not

type typ =
  | Void
  | Int
  | Bool
  | Float
  | String
  | Sprite
  | Sound
  | Object of string (* lexer prevents object names from overlapping with type names *)
  | Arr of typ * int

type bind = typ * string

type expr =
    Literal of int
  | BoolLit of bool
  | FloatLit of float
  | StringLit of string
  | Id of string * string list
  | Binop of expr * op * expr
  | Unop of uop * expr
  | Assign of (string * string list) * expr
  | Call of string * expr list
  | Noexpr

type stmt =
  | Block of stmt list
  | Expr of expr
  | Return of expr
  | If of expr * stmt * stmt
  | For of expr * expr * expr * stmt
  | Foreach of string * string * stmt (* TODO: use an object bind type maybe *)
  | While of expr * stmt

type block = {
  locals : bind list;
  body : stmt list;
}

type func_decl = {
  typ : typ;
  fname : string;
  formals : bind list;
  block : block option;
}

module Gameobj = struct
  type event_t = Create | Destroy | Step | Draw
  type event = event_t * block

  (* consider using this for the AST post-semant *)
  type t = {
    name : string;
    members : bind list;
    create : block;
    step : block;
    destroy : block;
    draw : block;
  }

  let make name members events =
    let empty = { locals = []; body = [] } in
    let initial_obj =
      { name = name
      ; members = members
      ; create = empty
      ; step = empty
      ; destroy = empty
      ; draw = empty }
    in
    let add_event obj event = match (event : event_t * block) with
      | (Create, block) ->
        if obj.create != empty
        then failwith ("CREATE already defined in " ^ obj.name)
        else { obj with create = block }
      | (Step, block) ->
        if obj.step != empty
        then failwith ("STEP already defined in " ^ obj.name)
        else { obj with step = block }
      | (Destroy, block) ->
        if obj.destroy != empty
        then failwith ("DESTROY already defined in " ^ obj.name)
        else { obj with destroy = block }
      | (Draw, block) ->
        if obj.draw != empty
        then failwith ("DRAW already defined in " ^ obj.name)
        else { obj with draw = block }
    in
    List.fold_left add_event initial_obj events
end

let add_vdecl (vdecls, fdecls, odecls) vdecl =
  (vdecl :: vdecls, fdecls, odecls)

let add_fdecl (vdecls, fdecls, odecls) fdecl =
  (vdecls, fdecl :: fdecls, odecls)

let add_odecl (vdecls, fdecls, odecls) odecl =
  (vdecls, fdecls, odecl :: odecls)

type program = bind list * func_decl list * Gameobj.t list



(* Pretty-printing functions *)

let string_of_op = function
    Add -> "+"
  | Sub -> "-"
  | Mult -> "*"
  | Div -> "/"
  | Expo -> "^"
  | Modulo -> "%"
  | Equal -> "=="
  | Neq -> "!="
  | Less -> "<"
  | Leq -> "<="
  | Greater -> ">"
  | Geq -> ">="
  | And -> "&&"
  | Or -> "||"

let string_of_uop = function
    Neg -> "-"
  | Not -> "!"

let rec string_of_expr = function
    Literal(l) -> string_of_int l
  | StringLit(s) -> "\"" ^ s ^ "\""
  | FloatLit(f) -> string_of_float f
  | BoolLit(true) -> "true"
  | BoolLit(false) -> "false"
  | Id(s, c) -> String.concat "." (s :: c)
  | Binop(e1, o, e2) ->
      string_of_expr e1 ^ " " ^ string_of_op o ^ " " ^ string_of_expr e2
  | Unop(o, e) -> string_of_uop o ^ string_of_expr e
  | Assign((v, c), e) -> (String.concat "." (v :: c)) ^ " = " ^ string_of_expr e
  | Call(f, el) ->
      f ^ "(" ^ String.concat ", " (List.map string_of_expr el) ^ ")"
  | Noexpr -> ""

let rec string_of_stmt = function
    Block(stmts) ->
      "{\n" ^ String.concat "" (List.map string_of_stmt stmts) ^ "}\n"
  | Expr(expr) -> string_of_expr expr ^ ";\n";
  | Return(expr) -> "return " ^ string_of_expr expr ^ ";\n";
  | If(e, s, Block([])) -> "if (" ^ string_of_expr e ^ ")\n" ^ string_of_stmt s
  | If(e, s1, s2) ->  "if (" ^ string_of_expr e ^ ")\n" ^
      string_of_stmt s1 ^ "else\n" ^ string_of_stmt s2
  | For(e1, e2, e3, s) ->
      "for (" ^ string_of_expr e1  ^ " ; " ^ string_of_expr e2 ^ " ; " ^
      string_of_expr e3  ^ ") " ^ string_of_stmt s
  | While(e, s) -> "while (" ^ string_of_expr e ^ ") " ^ string_of_stmt s
  | Foreach(obj_t, id, s) ->
      "foreach (" ^ obj_t  ^ " " ^ id ^ ") " ^ string_of_stmt s

let rec string_of_typ = function
    Int -> "int"
  | Bool -> "bool"
  | Void -> "void"
  | Float -> "float"
  | Sprite -> "sprite"
  | Sound -> "sound"
  | Object obj_t -> "object(" ^ obj_t ^ ")"
  | Arr(typ, len) -> (string_of_typ typ) ^ "[" ^ (string_of_int len) ^ "]"
  | String -> "string"

let string_of_vdecl (t, id) = string_of_typ t ^ " " ^ id ^ ";\n"

let string_of_block block =
  "{\n" ^
  String.concat "" (List.map string_of_vdecl block.locals) ^
  String.concat "" (List.map string_of_stmt block.body) ^
  "}\n"

let string_of_fdecl fdecl =
  let prefix, suffix =
    match fdecl.block with
    | None -> "extern ", ""
    | Some block -> "", string_of_block block
  in
  prefix ^ string_of_typ fdecl.typ ^ " " ^ fdecl.fname ^ "(" ^
  String.concat ", " (List.map snd fdecl.formals) ^ ")\n" ^ suffix

let string_of_gameobj obj =
  let open Gameobj in
  obj.name ^ " {\n" ^
  String.concat "" (List.map string_of_vdecl obj.members) ^ "\n" ^
  "CREATE " ^ (string_of_block obj.create) ^ "\n" ^
  "DESTROY " ^ (string_of_block obj.destroy) ^ "\n" ^
  "STEP " ^ (string_of_block obj.step) ^ "\n" ^
  "DRAW " ^ (string_of_block obj.draw) ^ "\n" ^
  "}\n"

let string_of_program (vars, funcs, objs) =
  String.concat "" (List.map string_of_vdecl vars) ^ "\n" ^
  String.concat "\n" (List.map string_of_fdecl funcs) ^
  String.concat "\n" (List.map string_of_gameobj objs)
