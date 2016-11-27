%{
#include "fb-ex-1-5.tab.h"
%}
%%
"+"	{ return ADD; }
"-"	{ return SUB; }
"*"	{ return MUL; }
"/"	{ return DIV; }
[0-9]+	{ yylval = atoi(yytext); return NUMBER; }
\n	{ return EOL; }
[ \t ]	{ /*ignora espaco em branco*/ }
.	{ printf("Caracter nao reconhecido %s\n", yytext); }
%%
