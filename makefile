all: lex.yy.o code.o
	gcc -g -o compiler lex.yy.o code.o -ll

code.o: code.c code.h
	gcc -g -c code.c

y.tab.o: y.tab.c
	gcc -g -c y.tab.c

lex.yy.o: lex.yy.c
	gcc -g -c lex.yy.c

lex.yy.c: hexed.l
	lex -l hexed.l

clean:
	rm -f *.o compiler lex.yy.c y.tab.h y.output
