#ifndef YY_YY_BISON_TAB_H_INCLUDED
# define YY_YY_BISON_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
enum yytokentype
  {
    BACKSL = 259,
    LCURLYB = 260,
    RCURLYB = 261,
    END = 262,
    LSQRB = 263,
    RSQRB = 264,
    LBEGIN = 265,
    PARAGRAPH = 266,
    SECTION = 267,
    SUBSECTION = 268,
    DOCUMENTCLASS = 269,
    UNDERLINE = 270,
    ARTICLE = 271,
    LETTER = 272,
    TITLE = 273,
    LBEGINDOCU = 274,
    LENDDOCU = 275,
    BOLDFACE = 276,
    ITALICS = 277,
    BOLDFACEINSIDE = 278,
    SWORD = 279,
    STARTLISTE = 280,
    ENDLISTE = 281,
    ITEM = 282,
    STARTLISTI = 283,
    ENDLISTI = 284,
    PROC = 285,
    WORD = 286
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE YYSTYPE;
union YYSTYPE
{
#line 16 "bison.y" /* yacc.c:1909  */

  char*	arr;
	int	valsec[2];

#line 120 "bison.tab.h" /* yacc.c:1909  */
};
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_BISON_TAB_H_INCLUDED  */
