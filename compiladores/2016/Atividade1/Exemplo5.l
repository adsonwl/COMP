%{
	/*Exemplo 4 
	realiza o escaneamento e o reconhecimento 
	de tags (e.g., HTML) */	
int linhas = 0, qtdTags;
%} 

TAG	\<(.)*\> 
WHITESPACE	[\ \t] 
LINHA	[\n]
%%
 
{TAG}	{ qtdTags++; printf("Tag: %s\n", yytext); }
{LINHA}	{ linhas++; }
{WHITESPACE}	;
.	;

%%

int main ( int nArgs , char* szArgs []){ 
	yylex(); 
	printf("Total de linhas processadas: %d \n", linhas); 
	printf("Quantidade de tags reconhecidas: %d \n", qtdTags); 
	return 0;
}
