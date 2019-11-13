testing: a.out
	./a.out < ass5_17CS30001_17CS10014_test1.c > ass5_17CS30001_17CS10014_quads1.out
	./a.out < ass5_17CS30001_17CS10014_test2.c > ass5_17CS30001_17CS10014_quads2.out
	./a.out < ass5_17CS30001_17CS10014_test3.c > ass5_17CS30001_17CS10014_quads3.out
	./a.out < ass5_17CS30001_17CS10014_test4.c > ass5_17CS30001_17CS10014_quads4.out
	./a.out < ass5_17CS30001_17CS10014_test5.c > ass5_17CS30001_17CS10014_quads5.out


a.out: lex.yy.o y.tab.o ass5_17CS30001_17CS10014_translator.o
	g++ lex.yy.o y.tab.o ass5_17CS30001_17CS10014_translator.o -lfl

ass5_17CS30001_17CS10014_translator.o: ass5_17CS30001_17CS10014_translator.cxx ass5_17CS30001_17CS10014_translator.h
	g++ -c ass5_17CS30001_17CS10014_translator.h
	g++ -c ass5_17CS30001_17CS10014_translator.cxx

lex.yy.o: lex.yy.c
	g++ -c lex.yy.c

y.tab.o: y.tab.c
	g++ -c y.tab.c

lex.yy.c: ass5_17CS30001_17CS10014.l y.tab.h ass5_17CS30001_17CS10014_translator.h
	flex ass5_17CS30001_17CS10014.l

y.tab.c: ass5_17CS30001_17CS10014.y
	yacc -dtv ass5_17CS30001_17CS10014.y -W

y.tab.h: ass5_17CS30001_17CS10014.y
	yacc -dtv ass5_17CS30001_17CS10014.y -W
	
clean:
	rm lex.yy.c y.tab.c y.tab.h lex.yy.o y.tab.o ass5_17CS30001_17CS10014_translator.o y.output a.out