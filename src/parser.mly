/* Ocamlyacc parser for MicroC */

%{
open Ast
%}

%token SEMI LPAREN RPAREN LBRACK RBRACK LCURLY RCURLY COMMA PERIOD DBCOLON
%token PLUS MINUS TIMES DIVIDE EXPONENT MODULO ASSIGN NOT
%token INCREMENT DECREMENT
%token ADDASN MINUSASN TIMEASN DIVASN
%token EQ NEQ LT LEQ GT GEQ TRUE FALSE AND OR
%token BREAK RETURN IF ELSE FOR WHILE FOREACH
%token INT BOOL FLOAT STRING SPRITE SOUND VOID
%token OBJECT EVENT CREATE DESTROY DRAW STEP
%token PRIVATE PUBLIC NAMESPACE EXTERN OPEN
%token <int> LITERAL
%token <string> ID
%token <string> STRLIT
%token <float> FLOATLIT
%token EOF

%nonassoc NOELSE
%nonassoc ELSE
%right ASSIGN ADDASN MINUSASN TIMEASN DIVASN
%left OR
%left AND
%left EQ NEQ
%left LT GT LEQ GEQ
%right CREATE DESTROY
%left PLUS MINUS
%left TIMES DIVIDE
%left EXPONENT MODULO
%right NOT NEG
%left INCREMENT DECREMENT
%left PERIOD
%left DBCOLON

%start program
%type <Ast.program> program

%%

program: decls EOF { { main = Namespace.make $1; files = [] } }

ndecl:
 | PUBLIC ndecl_base  { let n, ns = $2 in n, (false, ns) }
 | ndecl_base         { let n, ns = $1 in n, (false, ns) }
 | PRIVATE ndecl_base { let n, ns = $2 in n, (true, ns) }

ndecl_base:
 | NAMESPACE ID LCURLY decls RCURLY { $2, Namespace.Concrete (Namespace.make $4) }
 | NAMESPACE ID ASSIGN id_chain SEMI { $2, Namespace.Alias (fst $4 @ [snd $4]) }
 | NAMESPACE ID ASSIGN OPEN STRLIT SEMI { $2, Namespace.File $5 }

decls:
   /* nothing */ { [],[],[],[] }
 | vdecl decls { Namespace.add_vdecl $2 $1 }
 | fdecl decls { Namespace.add_fdecl $2 $1 }
 | odecl decls { Namespace.add_odecl $2 $1 }
 | ndecl decls { Namespace.add_ndecl $2 $1 }

code_block:
   LCURLY stmt_list RCURLY { $2 }

fdecl:
 | EXTERN typ ID LPAREN formals_opt RPAREN SEMI
     { $3, { Func.typ = $2 ; formals = $5 ; gameobj = None ; block = None } }
 | typ ID LPAREN formals_opt RPAREN code_block
     { $2, Func.make $1 $4 None $6 }

event:
 | EVENT CREATE LPAREN formals_opt RPAREN code_block
   { "create", Func.make Void $4 None $6 }
 | EVENT CREATE  code_block { "create",  Func.make Void [] None $3 }
 | EVENT STEP    code_block { "step",    Func.make Void [] None $3 }
 | EVENT DESTROY code_block { "destroy", Func.make Void [] None $3 }
 | EVENT DRAW    code_block { "draw",    Func.make Void [] None $3 }

odecl:
   OBJECT ID LCURLY odecl_body RCURLY
     { Gameobj.make $2 $4 }

odecl_body:
    /* nothing */ { [], [], [] }
  | odecl_body vdecl { Gameobj.add_vdecl $1 $2 }
  | odecl_body fdecl { Gameobj.add_fdecl $1 $2 }
  | odecl_body event { Gameobj.add_edecl $1 $2 }


formals_opt:
    /* nothing */ { [] }
  | formal_list   { $1 }

formal_list:
    typ ID                   { [($2,$1)] }
  | typ ID COMMA formal_list { ($2,$1) :: $4 }

typ:
    INT { Int }
  | BOOL { Bool }
  | SPRITE { Sprite }
  | SOUND { Sound }
  | VOID { Void }
  | FLOAT { Float }
  | STRING { String }
  | id_chain { Object($1) }
  | typ LBRACK LITERAL RBRACK { Arr($1, $3) }

