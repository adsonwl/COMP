run: a.out
	./a.out ../ModuloA/Resultados.txt

a.out: lex.yy.c
	gcc lex.yy.c -lfl

lex.yy.c: ModuloB.l
	flex ModuloB.l
