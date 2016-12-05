saida: flex.l bison.y
	bison bison.y -d
	flex flex.l
	gcc -o trabalho2.exe bison.tab.c lex.yy.c -lfl
	./trabalho2.exe saida1.html < entrada1.tex > log.txt
	./trabalho2.exe saida2.html < entrada2.tex > log.txt
	./trabalho2.exe saida3.html < entrada3.tex > log.txt
remove:
	rm bison.tab.c saida1.html saida2.html saida3.html trabalho2.exe lex.yy.c log.txt bison.tab.h