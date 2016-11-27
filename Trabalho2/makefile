saida: flex.l bison.y
#	rm bison.tab.c saida.html trabalho2.exe lex.yy.c log.txt
	bison bison.y -d
	flex flex.l
	gcc -o trabalho2.exe bison.tab.c lex.yy.c -lfl
	./trabalho2.exe saida.html < entrada.tex > log.txt
#	gnome-open saida.html
remove:
	rm bison.tab.c saida.html trabalho2.exe lex.yy.c log.txt bison.tab.h