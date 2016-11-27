%{ 

#include <stdio.h>
#include <ctype.h>
#include <string.h>

FILE *newHtml ;

%}

%union 
{
  char*	arr;
	int	valsec[2];
}

%start latexstatement

%token DBLBS BACKSL LCURLYB RCURLYB END LSQRB RSQRB LBEGIN PARAGRAPH SECTION
%token SUBSECTION DOCUMENTCLASS UNDERLINE ARTICLE LETTER TITLE LBEGINDOCU
%token LENDDOCU BOLDFACE ITALICS BOLDFACEINSIDE SWORD STARTLISTE ENDLISTE 
%token ITEM STARTLISTI ENDLISTI PROC
%token <arr> WORD

%%

latexstatement :  documenttype{fprintf(newHtml,"<html><head> <title>  \n");}  titletype  LBEGINDOCU{fprintf(newHtml,"<body>\n");}  mainbody {fprintf(newHtml,"</body>\n"); } LENDDOCU {fprintf(newHtml,"</html> \n"); }
	;
                 
ignore : SWORD LCURLYB WORD RCURLYB
	|
	;

documenttype : DOCUMENTCLASS  LCURLYB  type  RCURLYB ignore
	;

type	: ARTICLE          
	;   
          
titletype : TITLE LCURLYB textoption RCURLYB {fprintf(newHtml,"</title>\n"); }
	; 
		 
mainbody : mainbody mainoption
	|  mainoption
	;

mainoption : formattedtextoption
	| listoption
	| paragraph
	| section
	| subsection
	;

listoption : STARTLISTE {fprintf(newHtml,"<ol> "); } listitem ENDLISTE {fprintf(newHtml,"</ol> "); }
	|	STARTLISTI {fprintf(newHtml,"<ul>"); } listitem ENDLISTI {fprintf(newHtml,"</ul> "); }
	| 
	;

listitem : ITEM{fprintf(newHtml,"<li> "); } listoption formattedtextoption {fprintf(newHtml,"</li> "); } listitem
	|
	;

formattedtextoption : BOLDFACE LCURLYB {fprintf(newHtml,"<b>\n");} formattedtextoption RCURLYB {fprintf(newHtml,"</b>\n");} formattedtextoption
	|    ITALICS LCURLYB {fprintf(newHtml,"<i>\n");} formattedtextoption RCURLYB {fprintf(newHtml,"</i>\n");} formattedtextoption
	|    UNDERLINE LCURLYB {fprintf(newHtml,"<u>\n");} formattedtextoption RCURLYB {fprintf(newHtml,"</u>\n");} formattedtextoption
	|	LCURLYB BOLDFACE {fprintf(newHtml,"<b>\n");} formattedtextoption RCURLYB {fprintf(newHtml,"</b>\n");} formattedtextoption
	|	LCURLYB ITALICS {fprintf(newHtml,"<i>\n");} formattedtextoption RCURLYB {fprintf(newHtml,"</i>\n");} formattedtextoption
	|    ignore textoption ignore 
	;

paragraph : PARAGRAPH LCURLYB{fprintf(newHtml,"<br><b>\n");} formattedtextoption RCURLYB {fprintf(newHtml,"</b></br>\n");}
	;

section : SECTION LCURLYB{fprintf(newHtml,"<br><b>\n%d ",yylval.valsec[0]);} formattedtextoption RCURLYB {fprintf(newHtml,"</b></br>\n");}
	;

subsection : SUBSECTION LCURLYB{fprintf(newHtml,"<br><b>\n%d.%d ",yylval.valsec[0],yylval.valsec[1]);} formattedtextoption RCURLYB {fprintf(newHtml,"</b></br>\n");}
	;

textoption : textoption WORD {fprintf(newHtml," %s",$2);} 
	|
	;
	
%%

int main(int argc, char *argv[]){
	char arquivoSaida[100];
	strcpy(arquivoSaida,argv[1]);
	newHtml = fopen(arquivoSaida,"w+");
	return yyparse();
}

int yyerror (char *msg){	}
