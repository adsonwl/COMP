%option noyywrap
%{ 
	/*Exericicio 2 :: Flex
	  reconhecimento de indentificadores linguagem SQL*/
%}

identificador	([a-z]|[A-Z]|_)([a-z]|[A-Z]|[0-9]|\$|_)*

%%

{identificador}	{ printf("Identificador: \"%s\"\n", yytext); }
.	{ printf("Nao reconhecido: \"%s\"\n", yytext); }

%%

int main ( int nArgs, char* szArgs[] ) {
	yylex();
	return 0;
}
