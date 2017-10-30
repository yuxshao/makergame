/* Ocamlyacc parser for MicroC */

%{
open Ast
%}

%token SEMI LPAREN RPAREN LBRACK RBRACK LCURLY RCURLY COMMA
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
   LCURLY vdecl_list stmt_list RCURLY
   { { locals = List.rev $2
     ; body = List.rev $3} }

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
  | CREATE code_block { (Create, $2) }
  | DESTROY code_block { (Destroy, $2) }
  | STEP code_block { (Step, $2) }
  | DRAW code_block { (Draw, $2) }

event_list:
    /* nothing */    { [] }
  | event_list event { $2 :: $1 }

odecl:
   ID LCURLY vdecl_list event_list RCURLY
     { make_gameobj $1 (List.rev $3) $4 }

formals_opt:
    /* nothing */ { [] }
  | formal_list   { List.rev $1 }

formal_list:
    typ ID                   { [($1,$2)] }
  | formal_list COMMA typ ID { ($3,$4) :: $1 }

typ:
    INT { Int }
  | BOOL { Bool }
  | SPRITE { Sprite }
  | SOUND { Sound }
  | VOID { Void }
  | FLOAT { Float }
  | STRING { String }
  | typ LBRACK LITERAL RBRACK { Arr($1, $3) }

vdecl_list:
    /* nothing */    { [] }
  | vdecl_list vdecl { $2 :: $1 }

vdecl:
   typ ID SEMI { ($1, $2) }

stmt_list:
    /* nothing */  { [] }
  | stmt_list stmt { $2 :: $1 }

stmt:
    expr SEMI { Expr $1 }
  | RETURN SEMI { Return Noexpr }
  | RETURN expr SEMI { Return $2 }
  | LCURLY stmt_list RCURLY { Block(List.rev $2) }
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
  | ID               { Id($1) }
  | expr PLUS   expr { Binop($1, Add,   $3) }
  | expr MINUS  expr { Binop($1, Sub,   $3) }
  | expr TIMES  expr { Binop($1, Mult,  $3) }
  | expr DIVIDE expr { Binop($1, Div,   $3) }
  | expr EXPONENT expr { Binop($1, Expo,   $3) }
  | expr MODULO expr { Binop($1, Modulo,$3) }
  | expr EQ     expr { Binop($1, Equal, $3) }
  | expr NEQ    expr { Binop($1, Neq,   $3) }
  | expr LT     expr { Binop($1, Less,  $3) }
  | expr LEQ    expr { Binop($1, Leq,   $3) }
  | expr GT     expr { Binop($1, Greater, $3) }
  | expr GEQ    expr { Binop($1, Geq,   $3) }
  | expr AND    expr { Binop($1, And,   $3) }
  | expr OR     expr { Binop($1, Or,    $3) }
  | MINUS expr %prec NEG { Unop(Neg, $2) }
  | NOT expr         { Unop(Not, $2) }
  | ID ASSIGN expr   { Assign($1, $3) }
  | ID LPAREN actuals_opt RPAREN { Call($1, $3) }
  | LPAREN expr RPAREN { $2 }

actuals_opt:
    /* nothing */ { [] }
  | actuals_list  { List.rev $1 }

actuals_list:
    expr                    { [$1] }
  | actuals_list COMMA expr { $3 :: $1 }
