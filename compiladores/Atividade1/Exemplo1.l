%{ 
	/* Exemplo 0 :: Flex reconhecimento simples de digitos e palavras */ 
%}

DIGITO	[0-9]
PALAVRA	[a-zA-Z]+

%%

{DIGITO}	{ printf("Digito: \"%s\"\n", yytext); }
{PALAVRA}	{ printf("Palavra: \"%s\"\n", yytext); }
.	{ printf("Nao reconhecido: \"%s\"\n", yytext); }

%%

int main ( int nArgs, char* szArgs[] ) {
	yylex();
	return 0;
}
