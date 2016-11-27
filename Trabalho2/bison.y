%{ 

#include <stdio.h>
#include <ctype.h>
#include <string.h>

int yylex();
int yyerror();

FILE *novoHTML ;

%}

%union 
{
 	char*	arr;
	int	valsec[3];
}

%start entrada

%token PALAVRAESPECIAL
%token ABRECHAVES FECHACHAVES PARAGRAFO SECAO CHAPTER
%token SUBSECAO CLASSEDODOCUMENTO SUBLINHADO TITULODOCUMENTO AUTOR INICIODOCUMENTO
%token FIMDOCUMENTO NEGRITO ITALICO COMENTARIO INICIOLISTAE FIMLISTAE
%token ITEM INICIOLISTAI FIMLISTAI BARRAINVERTIDA
%token <arr> PALAVRA

%%

entrada: {fprintf(novoHTML,"<html>\n<head>\n");} tipoDocumento {fprintf(novoHTML,"</head>\n");} INICIODOCUMENTO{fprintf(novoHTML,"<body>\n");}  corpo {fprintf(novoHTML,"</body>\n"); } FIMDOCUMENTO {fprintf(novoHTML,"</html> \n"); }
	;
                 
ignorar: PALAVRAESPECIAL ABRECHAVES PALAVRA FECHACHAVES
	|
	;

tipoDocumento: 
	| tipoDocumento autor
	| tipoDocumento classe
	| tipoDocumento titulo
	;
    
autor: AUTOR ABRECHAVES {fprintf(novoHTML,"\t<!-- (AUTOR)");} textoFormatado FECHACHAVES {fprintf(novoHTML,"-->\n");}
	;

classe: CLASSEDODOCUMENTO ABRECHAVES {fprintf(novoHTML,"\t<!-- (CLASSE)");} textoFormatado FECHACHAVES {fprintf(novoHTML,"-->\n");}
	;

titulo: TITULODOCUMENTO ABRECHAVES {fprintf(novoHTML,"\t<title>"); } texto FECHACHAVES {fprintf(novoHTML,"</title>\n"); }
	; 
		 
corpo: corpo opcao
	|  opcao
	;

opcao: textoFormatado
	| lista
	| paragrafo
	| capitulo
	| secao
	| subsecao
	| comentario
	;

comentario: COMENTARIO {fprintf(novoHTML,"<!--");} textoFormatado {fprintf(novoHTML,"-->\n");}
	;

lista: INICIOLISTAE {fprintf(novoHTML,"<ol> "); } itemLista FIMLISTAE {fprintf(novoHTML,"</ol>\n"); }
	|	INICIOLISTAI {fprintf(novoHTML,"<ul>"); } itemLista FIMLISTAI {fprintf(novoHTML,"</ul>\n"); }
	| 
	;

itemLista: ITEM{fprintf(novoHTML,"<li> "); } lista textoFormatado {fprintf(novoHTML,"</li>\n"); } itemLista
	|
	;

textoFormatado: NEGRITO ABRECHAVES {fprintf(novoHTML,"<b>");} textoFormatado FECHACHAVES {fprintf(novoHTML,"</b>\n");} textoFormatado
	|    ITALICO ABRECHAVES {fprintf(novoHTML,"<i>");} textoFormatado FECHACHAVES {fprintf(novoHTML,"</i>\n");} textoFormatado
	|    SUBLINHADO ABRECHAVES {fprintf(novoHTML,"<u>");} textoFormatado FECHACHAVES {fprintf(novoHTML,"</u>\n");} textoFormatado
	|	ABRECHAVES NEGRITO {fprintf(novoHTML,"<b>");} textoFormatado FECHACHAVES {fprintf(novoHTML,"</b>\n");} textoFormatado
	|	ABRECHAVES ITALICO {fprintf(novoHTML,"<i>");} textoFormatado FECHACHAVES {fprintf(novoHTML,"</i>\n");} textoFormatado
	|	ABRECHAVES SUBLINHADO {fprintf(novoHTML,"<u>");} textoFormatado FECHACHAVES {fprintf(novoHTML,"</u>\n");} textoFormatado
	|    ignorar texto ignorar 
	;

paragrafo: PARAGRAFO ABRECHAVES{fprintf(novoHTML,"<br>\n<b>");} textoFormatado FECHACHAVES {fprintf(novoHTML,"</b></br>\n");}
	;

capitulo: CHAPTER ABRECHAVES{fprintf(novoHTML,"<br><h3>Chapter %d</h3>\n<br>\n<h2>",yylval.valsec[2]);} textoFormatado FECHACHAVES {fprintf(novoHTML,"</h2></b>\n");}
	;

secao: SECAO ABRECHAVES{fprintf(novoHTML,"<br><b>%d ",yylval.valsec[0]);} textoFormatado FECHACHAVES {fprintf(novoHTML,"</b></br>\n");}
	;

subsecao: SUBSECAO ABRECHAVES{fprintf(novoHTML,"<br><b>%d.%d ",yylval.valsec[0],yylval.valsec[1]);} textoFormatado FECHACHAVES {fprintf(novoHTML,"</b></br>\n");}
	;

texto: texto PALAVRA {fprintf(novoHTML," %s",$2);} 
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
