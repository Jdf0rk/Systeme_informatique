CC=gcc
LL=flex
Y=bison
CFLAGS=-c -W -Wall
LDFLAGS=
EXEC=lexeur

all: $(EXEC)

lexeur:
	$(Y) -d -v yak.y
	mv yak.tab.h yak.h
	mv yak.tab.c yak.y.c
	$(LL) lex.l
	mv lex.yy.c lex.lex.c
	$(CC) -c lex.lex.c -o lex.lex.o
	$(CC) -c yak.y.c -o yak.y.o
	$(CC) -c interpreteur.c
	$(CC) -o interpreteur lex.lex.o yak.y.o interpreteur.o -ll -lm

clean:
	rm -rf *.o *~ yak.h yak.y.c lex.lex.c lexeur