/* TODO: allow typ ID EQ EXPR (vdecldef) for function-local variables.
   also think about what can go in if/while conditions, as well as for
   initializer.I think vdecl, vdecldef, expr_opt can go in for
   initializer, while only vdecldef and exprs can go in conditions. */
vdecl:
  | typ ID SEMI { ($2, $1) }

stmt_list:
    /* nothing */  { [] }
  | stmt stmt_list { $1 :: $2 }

stmt:
    expr SEMI { Expr $1 }
  | vdecl { Decl $1 }
  | typ ID ASSIGN expr SEMI { Vdef($1, $2, $4) }
  | RETURN expr_opt SEMI { Return $2 }
  | BREAK SEMI { Break }
  | code_block { Block($1) }
  | IF LPAREN expr RPAREN stmt %prec NOELSE { If($3, $5, Block([])) }
  | IF LPAREN expr RPAREN stmt ELSE stmt    { If($3, $5, $7) }
  | FOR LPAREN expr_opt SEMI expr SEMI expr_opt RPAREN stmt
     { For($3, $5, $7, $9) }
  | WHILE LPAREN expr RPAREN stmt { While($3, $5) }
  | FOREACH LPAREN id_chain ID RPAREN stmt { Foreach($3, $4, $6) }

expr_opt:
    /* nothing */ { Noexpr }
  | expr          { $1 }

expr:
  | LITERAL            { Literal($1) }
  | STRLIT             { StringLit($1) }
  | FLOATLIT           { FloatLit($1) }
  | TRUE               { BoolLit(true) }
  | FALSE              { BoolLit(false) }
  | id_chain           { Id($1) }
  | expr PERIOD ID     { Member($1, ([], ""), $3) }
  | expr PLUS   expr   { Binop($1, Add, Void,  $3) }
  | expr MINUS  expr   { Binop($1, Sub, Void,  $3) }
  | expr TIMES  expr   { Binop($1, Mult, Void, $3) }
  | expr DIVIDE expr   { Binop($1, Div, Void,  $3) }
  | expr EXPONENT expr { Binop($1, Expo, Void,  $3) }
  | expr MODULO expr   { Binop($1, Modulo, Void,  $3) }
  | expr EQ     expr   { Binop($1, Equal, Void,   $3) }
  | INCREMENT   expr   { Idop(Inc, Void, $2) }
  | DECREMENT   expr   { Idop(Dec, Void, $2)}
  | expr ADDASN expr   { Asnop($1, Addasn, Void, $3) }
  | expr MINUSASN expr { Asnop($1, Subasn, Void, $3) }
  | expr TIMEASN expr  { Asnop($1, Multasn, Void, $3) }
  | expr DIVASN expr   { Asnop($1, Divasn, Void, $3) }
  | expr NEQ    expr   { Binop($1, Neq, Void,  $3) }
  | expr LT     expr   { Binop($1, Less, Void, $3) }
  | expr LEQ    expr   { Binop($1, Leq, Void,  $3) }
  | expr GT     expr   { Binop($1, Greater, Void, $3) }
  | expr GEQ    expr   { Binop($1, Geq, Void,  $3) }
  | expr AND    expr   { Binop($1, And, Void,  $3) }
  | expr OR     expr   { Binop($1, Or, Void,   $3) }
  | MINUS expr %prec NEG { Unop(Neg, Void,   $2) }
  | NOT expr           { Unop(Not, Void, $2) }
  | expr ASSIGN expr   { Assign($1, $3) }
  | id_chain LPAREN actuals_opt RPAREN { Call($1, $3) }
  | expr PERIOD ID LPAREN actuals_opt RPAREN { MemberCall($1, ([], ""), $3, $5) }
  | CREATE id_chain                           { Create($2, []) }
  | CREATE id_chain LPAREN actuals_opt RPAREN { Create($2, $4) }
  | DESTROY expr       { Destroy($2, ([], "")) }
  | LPAREN expr RPAREN { $2 }

id_chain:
  | ID { [], $1 }
  | ID DBCOLON id_chain { let c, e = $3 in $1 :: c, e }

actuals_opt:
    /* nothing */ { [] }
  | actuals_list  { List.rev $1 }

actuals_list:
    expr                    { [$1] }
  | actuals_list COMMA expr { $3 :: $1 }
