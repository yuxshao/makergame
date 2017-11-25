(* Abstract Syntax Tree and functions for printing it *)

type op = Add | Sub | Mult | Div | Expo | Modulo | Equal | Neq | Less | Leq |
          Greater | Geq | And | Or

type asnop = Addasn | Subasn | Multasn | Divasn

type uop = Neg | Not

(* Chain of namespaces, then ID *)
type id_chain = string list * string

type typ =
  | Void
  | Int
  | Bool
  | Float
  | String
  | Sprite
  | Sound
  | Object of id_chain          (* object type, in relative position of namespaces *)
  | Arr of typ * int

module Var = struct
  type t = typ
  type decl = string * t
end

type expr =
    Literal of int
  | BoolLit of bool
  | FloatLit of float
  | StringLit of string
  | Id of id_chain
  | Conv of typ * expr * typ
  | Binop of expr * op * typ * expr
  | Asnop of expr * asnop * typ * expr
  | Unop of uop * typ * expr
  | Assign of expr * expr
  (* (LHS before period, name of LHS object type, RHS) *)
  | Member of expr * id_chain * string
  (* (LHS before period, name of LHS object type, RHS function name, actuals) *)
  | MemberCall of expr * id_chain * string * expr list
  | Call of id_chain * expr list
  | Create of id_chain
  | Destroy of expr * id_chain
  | Noexpr

type stmt =
  | Decl of Var.decl
  | Block of block
  | Expr of expr
  | Break
  | Return of expr
  | If of expr * stmt * stmt
  | For of expr * expr * expr * stmt
  | Foreach of id_chain * string * stmt
  | While of expr * stmt
and block = stmt list

module Func = struct
  type t = {
    typ : typ;
    formals : Var.decl list;
    gameobj : string option;
    block : block option;
  }
  type decl = string * t
end

module Gameobj = struct
  type event_t = Create | Destroy | Step | Draw

  (* consider using this for the AST post-semant *)
  type t = {
    members : Var.decl list;
    methods : Func.decl list;
    create : block;
    step : block;
    destroy : block;
    draw : block;
  }
  type decl = string * t

  let make name (members, methods, events) =
    (* Tag each method with this object name *)
    let methods = List.map (fun (n, x) -> n, { x with Func.gameobj = Some name }) methods in
    let initial_obj =
      { members; methods; create = []; step = []; destroy = []; draw = [] }
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
    name, List.fold_left add_event initial_obj events

  let add_vdecl (vdecls, fdecls, edecls) vdecl =
    (vdecl :: vdecls, fdecls, edecls)

  let add_fdecl (vdecls, fdecls, edecls) fdecl =
    (vdecls, fdecl :: fdecls, edecls)

  let add_edecl (vdecls, fdecls, edecls) edecl =
    (vdecls, fdecls, edecl :: edecls)
end

module Namespace = struct
  type concrete = {
    namespaces : decl list;
    variables : Var.decl list;
    functions : Func.decl list;
    gameobjs : Gameobj.decl list;
  }
  (* a namespace could be an alias for another in the tree, with the same values *)
  and t = Concrete of concrete | Alias of string list
  and decl = string * t

  let make (variables, functions, gameobjs, namespaces) =
    { variables; functions; gameobjs; namespaces }

  let add_vdecl (vdecls, fdecls, odecls, ndecls) vdecl =
    (vdecl :: vdecls, fdecls, odecls, ndecls)

  let add_fdecl (vdecls, fdecls, odecls, ndecls) fdecl =
    (vdecls, fdecl :: fdecls, odecls, ndecls)

  let add_odecl (vdecls, fdecls, odecls, ndecls) odecl =
    (vdecls, fdecls, odecl :: odecls, ndecls)

  let add_ndecl (vdecls, fdecls, odecls, ndecls) ndecl =
    (vdecls, fdecls, odecls, ndecl :: ndecls)

end

type program = Namespace.concrete



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

