%{
	/*Exemplo 3 
	realiza o escaneamento de tags (e.g., HTML)  */	
int linhas = 0;
%} 

TAG	\<(.)*\> 
WHITESPACE	[\ \t] 
LINHA	[\n]
%%
 
{TAG}	;
{LINHA}	{ linhas++; }
{WHITESPACE}	{ printf ("%s", yytext ) ; }
.	{ printf ("%s", yytext ) ; }

%%

int main ( int nArgs , char* szArgs []){ 
	yylex(); 
	printf("Total de linhas processadas: %d \n", linhas); 
	return 0;
}
