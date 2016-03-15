%{
#include <stdlib.h>
#include "yak.h"
%}


%%

^01 return ADD; //@rés @opé @opé
^02 return MUL; //@rés @opé @opé
^03 return SOU; //@rés @opé @opé
^04 return DIV; //@rés @opé @opé
^05 return COP; //@rés @opé
^06 return AFC; //@res val_cons
^07 return JMP; //n° instruction
^08 return JMF; //@X n° instruction
^09 return INF; //@rés @opé @opé
^A return SUP;  //@rés @opé @opé
^B return EQU;  //@rés @opé @opé
^C return PRI;  //@rés

[0-9]+  {yylval = atoi(yytext); return NB;} //(voir yacc précédent)
