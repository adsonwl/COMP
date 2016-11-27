%{

#include"bison.tab.h"

int inlist=0, insec=1, subsec=0, aux=0, inchap=1;
%}

pontuacao		    (\.|\,|\!|\?|\:|\;|"'")
palavraEspecial	    ("\\"[a-zA-Z]+|"\\"[a-zA-Z*]+)
caracterEspecial	(\_|"\&"|"\$"|"\#"|"@")
simbolo	            ("+"|"-"|"="|"["|"]"|"("|")")
palavra		        (({pontuacao}|{simbolo}|[a-zA-Z0-9])+)
comentario	        "%"

%%
"\\"					{return(BARRAINVERTIDA);}
"{"					    {return(ABRECHAVES);}
"}"					    {return(FECHACHAVES);}
"\\ "       			{}
"\\documentclass"		{return(CLASSEDODOCUMENTO);}
"\\title"				{return(TITULODOCUMENTO);}
{caracterEspecial}		{return(PALAVRA);}
"\\begin{enumerate}"	{inlist++; return(INICIOLISTAE);}
"\\end{enumerate}"		{inlist--; return(FIMLISTAE);}
"\\begin{itemize}"		{inlist++; return(INICIOLISTAI);}
"\\end{itemize}"		{ inlist--; return(FIMLISTAI);}
"\\item"				{if(inlist>0) return(ITEM);else return(PALAVRAESPECIAL);}
"\\item[]"			    {if(inlist>0) return(ITEM);else return(PALAVRAESPECIAL);}
"\\begin{document}"		{return(INICIODOCUMENTO);}
"\\end{document}"		{return(FIMDOCUMENTO);}
"\\paragraph"			{return(PARAGRAFO);}
"\\chapter"			    {yylval.valsec[2] = inchap++;return(CHAPTER);}
"\\section"			    {yylval.valsec[0] = aux=insec++;subsec=1;return(SECAO);}
"\\subsection"			{yylval.valsec[1] = subsec++;yylval.valsec[0] = aux ; return(SUBSECAO);}
"\\textbf"		    	{return(NEGRITO);}
"\\bf"				    {return(NEGRITO);}
"\\textit"			    {return(ITALICO);}
"\\underline"			{return(SUBLINHADO);}
"\\em"				    {return(ITALICO);}
"\\it"			    	{return(ITALICO);}
"\\author"               {return(AUTOR);}
{comentario}			{return(COMENTARIO); }
{palavra}				{yylval.arr = strdup(yytext); return(PALAVRA); }
{palavraEspecial}		{yytext=" ";return(PALAVRAESPECIAL);}
.   					{}
%%
