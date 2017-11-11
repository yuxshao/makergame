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
  | '.'      { PERIOD }
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
  | "break"  { BREAK }
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
  | "object" { OBJECT }
  | "event"  { EVENT }
  | "create" { CREATE }
  | "destroy" { DESTROY }
  | "draw"   { DRAW }
  | "step"   { STEP }
  (* misc keywords *)
  | "extern" { EXTERN }
  (* literals *)
  | "true"   { TRUE }
  | "false"  { FALSE }
  | ['0'-'9']+ as lxm { LITERAL(int_of_string lxm) }
  | ['0'-'9']+'.'['0'-'9']* as lxm { FLOATLIT(float_of_string lxm) }
  | '.'['0'-'9']+ as lxm { FLOATLIT(float_of_string lxm) }
  (* | ['0'-'9']+'e'['+''-']['0'-'9']+ as lxm { LITERAL(float_of_string lxm) } *)
  (* | ['0'-'9']+'.'['0'-'9']*('e'['+''-']['0'-'9']+)? as lxm { LITERAL(float_of_string lxm) } *)
  (* | '.'['0'-'9']+('e'['+''-']['0'-'9']+)? as lxm { LITERAL(float_of_string lxm) } *)
  | ['a'-'z' 'A'-'Z']['a'-'z' 'A'-'Z' '0'-'9' '_']* as lxm { ID(lxm) }
  | '"' { string_literal "" lexbuf }
  | eof { EOF }
  | _ as char { raise (Failure("illegal character " ^ Char.escaped char)) }

and line_comment = parse
    '\n' { token lexbuf }
  | _    { line_comment lexbuf }

and block_comment = parse
    "*/" { token lexbuf }
  | _    { block_comment lexbuf }

and string_literal accum = parse
  | '\\' { escaped_string_literal accum lexbuf }
  | '"' { STRLIT (Scanf.unescaped accum) }
  | [^'\"' '\\'] as c { string_literal (accum ^ (Char.escaped c)) lexbuf }

and escaped_string_literal accum = parse
    (* only n, \, quote escape characters for now *)
  | ['\\' '\"' 'n'] as c { string_literal (accum ^ "\\" ^ (String.make 1 c)) lexbuf }
  | _ as c { failwith ("unsupported escape character \\" ^ Char.escaped c) }
