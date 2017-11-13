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
  | Id of string
  | Binop of expr * op * typ * expr
  | Addasn of expr * typ * expr
  | Unop of uop * typ * expr
  | Assign of expr * expr
  (* (LHS before period, name of LHS object type, RHS) *)
  | Member of expr * string * string
  (* (LHS before period, name of LHS object type, RHS function name, actuals) *)
  | MemberCall of expr * string * string * expr list
  | Call of string * expr list
  | Create of string
  | Destroy of expr * string
  | Noexpr

type stmt =
  | Decl of bind
  | Block of block
  | Expr of expr
  | Break
  | Return of expr
  | If of expr * stmt * stmt
  | For of expr * expr * expr * stmt
  | Foreach of string * string * stmt (* TODO: use an object bind type maybe *)
  | While of expr * stmt
and block = stmt list

type func_decl = {
  typ : typ;
  fname : string;
  formals : bind list;
  gameobj : string option;
  block : block option;
}

module Gameobj = struct
  type event_t = Create | Destroy | Step | Draw

  (* consider using this for the AST post-semant *)
  type t = {
    name : string;
    members : bind list;
    methods : func_decl list;
    create : block;
    step : block;
    destroy : block;
    draw : block;
  }

  let make name (members, methods, events) =
    (* Tag each method with this object name *)
    let methods = List.map (fun x -> { x with gameobj = Some name }) methods in
    let initial_obj =
      { name; members; methods; create = []; step = []; destroy = []; draw = [] }
    in
    let fail n = failwith (n ^ " defined multiple times in " ^ name) in
    (* TODO: someone can still duplicate by defining the first as empty *)
    let add_event o event = match (event : event_t * block) with
      | (Create, block) ->
        if o.create != [] then fail "create" else { o with create = block }
      | (Step, block) ->
        if o.step != [] then fail "step" else { o with step = block }
      | (Destroy, block) ->
        if o.destroy != [] then fail "destroy" else { o with destroy = block }
      | (Draw, block) ->
        if o.draw != [] then fail "draw" else { o with draw = block }
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
  | Id s -> s
  | Addasn(l, _, r) -> string_of_expr l ^ " += " ^ string_of_expr r
  | Binop(e1, o, _, e2) ->
      string_of_expr e1 ^ " " ^ string_of_op o ^ " " ^ string_of_expr e2
  | Unop(o, _, e) -> string_of_uop o ^ string_of_expr e
  | Assign(l, r) -> string_of_expr l ^ " = " ^ string_of_expr r
  | Call(f, el) ->
      f ^ "(" ^ String.concat ", " (List.map string_of_expr el) ^ ")"
  | Member(e, _, s) -> "(" ^ (string_of_expr e) ^ ")." ^ s
  | MemberCall(e, _, f, el) -> "(" ^ (string_of_expr e) ^ ")." ^ string_of_expr (Call(f, el))
  | Create o -> "create " ^ o   (* TODO: precedence? parentheses? *)
  | Destroy (o, _) -> "destroy " ^ (string_of_expr o) (* TODO: ibid *)
  | Noexpr -> ""

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

let rec string_of_stmt = function
  | Decl d -> string_of_vdecl d
  | Block(blk) -> string_of_block blk
  | Expr(expr) -> string_of_expr expr ^ ";\n"
  | Break -> "break;\n"
  | Return(expr) -> "return " ^ string_of_expr expr ^ ";\n"
  | If(e, s, Block([])) ->
    "if (" ^ string_of_expr e ^ ")\n" ^ string_of_stmt s
  | If(e, s1, s2) ->  "if (" ^ string_of_expr e ^ ")\n" ^
      string_of_stmt s1 ^ "else\n" ^ string_of_stmt s2
  | For(e1, e2, e3, s) ->
      "for (" ^ string_of_expr e1  ^ " ; " ^ string_of_expr e2 ^ " ; " ^
      string_of_expr e3  ^ ") " ^ string_of_stmt s
  | While(e, s) -> "while (" ^ string_of_expr e ^ ") " ^ string_of_stmt s
  | Foreach(obj_t, id, s) ->
      "foreach (" ^ obj_t  ^ " " ^ id ^ ") " ^ string_of_stmt s
and string_of_block block =
  "{\n" ^ String.concat "" (List.map string_of_stmt block) ^ "}\n"

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
