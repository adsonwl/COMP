/*
	* Declaracoes para a calculadora
*/

/* interface com o lexer */
extern int yylineno; /* do lexer */
void yyerror(char *s, ...);

/* nos na AST */
struct ast {
	int nodetype;
	struct ast *l;
	struct ast *r;
};

struct numval{
	int nodetype;
	double number;
};

/* construcao de uma AST */
struct ast *newast(int nodetype, struct ast *l, struct ast *r);
struct ast *newnum(double d);

/*avaliacao de uma AST*/
double eval(struct ast *);

/*remover e liberar uma AST*/
void treefree(struct ast *);
