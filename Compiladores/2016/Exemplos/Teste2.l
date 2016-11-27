%{
	/* Teste exer 5 */

%}

letra			[a-zA-Z]
ignorar			"abb"
naoreconhecido		{letra}*{ignorar}{letra}*
palavra			{letra}+

%%
{naoreconhecido}	{printf("palavra nao reconhecida");}
{palavra}		{printf("Palavra reconhecida: %s",yytext);}
.			{printf("Caracter nao reconhecido: %s",yytext);}

%%

int main(int nargs, char* szArgs[]){
	yylex();
	return 0;

	//naoreconhecido	{letra}*{ignorar}{letra}*
	//palavra		{letra}+
	/*{palavra}		{printf("Palavra reconhecida: %s",yytext);}
{naoreconhecido}	{printf("Caracter nao reconhecido: %s",yytext);}
*/

}
