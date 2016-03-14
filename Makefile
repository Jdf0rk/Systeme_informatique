CC=gcc
LL=flex
Y=bison
CFLAGS=-c -W -Wall 
LDFLAGS=
EXEC=lexeur

all: $(EXEC)

lexeur: 
	$(Y) -d -v yak.yacc
	mv yak.tab.hacc yak.h
	mv yak.tab.cacc yak.y.c
	$(LL) lex.l
	mv lex.yy.c lex.lex.c
	$(CC) -c lex.lex.c -o lex.lex.o
	$(CC) -c yak.y.c -o yak.y.o
	$(CC) -c symtable.c
	$(CC) -c labeltable.c
	$(CC) -o lexeur lex.lex.o yak.y.o symtable.o labeltable.o -ll -lm
	
	
    
    
clean:
	rm -rf *.o *~ yak.h yak.y.c lex.lex.c lexeur


