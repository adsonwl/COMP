run: a.out
	./a.out

a.out: lex.yy.c
	gcc lex.yy.c -lfl

lex.yy.c: Exemplo5.l
	flex Exemplo5.l
