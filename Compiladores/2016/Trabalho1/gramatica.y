/* calculadora simples - parser*/
%{
#include<stdio.h>
%}

/*declaracao de tokens*/
%token TIPO
%token MAIN
%token VALOR
%token DEFAULT
%token ACHVS FCHVS AP FP
%token NOME
%token BREAK
%token RETURN
%token CASE
%token IF ELSE SWITCH FOR WHILE 
%token POW SQRT LOG10

%nonassoc '==' '!=' '>=' '>' '<=' '<'
%right '='
%left '+' '-'
%left '*' '/'

%type <> mainFunc extFunc declaracaoFunc dclrVarFunc stmtList
%type <> cases stmtCondicional atrbs cmpr incr stmtRepeticao
%type <> dclrVar oprArit oprtLogico predefFunc attr 
%type <> passaParametro chamaFunc stmt

%start ini
%%

ini: mainFunc { $$ = newprog(NULL, $1); } 
	| extFunc mainFunc { $$ = newprog($1, $2); }
	;

mainFunc: /* vazio */
	| TIPO MAIN AP FP ACHVS stmtList FCHVS { $$ = newmainfunc($1, $6); }
	;

extFunc: /* vazio */
	| extfunc declaracaoFunc { $$ = newlistextfunc($1, $2); }
	;

declaracaoFunc: /* vazio */
	| TIPO NOME AP parametroFunc FP ACHVS stmtList RETURN vlr FCHVS { $$ = newfunc($1, $2, $4, $7, $9); }
	;

parametroFunc: /* vazio */
	| dclrVarFunc { $$ = $1; }
	;

dclrVarFunc: TIPO NOME { $$ = newreffunc($1, $2, NULL); }
	| dclrVarFunc ',' TIPO NOME { $$ = newreffunc($3, $4, $1); }
	;

stmtList: /* vazio */
	| stmt stmtList { $$ = newlist($1, $2); }
	;

cases: CASE  VALOR ':' stmtList BREAK ';'{ $$ = newdeffunc('CASE', NULL, $2, $4); }
	| cases  CASE  VALOR ':' stmtList BREAK ';'{ $$ = newdeffunc('CASE', $1, $3, $5); }
	| DEFAULT ':' stmtList { $$ = newdeffunc('CASE', NULL, NULL, $3); }
	;

stmtCondicional: IF AP cmpr FP ACHVS stmtList FCHVS ELSE ACHVS stmtList FCHVS	{$$ = newflow('I', $3, $6, $10, NULL);}
	| IF AP cmpr FP ACHVS stmtList FCHVS ELSE stmt	{$$ = newflow('I', $3, $6, $8, NULL);}
	| IF AP cmpr FP ACHVS stmtList FCHVS	{$$ = newflow('I', $3, $6, NULL, NULL);}
	| IF AP cmpr FP stmt	{$$ = newflow('I', $3, $5, NULL, NULL);}
	| SWITCH AP NOME FP ACHVS cases FCHVS	{$$ = newflow('S', $3, $6, NULL, NULL);}
	;

atrbs: NOME '=' VALOR { $$ = newatrb($1, $3); }
	;

vlr: VALOR { $$ = newnum($1); }
	| NOME { $$ = newref(NULL, $1, NULL, NULL); }
	;

cmpr: vlr '==' vlr { $$ = newcmp('==', $1, $3); }
	| vlr '>=' vlr { $$ = newcmp('>=', $1, $3); }
	| vlr '<=' vlr { $$ = newcmp('<=', $1, $3); }
	| vlr '!=' vlr { $$ = newcmp('!=', $1, $3); }
	| vlr '>' vlr { $$ = newcmp('>', $1, $3); }
	| vlr '<' vlr { $$ = newcmp('<', $1, $3); }
	;

incr: NOME '++' { $$ = newincr('++', $1, NULL); }
	| NOME '--' { $$ = newincr('--', $1, NULL); }
	| NOME '+=' vlr { $$ = newincr('+=', $1, $3); }
	| NOME '-=' vlr { $$ = newincr('-=', $1, $3); }
	;

stmtRepeticao: FOR AP atrbs ';' cmpr ';' incr FP ACHVS stmtList FCHVS	{$$ = newflow('F', $3, $4, $5, $8);}
	| WHILE AP cmpr FP ACHVS stmtList FCHVS		{$$ = newflow('W', $3, $6, NULL, NULL);}
	;

dclrVar: TIPO NOME { $$ = newref($1, $2, NULL, NULL);}
	| TIPO NOME '=' vlr { $$ = newref($1, $2, '=', $4); }
	;

oprtArit: vlr '+' vlr { $$ = newast('+', $1, $3); }
	| vlr '-' vlr { $$ = newast('-', $1, $3); }
	| vlr '*' vlr { $$ = newast('*', $1, $3); }
	| vlr '/' vlr { $$ = newast('/', $1, $3); }
	;

oprtLogico: '!' cmpr { $$ = newlog('!', $2); }
	| cmpr '&&' cmpr { $$ = newlog('&&', $2); }
	| cmpr '||' cmpr { $$ = newlog('||', $2); }
	;

preDefFunc: POW AP vlr ',' vlr FP { $$ = usefunc('POW', $3, $5); }
	| SQRT AP vlr FP { $$ = usefunc('SQRT', $3, NULL); }
	| LOG10 AP vlr FP { $$ = usefunc('LOG10', $3, NULL);}
	;

attr: NOME '=' vlr { $$ = newatrb($1, $2); }
	| incr { $$ = newatrb($1, $2); }
	| NOME '=' preDefFunc { $$ = newatrb($1, $2); }
	| NOME '=' attr { $$ = newatrb($1, $2); }
	| NOME '=' chamaFunc { $$ = newatrb($1, $2); }
	;

passaParametro: /* vazio */
	| dclrParametros { $$ = newlistparam($1); }
	;

dclrParametros: vlr { $$ = newparam(NULL, $1); }
	| passaParametro ',' vlr { $$ = newparam($1, $2); }
	;

chamaFunc: NOME AP passaParametro FP { $$ = callfunc($1, $3); }
	;

stmt: stmtCondicional { $$ = $1; }
	| stmtRepeticao { $$ = $1; }
	| dclrVar ';' { $$ = $1; }
	| attr ';' { $$ = $1; }
	| chamaFunc ';' { $$ = $1; }
	;


%%

main(int argc, char **argv){
	yyparse();
}

yyerror(char *s){
	fprintf(stderr, "error: %s\n", s);
}