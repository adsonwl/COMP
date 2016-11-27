/* reconhece e imprime tokns para uma calculadora con return*/
%{
	enum yytokentype {
	NUMBER = 258,
	ADD = 259,
	SUB = 260,
	MUL = 261,
	DIV = 262,
	EOL = 263,
	};
	
	int yylval;
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
main(int argc, char **argv)
{
	int tok;
	
	while(tok = yylex()){
		printf("%d",tok);
		if(tok == NUMBER)
			printf(" = %d\n", yylval);
		else
			printf("\n");
	}
}
