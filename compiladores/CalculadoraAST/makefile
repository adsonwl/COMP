fb-ex-2-1: fb-ex-2-1.l fb-ex-2-1.y fb-ex-2-1.h
	bison -d fb-ex-2-1.y
	flex -o fb-ex-2-1.lex.c fb-ex-2-1.l
	gcc -o saida  fb-ex-2-1.tab.c fb-ex-2-1.lex.c fb-ex-2-1-funcoes.c
