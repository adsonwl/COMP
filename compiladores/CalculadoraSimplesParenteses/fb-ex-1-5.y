/* calculadora simples - parser*/
%{
#include<stdio.h>
%}

/*declaracao de tokens*/
%token NUMBER
%token ADD SUB MUL DIV
%token OP CP
%token EOL

%%

calclist: /* empty */
	| calclist exp EOL { printf(" = %d\n", $2); } /* EOL end of an expression */
	;

exp:	factor /*default $$ = $1*/
	| exp ADD factor {$$ = $1 + $3;}
	| exp SUB factor {$$ = $1 - $3;}
	;

factor:	term /*default $$ = $1*/
	| factor MUL term {$$ = $1 * $3;}
	| factor DIV term {$$ = $1 / $3;}
	;
	
term: NUMBER /* default $$ = $1 */
	| OP exp CP { $$ = $2; }
	;
%%

main(int argc, char **argv){
	yyparse();
}

yyerror(char *s){
	fprintf(stderr, "error: %s\n", s);
}
