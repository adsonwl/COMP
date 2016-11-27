/*reconhece tokens pra a calculadora com AST*/
%option noyywrap nodefault yylineno
%{
#include "fb-ex-2-1.h"
#include "fb-ex-2-1.tab.h"
%}

/* expoente float */
EXP ([Ee][+-]?[0-9]+)

%%
"+"	|
"-"	|
"*"	|
"/"	|
"("	|
")"	{ return yytext[0]; }
[0-9]+"."[0-9]*{EXP}?	|
"."?[0-9]+{EXP}?	{ yylval.d = atof(yytext); return NUMBER; }

\n	{ return EOL; }
"//".*
[ \t ] { /*ignora espaco em branco*/ }
. { yyerror("Caracter nao reconhecido %c \n", yytext); }
%%
