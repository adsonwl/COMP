/*calculadora AST :: definicao das funcoes em C*/

#include<stdio.h>
#include<stdlib.h>
#include<stdarg.h>
#include "fb-ex-2-1.h"

struct ast * newast(int nodetype, struct ast *l, struct ast *r)
{
	struct ast *a = malloc(sizeof(struct ast));
	
	if (!a){
		yyerror("sem espaco");
		exit(0);
	}
	a->nodetype = nodetype;
	a->l = l;
	a->r = r;
	return a;
}

struct ast * newnum(double d)
{
	struct numval *a = malloc(sizeof(struct numval));
	
	if(!a){
		yyerror("sem espaco");
		exit(0);
	}
	a->nodetype = 'K';
	a->number = d;
	return (struct ast *)a;
}

double eval(struct ast *a)
{
	double v; /*calcular valor dessa sub arvore*/
	
	switch(a->nodetype){
		case 'K': v = ((struct numval *)a)->number; break;
		
		case '+': v = eval(a->l) + eval(a->r); break;
		case '-': v = eval(a->l) - eval(a->r); break;
		case '*': v = eval(a->l) * eval(a->r); break;
		case '/': v = eval(a->l) / eval(a->r); break;
		default: printf("erro interno: bad node %c \n", a->nodetype);
	}
	return v;
}

void treefree(struct ast *a)
{
	switch(a->nodetype){
	
	/*duas subarvores*/
	case '+':
	case '-':
	case '*':
	case '/':
		treefree(a->r);
	/*sem subarvore*/
	case 'K':
	free(a);
	break;
	
	default: printf("erro interno: free bad node %c \n", a->nodetype);
	}
}

void yyerror(char *s, ...)
{
	va_list ap;
	va_start(ap, s);
	
	fprintf(stderr, "%d: error: ", yylineno);
	vfprintf(stderr, s, ap);
	fprintf(stderr, "\n");
}

int main()
{
	printf("> ");
	return yyparse();
}

































