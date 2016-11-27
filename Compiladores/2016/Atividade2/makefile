saida: flex.l bison.y
	flex flex.l
	bison bison.y 
	gcc -o trabalho2.exe bison.tab.c lex.yy.c -lfl
	./trabalho2.exe saida.html < entrada.tex > log.txt
	gnome-open saida.html
