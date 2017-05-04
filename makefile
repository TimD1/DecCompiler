all: y.tab.o lex.yy.o code.o
	gcc -g -o compiler y.tab.o lex.yy.o code.o -ll -ly

code.o: code.c code.h
	gcc -g -c code.c

y.tab.o: y.tab.c
	gcc -g -c y.tab.c

lex.yy.o: lex.yy.c
	gcc -g -c lex.yy.c

y.tab.c: dec.y
	yacc -dv dec.y

lex.yy.c: dec.l
	lex -l dec.l

clean:
	rm -f *.o compiler y.tab.c lex.yy.c y.tab.h y.output
