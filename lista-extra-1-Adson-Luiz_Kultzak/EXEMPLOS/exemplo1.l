%option noyywrap
%{
%}
DIGITO [0-9]
PALAVRA [a-zA-Z]

%%

{DIGITO}  {printf("Digito: \"%s\"\n", yytext); }
{PALAVRA} {printf("Palavra: \"%s\"\n", yytext); }
.	  {printf("Não reconhecido: \"%s\"\n", yytext); }

%%

int main ( int nArgs, char* szArgs[] ){
	yylex();
	return 0;
}
