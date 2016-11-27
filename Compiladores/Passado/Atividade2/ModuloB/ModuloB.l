%{
	/*Atividade2 - ModuloB*/	
	int qtdPC = 0, qtdLinhas = 0;
%} 

PalavraChave	((a|A)lt(o|a)s?)|((e|E)levad(o|a)s?)|((a|A)cima)

%%
 
{PalavraChave}	{ qtdPC++; }
\n	{ qtdLinhas++; }
.	;

%%

int main (int nArgs, char* szArgs []){
	yyout = fopen("Resultados2.txt","w");
	if(yyout==NULL)
		printf("Erro");
	yyin = fopen(szArgs[1],"r");
	yylex();
	fprintf(yyout,"Quantidade de palavras chave encontradas: %d / %d \n", qtdPC, qtdLinhas-1);
	return 0;
}
