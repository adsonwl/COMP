%option noyywrap
%{
	/*Atividade2 - ModuloB*/	
	int qtdPC = 0, qtdLinhas = 0;
%} 

PalavraChave	((b|B)aix(o|a)s?)|((m|M)enor(es)?)|((q|Q)ueda)|(c|C)ai(u)?|(n|N)egativ(o|a)|(r|R)ecuo

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
	fprintf(yyout,"Quantidade de palavras chave encontradas indicando a baixa das commodities: %d \n", qtdPC); 
	fprintf(yyout,"Quantidade de ocorrencias da palavra commodity %d \n", qtdLinhas-1);
	return 0;
}
