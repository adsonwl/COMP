%option noyywrap
%{

int numPalavras = 0;

%}

DIGITO  [0-9]
PALAVRA [a-zA-Z]+
ESPACO  " "

%%

{DIGITO}  {printf("Digito: \"%s\"\n", yytext); }
{PALAVRA} {printf("Palavra: \"%s\"\n", yytext); }
{ESPACO}  {printf("Espaço\n");}
.	  {printf("Não reconhecido: \"%s\"\n", yytext); }

%%

int main ( int nArgs, char* szArgs[] ){
	yylex();
	printf("Numero palavras: %d\n", numPalavras);
	return 0;
}
