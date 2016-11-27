fl-ex-1-5: fb-ex-1-5.l fb-ex-1-5.y
	bison -d fb-ex-1-5.y
	flex fb-ex-1-5.l
	gcc -o saida fb-ex-1-5.tab.c lex.yy.c -lfl