let string_of_chain (c, e) = (List.fold_left (fun s x -> s ^ x ^ "::") "" c) ^ e

let string_of_asnop = function
    Addasn -> "+="
  | Subasn -> "-="
  | Multasn -> "*="
  | Divasn -> "/="

let rec string_of_expr = function
    Literal(l) -> string_of_int l
  | StringLit(s) -> "\"" ^ s ^ "\""
  | FloatLit(f) -> string_of_float f
  | BoolLit(true) -> "true"
  | BoolLit(false) -> "false"
  | Id c -> string_of_chain c
  | Asnop(l, o, _, r) ->
       string_of_expr l ^ " " ^ string_of_asnop o ^ " " ^ string_of_expr r
  | Binop(e1, o, _, e2) ->
      string_of_expr e1 ^ " " ^ string_of_op o ^ " " ^ string_of_expr e2
  | Unop(o, _, e) -> string_of_uop o ^ string_of_expr e
  | Assign(l, r) -> string_of_expr l ^ " = " ^ string_of_expr r
  | Call(f, el) ->
      (string_of_chain f) ^ "(" ^ String.concat ", " (List.map string_of_expr el) ^ ")"
  | Member(e, _, s) -> "(" ^ (string_of_expr e) ^ ")." ^ s
  | MemberCall(e, _, f, el) -> "(" ^ (string_of_expr e) ^ ")." ^ string_of_expr (Call(([], f), el))
  | Create c -> "create " ^ (string_of_chain c)
  | Destroy (o, _) -> "destroy " ^ (string_of_expr o)
  | Noexpr -> ""

let rec string_of_typ = function
    Int -> "int"
  | Bool -> "bool"
  | Void -> "void"
  | Float -> "float"
  | Sprite -> "sprite"
  | Sound -> "sound"
  | Object obj_t -> "object(" ^ string_of_chain obj_t ^ ")"
  | Arr(typ, len) -> (string_of_typ typ) ^ "[" ^ (string_of_int len) ^ "]"
  | String -> "string"

let string_of_vdecl (id, t) = string_of_typ t ^ " " ^ id ^ ";\n"

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
      "foreach (" ^ string_of_chain obj_t  ^ " " ^ id ^ ") " ^ string_of_stmt s
and string_of_block block =
  "{\n" ^ String.concat "" (List.map string_of_stmt block) ^ "}\n"

let string_of_fdecl (name, func) =
  let open Func in
  let prefix, suffix =
    match func.block with
    | None -> "extern ", ""
    | Some block -> "", string_of_block block
  in
  prefix ^ string_of_typ func.typ ^ " " ^ name ^ "(" ^
  String.concat ", " (List.map fst func.formals) ^ ")\n" ^ suffix

let string_of_gameobj (name, obj) =
  let open Gameobj in
  name ^ " {\n" ^
  String.concat "" (List.map string_of_vdecl obj.members) ^ "\n" ^
  "CREATE " ^ (string_of_block obj.create) ^ "\n" ^
  "DESTROY " ^ (string_of_block obj.destroy) ^ "\n" ^
  "STEP " ^ (string_of_block obj.step) ^ "\n" ^
  "DRAW " ^ (string_of_block obj.draw) ^ "\n" ^
  "}\n"

let rec string_of_concrete_ns { Namespace.variables; functions; gameobjs; namespaces } =
  String.concat "" (List.map string_of_vdecl variables) ^ "\n" ^
  String.concat "\n" (List.map string_of_fdecl functions) ^
  String.concat "\n" (List.map string_of_gameobj gameobjs) ^
  String.concat "\n" (List.map string_of_ns_decl namespaces)
and string_of_ns_decl (name, ns) =
  let open Namespace in
  match ns with
  | Alias chain -> "namespace " ^ name ^ " = " ^ String.concat "::" chain ^";\n"
  | Concrete n -> "namespace " ^ name ^ " {\n" ^ string_of_concrete_ns n ^ "\n}\n"

let string_of_program = string_of_concrete_ns
