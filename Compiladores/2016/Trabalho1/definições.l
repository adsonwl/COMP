%option noyywrap
%{
%}

%%

"if"							{return IF;}
"else"							{return ELSE;}
"switch"						{return SWITCH;}
"case"							{return CASE;}
"for"							{return FOR;}
"while"							{return WHILE;}
"pow"							{return POW;}
"sqrt"							{return SQRT;}
"log10"							{return LOG10;}
"main"							{return MAIN;}
"break"							{return BREAK;}
"default"						{return DEFAULT;}
"return"						{return RETURN;}
("void"|"int"|"float"|"double")	{return TIPO;}
([0-9]*|[0-9]*'.'[0-9]*)		{return VALOR;}
[a-zA-Z]([a-zA-Z]|[0-9]|"_")*	{return NOME;}
"("								{return AP;}
")"								{return FP;}
"["								{return ACLCHTS;}
"]"								{return FCLCHTS;}
"{"								{return ACHVS;}
"}"								{return FCHVS;}
("//".*|"/*"(.-{"*/"}|\n)*"*/")	{;}

%%

int main ( int nArgs, char* szArgs[] ){
	yylex();
	return 0;
}






