%option noyywrap
%{
	/*Atividade2 - ModuloA*/	
	int qtdOcorrencia = 0;
%} 

diacritico	[á|é|í|ó|ú|ã|õ|ê|ô|à|â|ç]
palavra		(([a-zA-Z]|[0-9]|{diacritico})+)
separador	(,|:|\))?" "(\()?
vizinhosE	({palavra}{separador})?
vizinhosD	({separador}{palavra})?
ocorrencia	{vizinhosE}*(C|c)ommodit(y|ies){vizinhosD}*

%%
 
{ocorrencia}	{ qtdOcorrencia++; fprintf(yyout,"# %s\n", yytext); }
\n	;
.	;

%%

int main (int nArgs, char* szArgs []){
	int i;
	yyout = fopen("Resultados.txt","w");
	if(yyout==NULL)
		printf("Erro");
	for(i=1;i<nArgs;i++){
		yyin = fopen(szArgs[i],"r");
		yylex();
	}
	fprintf(yyout,"Quantidade de palavras commodity/commodities encontradas: %d \n", qtdOcorrencia);
	return 0;
}
