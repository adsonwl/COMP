%option noyywrap
%{

int linhas = 0, qtdTags = 0;

%}

TAG		\<(.)*\>
WHITESPACE	[\ \t]
LINHA		[\n]

%%


{TAG}		{ qtdTags++; printf("Tag: %s\n", yytext); }
{LINHA}		{ linhas++; }
{WHITESPACE}	;
.	     	;

%%

int main ( int nArgs, char* szArgs[] ){
	yylex();
	printf("\nTotal de linhas processadas: %d\n", linhas);
	printf("\nQuantidade de tags reconhecidas: %d\n", qtdTags);
	return 0;
}
