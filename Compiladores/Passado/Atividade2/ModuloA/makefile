run: a.out
	./a.out Texto1.txt Texto2.txt Texto3.txt Texto4.txt Texto5.txt Texto6.txt Texto7.txt Texto8.txt Texto9.txt Texto10.txt

a.out: lex.yy.c
	gcc lex.yy.c -lfl

lex.yy.c: ModuloA.l
	flex ModuloA.l
