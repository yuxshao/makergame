(* Abstract Syntax Tree and functions for printing it *)

type op = Add | Sub | Mult | Div | Expo | Modulo | Equal | Neq | Less | Leq |
          Greater | Geq | And | Or

type idop = Inc | Dec

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
  | Idop of idop * typ * expr
  | Assign of expr * expr
  | Subscript of expr * expr
  (* (LHS before period, name of LHS object type, RHS) *)
  | Member of expr * id_chain * string
  (* (LHS before period, name of LHS object type, RHS function name, actuals) *)
  | MemberCall of expr * id_chain * string * expr list
  | Call of id_chain * expr list
  | Create of id_chain * expr list
  | Destroy of expr * id_chain
  | Noexpr

type stmt =
  | Decl of Var.decl
  | Vdef of typ * string * expr
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

  let make typ formals gameobj block = { typ; formals; gameobj; block = (Some block) }
end

module Gameobj = struct
  type t = {
    members : Var.decl list;
    methods : Func.decl list;
    events : Func.decl list;
  }
  type decl = string * t

  let make name (members, methods, events) =
    (* Tag each method with this object name *)
    let add_gameobj (n, x) = n, { x with Func.gameobj = Some name } in
    let methods = List.map add_gameobj methods in
    let events  = List.map add_gameobj events in
    name, { members; methods; events }

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
  and t = Concrete of concrete | Alias of string list | File of string
  and decl = string * (bool * t)

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

type program = {
  main : Namespace.concrete;
  (* TODO: handle matching files in different directories *)
  files : (string * Namespace.concrete) list
}



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

let string_of_idop = function
    Inc -> "++"
  | Dec -> "--"

let string_of_uop = function
    Neg -> "-"
  | Not -> "!"

let string_of_chain (c, e) = (List.fold_left (fun s x -> s ^ x ^ "::") "" c) ^ e

let string_of_asnop = function
    Addasn -> "+="
  | Subasn -> "-="
  | Multasn -> "*="
  | Divasn -> "/="

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

let rec string_of_expr = function
    Literal(l) -> string_of_int l
  | StringLit(s) -> "\"" ^ s ^ "\""
  | FloatLit(f) -> string_of_float f
  | BoolLit(true) -> "true"
  | BoolLit(false) -> "false"
  | Id c -> string_of_chain c
  | Conv (t, e, _) -> "(" ^ string_of_typ t ^ ")" ^ string_of_expr e
  | Asnop(l, o, _, r) ->
    string_of_expr l ^ " " ^ string_of_asnop o ^ " " ^ string_of_expr r
  | Binop(e1, o, _, e2) ->
    string_of_expr e1 ^ " " ^ string_of_op o ^ " " ^ string_of_expr e2
  | Idop(o, _, e) -> string_of_idop o ^ string_of_expr e
  | Unop(o, _, e) -> string_of_uop o ^ string_of_expr e
  | Assign(l, r) -> string_of_expr l ^ " = " ^ string_of_expr r
  | Call(f, el) ->
    (string_of_chain f) ^ "(" ^ String.concat ", " (List.map string_of_expr el) ^ ")"
  | Subscript(e, ind) -> string_of_expr e ^ "[" ^ string_of_expr ind ^ "]"
  | Member(e, _, s) -> "(" ^ (string_of_expr e) ^ ")." ^ s
  | MemberCall(e, _, f, el) -> "(" ^ (string_of_expr e) ^ ")." ^ string_of_expr (Call(([], f), el))
  | Create (c, args) ->
    (match args with
     | [] -> "create " ^ string_of_chain c
     | _ -> "create " ^ string_of_expr(Call(c, args)))
  | Destroy (o, _) -> "destroy " ^ (string_of_expr o)
  | Noexpr -> ""

let string_of_vdecl (id, t) = string_of_typ t ^ " " ^ id ^ ";\n"

let rec string_of_stmt = function
  | Decl d -> string_of_vdecl d
  | Vdef(t, id, e) -> string_of_typ t ^ " " ^ id ^ " = " ^ string_of_expr e ^ ";\n"
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

let string_of_edecl (name, func) =
  let open Func in
  let block_str =
    match func.block with
    | None -> assert false
    | Some block -> string_of_block block
  in
  let arg_str = match func.formals with
    | [] -> ""
    | _ as args -> "(" ^ String.concat ", " (List.map fst args) ^ ")"
  in
  "event " ^ string_of_typ func.typ ^ " " ^ name ^ arg_str ^ "\n" ^ block_str

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
  String.concat "" (List.map string_of_fdecl obj.methods) ^ "\n" ^
  String.concat "" (List.map string_of_edecl obj.events) ^ "\n" ^
  "}\n"

let rec string_of_concrete_ns { Namespace.variables; functions; gameobjs; namespaces } =
  String.concat "" (List.map string_of_vdecl variables) ^ "\n" ^
  String.concat "\n" (List.map string_of_fdecl functions) ^
  String.concat "\n" (List.map string_of_gameobj gameobjs) ^
  String.concat "\n" (List.map string_of_ns_decl namespaces)
and string_of_ns_decl (name, (is_private, ns)) =
  let open Namespace in
  let pref = if is_private then "private namespace " else "namespace " in
  match ns with
  | Alias chain -> pref ^ name ^ " = " ^ String.concat "::" chain ^";\n"
  | File f      -> pref ^ name ^ " = open \"" ^ f ^"\";\n"
  | Concrete n  -> pref ^ name ^ " {\n" ^ string_of_concrete_ns n ^ "\n}\n"

let string_of_program { main; files = _ } = string_of_concrete_ns main
