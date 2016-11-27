%{

#include"bison.tab.h"
#include<stdio.h>

int inlist=0, insec=1, subsec=0, aux =0;
%}

ws		[ \t]+
punc		(\.|\,|\!|\?|\:|\;|"'")
sword	("\\"[a-zA-Z]+|"\\"[a-zA-Z*]+)
special	(\_|"\&"|"\$"|"\#"|"@")
symbol	("+"|"-"|"="|"["|"]"|"("|")")
word		(({punc}|{symbol}|[a-zA-Z0-9])+)
comment	"%".*

%%
"\\"					{return(BACKSL);}
"{"					{return(LCURLYB);}
"}"					{return(RCURLYB);}
"\\ "       			{}
"\\documentclass"		{return(DOCUMENTCLASS);}
"article"				{return(ARTICLE);}
"\\title"				{return(TITLE);}
{special}				{return(WORD);}
"\\begin{enumerate}"	{inlist++; return(STARTLISTE);}
"\\end{enumerate}"		{inlist--; return(ENDLISTE);}
"\\begin{itemize}"		{inlist++; return(STARTLISTI);}
"\\end{itemize}"		{ inlist--; return(ENDLISTI);}
"\\item"				{if(inlist>0) return(ITEM);else return(SWORD);}
"\\item[]"			{if(inlist>0) return(ITEM);else return(SWORD);}
"\\begin{document}"		{return(LBEGINDOCU);}
"\\end{document}"		{return(LENDDOCU);}
"\\paragraph"			{return(PARAGRAPH);}
"\\section"			{yylval.valsec[0] = aux=insec++;subsec=1;return(SECTION);}
"\\subsection"			{yylval.valsec[1] = subsec++;yylval.valsec[0] = aux ; return(SUBSECTION);}
"\\textbf"			{return(BOLDFACE);}
"\\bf"				{return(BOLDFACE);}
"\\textit"			{return(ITALICS);}
"\\underline"			{return(UNDERLINE);}
"\\em"				{return(ITALICS);}
"\\it"				{return(ITALICS);}
{comment}				{}
{word}				{yylval.arr = strdup(yytext); return(WORD); }
{sword}				{yytext=" ";return(SWORD);}
.					{}
%%
