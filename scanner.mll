(* Ocamllex scanner for MicroC *)

{ open Parser }

rule token = parse
  [' ' '\t' '\r' '\n'] { token lexbuf } (* Whitespace *)
  | "/*"     { block_comment lexbuf }           (* Comments *)
  | "//"     { line_comment lexbuf }
  (* grouping *)
  | '['      { LBRACK }
  | ']'      { RBRACK }
  | '('      { LPAREN }
  | ')'      { RPAREN }
  | '{'      { LCURLY }
  | '}'      { RCURLY }
  (* separators *)
  | ';'      { SEMI }
  | ','      { COMMA }
  (* arithmetic and logical *)
  | '+'      { PLUS }
  | '-'      { MINUS }
  | '*'      { TIMES }
  | '/'      { DIVIDE }
  | '^'      { EXPONENT }
  | '%'      { MODULO }
  | '='      { ASSIGN }
  | "=="     { EQ }
  | "!="     { NEQ }
  | '<'      { LT }
  | "<="     { LEQ }
  | ">"      { GT }
  | ">="     { GEQ }
  | "&&"     { AND }
  | "||"     { OR }
  | "!"      { NOT }
  (* control flow *)
  | "if"     { IF }
  | "else"   { ELSE }
  | "for"    { FOR }
  | "while"  { WHILE }
  | "foreach" { FOREACH }
  | "return" { RETURN }
  (* datatypes *)
  | "int"    { INT }
  | "bool"   { BOOL }
  | "string" { STRING }
  | "float"  { FLOAT }
  | "void"   { VOID }
  | "sprite" { SPRITE }
  | "sound"  { SOUND }
  (* game keywords *)
  | "CREATE" { CREATE }
  | "DESTROY" { DESTROY }
  | "DRAW" { DRAW }
  | "STEP" { STEP }
  (* literals *)
  | "true"   { TRUE }
  | "false"  { FALSE }
  | ['0'-'9']+ as lxm { LITERAL(int_of_string lxm) }
  | ['a'-'z' 'A'-'Z']['a'-'z' 'A'-'Z' '0'-'9' '_']* as lxm { ID(lxm) }
  | eof { EOF }
  | _ as char { raise (Failure("illegal character " ^ Char.escaped char)) }

and line_comment = parse
    '\n' { token lexbuf }
  | _    { line_comment lexbuf }

and block_comment = parse
    "*/" { token lexbuf }
  | _    { block_comment lexbuf }
