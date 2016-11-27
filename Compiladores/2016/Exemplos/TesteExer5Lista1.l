%{
	/* Teste exer 5 */

%}

letra		[a-zA-Z]
digitos		[0-9]
especiais	[!#%&]
espaco		" "
comentario	"/*"({letra}*{digitos}*{especiais}*{espaco}*)*"*/"

%%

{comentario}		{printf("Comentario: %s",yytext);}
.			{printf("Caracter nao reconhecido: %s",yytext);}

%%

int main(int nargs, char* szArgs[]){
	yylex();
	return 0;
}
