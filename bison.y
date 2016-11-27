%{ 

#include <stdio.h>
#include <ctype.h>
#include <string.h>

int yyerror();
int yylex();

FILE *novoHTML ;

%}

%union 
{
  	char*	arr;
	int	valsec[2];
}

%start entrada

%token PALAVRAESPECIAL
%token ABRECHAVES FECHACHAVES PARAGRAFO SECAO
%token SUBSECAO DOCUMENTCLASS SUBLINHADO ARTICLE TITLE LBEGINDOCU
%token LENDDOCU NEGRITO ITALICO  INICIOLISTAE FIMLISTAE 
%token ITEM INICIOLISTAI FIMLISTAI BARRAINVERTIDA
%token <arr> PALAVRA

%%

entrada: tipoDocumento { fprintf(novoHTML,"<html>\n<head>\n\t<title> \n\t\t"); } titulo LBEGINDOCU { fprintf(novoHTML,"<body>\n"); } mainbody { fprintf(novoHTML,"</body>\n"); } LENDDOCU { fprintf(novoHTML,"</html> \n"); }
	;
                 
ignorar: PALAVRAESPECIAL ABRECHAVES PALAVRA FECHACHAVES
	|
	;

tipoDocumento: DOCUMENTCLASS ABRECHAVES tipo FECHACHAVES ignorar
	;

tipo: ARTICLE
	;   
          
titulo: TITLE ABRECHAVES texto FECHACHAVES { fprintf(novoHTML,"\n\t</title>\n"); }
	; 
		 
mainbody: mainbody mainoption
	| mainoption
	;

mainoption: textoFormatado
	| lista
	| paragrafo
	| secao
	| subsecao
	;

lista: INICIOLISTAE { fprintf(novoHTML,"<ol>"); } itemLista FIMLISTAE { fprintf(novoHTML,"</ol>\n"); }
	| INICIOLISTAI { fprintf(novoHTML,"<ul>"); } itemLista FIMLISTAI { fprintf(novoHTML,"</ul>\n"); }
	;

itemLista: ITEM{fprintf(novoHTML,"<li> "); } lista textoFormatado {fprintf(novoHTML,"</li>\n"); } itemLista
	|
	;

textoFormatado: NEGRITO ABRECHAVES { fprintf(novoHTML,"<b>"); } textoFormatado FECHACHAVES { fprintf(novoHTML,"</b>\n"); } textoFormatado
	| ITALICO ABRECHAVES { fprintf(novoHTML,"<i>"); } textoFormatado FECHACHAVES { fprintf(novoHTML,"</i>\n"); } textoFormatado
	| SUBLINHADO ABRECHAVES { fprintf(novoHTML,"<u>"); } textoFormatado FECHACHAVES { fprintf(novoHTML,"</u>\n"); } textoFormatado
	| ABRECHAVES NEGRITO { fprintf(novoHTML,"<b>"); } textoFormatado FECHACHAVES { fprintf(novoHTML,"</b>\n"); } textoFormatado
	| ABRECHAVES ITALICO { fprintf(novoHTML,"<i>"); } textoFormatado FECHACHAVES { fprintf(novoHTML,"</i>\n"); } textoFormatado
	| ABRECHAVES SUBLINHADO { fprintf(novoHTML,"<u>"); } textoFormatado FECHACHAVES { fprintf(novoHTML,"</u>\n"); } textoFormatado
	| ignorar texto ignorar
	;

paragrafo: PARAGRAFO ABRECHAVES { fprintf(novoHTML,"<br><b>"); } textoFormatado FECHACHAVES { fprintf(novoHTML,"</b></br>\n"); }
	;

secao: SECAO ABRECHAVES { fprintf(novoHTML,"<br><b>%d ",yylval.valsec[0]); } textoFormatado FECHACHAVES { fprintf(novoHTML,"</b></br>\n"); }
	;

subsecao: SUBSECAO ABRECHAVES { fprintf(novoHTML,"<br><b>%d.%d ",yylval.valsec[0],yylval.valsec[1]); } textoFormatado FECHACHAVES { fprintf(novoHTML,"</b></br>\n"); }
	;

texto: texto PALAVRA { fprintf(novoHTML," %s",$2); }
	|
	;
	
%%

int main(int argc, char *argv[]){
	char arquivoSaida[100];
	strcpy(arquivoSaida,argv[1]);
	novoHTML = fopen(arquivoSaida,"w+");
	return yyparse();
}

int yyerror (char *msg){	}
