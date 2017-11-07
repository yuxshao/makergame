/* Ocamlyacc parser for MicroC */

%{
open Ast
%}

%token SEMI LPAREN RPAREN LBRACK RBRACK LCURLY RCURLY COMMA PERIOD
%token PLUS MINUS TIMES DIVIDE EXPONENT MODULO ASSIGN NOT
%token EQ NEQ LT LEQ GT GEQ TRUE FALSE AND OR
%token RETURN IF ELSE FOR WHILE FOREACH
%token INT BOOL FLOAT STRING SPRITE SOUND VOID
%token CREATE DESTROY DRAW STEP
%token EXTERN
%token <int> LITERAL
%token <string> ID
%token <string> STRLIT
%token <float> FLOATLIT
%token EOF

%nonassoc NOELSE
%nonassoc ELSE
%right ASSIGN
%left OR
%left AND
%left EQ NEQ
%left LT GT LEQ GEQ
%right CREATE DESTROY
%left PLUS MINUS
%left TIMES DIVIDE
%left EXPONENT MODULO
%right NOT NEG

%start program
%type <Ast.program> program

%%

program:
  decls EOF { $1 }

decls:
   /* nothing */ { [], [], [] }
 | decls vdecl { add_vdecl $1 $2 }
 | decls fdecl { add_fdecl $1 $2 }
 | decls odecl { add_odecl $1 $2 }

code_block:
   LCURLY stmt_list RCURLY { $2 }

fdecl:
 | EXTERN typ ID LPAREN formals_opt RPAREN SEMI
     { { typ = $2
       ; fname = $3
       ; formals = $5
       ; block = None } }
 | typ ID LPAREN formals_opt RPAREN code_block
     { { typ = $1
       ; fname = $2
       ; formals = $4
       ; block = Some $6 } }

event:
  | CREATE code_block { (Gameobj.Create, $2) }
  | DESTROY code_block { (Gameobj.Destroy, $2) }
  | STEP code_block { (Gameobj.Step, $2) }
  | DRAW code_block { (Gameobj.Draw, $2) }

event_list:
    /* nothing */    { [] }
  | event event_list { $1 :: $2 }

odecl:
   ID LCURLY vdecl_list event_list RCURLY
     { Gameobj.make $1 (List.rev $3) $4 }

formals_opt:
    /* nothing */ { [] }
  | formal_list   { $1 }

formal_list:
    typ ID                   { [($1,$2)] }
  | typ ID COMMA formal_list { ($1,$2) :: $4 }

typ:
    INT { Int }
  | BOOL { Bool }
  | SPRITE { Sprite }
  | SOUND { Sound }
  | VOID { Void }
  | FLOAT { Float }
  | STRING { String }
  | ID { Object($1) }
  | typ LBRACK LITERAL RBRACK { Arr($1, $3) }

vdecl_list:
    /* nothing */    { [] }
  | vdecl_list vdecl { $2 :: $1 }

/* TODO: allow typ ID EQ EXPR (vdecldef) for function-local variables.
   also think about what can go in if/while conditions, as well as for
   initializer.I think vdecl, vdecldef, expr_opt can go in for
   initializer, while only vdecldef and exprs can go in conditions. */
vdecl:
  | typ ID SEMI { ($1, $2) }

stmt_list:
    /* nothing */  { [] }
  | stmt stmt_list { $1 :: $2 }

stmt:
    expr SEMI { Expr $1 }
  | vdecl { Decl $1 }
  | RETURN expr_opt SEMI { Return $2 }
  | code_block { Block($1) }
  | IF LPAREN expr RPAREN stmt %prec NOELSE { If($3, $5, Block([])) }
  | IF LPAREN expr RPAREN stmt ELSE stmt    { If($3, $5, $7) }
  | FOR LPAREN expr_opt SEMI expr SEMI expr_opt RPAREN stmt
     { For($3, $5, $7, $9) }
  | WHILE LPAREN expr RPAREN stmt { While($3, $5) }
  | FOREACH LPAREN ID ID RPAREN stmt { Foreach($3, $4, $6) }

expr_opt:
    /* nothing */ { Noexpr }
  | expr          { $1 }

expr:
  | LITERAL          { Literal($1) }
  | STRLIT           { StringLit($1) }
  | FLOATLIT         { FloatLit($1) }
  | TRUE             { BoolLit(true) }
  | FALSE            { BoolLit(false) }
  | id_chain         { Id(fst $1, snd $1) }
  | expr PLUS   expr { Binop($1, Add, Void,  $3) }
  | expr MINUS  expr { Binop($1, Sub, Void,  $3) }
  | expr TIMES  expr { Binop($1, Mult, Void, $3) }
  | expr DIVIDE expr { Binop($1, Div, Void,  $3) }
  | expr EXPONENT expr { Binop($1, Expo, Void,  $3) }
  | expr MODULO expr { Binop($1, Modulo, Void,  $3) }
  | expr EQ     expr { Binop($1, Equal, Void,   $3) }
  | expr NEQ    expr { Binop($1, Neq, Void,  $3) }
  | expr LT     expr { Binop($1, Less, Void, $3) }
  | expr LEQ    expr { Binop($1, Leq, Void,  $3) }
  | expr GT     expr { Binop($1, Greater, Void, $3) }
  | expr GEQ    expr { Binop($1, Geq, Void,  $3) }
  | expr AND    expr { Binop($1, And, Void,  $3) }
  | expr OR     expr { Binop($1, Or, Void,   $3) }
  | MINUS expr %prec NEG { Unop(Neg, Void,   $2) }
  | NOT expr         { Unop(Not, Void, $2) }
  | id_chain ASSIGN expr   { Assign($1, $3) }
  | ID LPAREN actuals_opt RPAREN { Call($1, $3) }
  | CREATE ID { Create($2) }
  | DESTROY expr { Destroy($2) }
  | LPAREN expr RPAREN { $2 }

id_chain:
  | ID { $1, [] }
  | ID PERIOD id_chain { let (h, t) = $3 in $1, h :: t }

actuals_opt:
    /* nothing */ { [] }
  | actuals_list  { List.rev $1 }

actuals_list:
    expr                    { [$1] }
  | actuals_list COMMA expr { $3 :: $1 }
