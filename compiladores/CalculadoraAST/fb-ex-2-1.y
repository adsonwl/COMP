/*calculadora com AST*/
%{
#include<stdio.h>
#include<stdlib.h>
#include "fb-ex-2-1.h"
%}

%union {
	struct ast *a;
	double d;
}

/* declaracoes de tokens */
%token <d> NUMBER
%token EOL

%type <a> exp factor term

%%
calclist: /*empty*/
	| calclist exp EOL{
		printf(" = %4.4g\n", eval($2));/*avalia e imprime a AST*/
		treefree($2); /*liberar a AST*/
		printf("> ");
	}
	| calclist EOL { printf("> "); }
	;

exp: factor
	| exp '+' factor { $$ = newast('+', $1, $3); }
	| exp '-' factor { $$ = newast('-', $1, $3); }
	;

factor: term
	| factor '*' term { $$ = newast('*', $1, $3); }
	| factor '/' term { $$ = newast('/', $1, $3); }
	;
	
term: NUMBER { $$ = newnum($1); }
	| '(' exp ')' { $$ = $2; }
	;
%%









