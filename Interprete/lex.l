%{
#include <stdlib.h>
#include "yak.h"
%}


%%

^01 return tADD; //@rés @opé @opé
^02 return tMUL; //@rés @opé @opé
^03 return tSOU; //@rés @opé @opé
^04 return tDIV; //@rés @opé @opé
^05 return tCOP; //@rés @opé
^06 return tAFC; //@res val_cons
^07 return tJMP; //n° instruction
^08 return tJMF; //@X n° instruction
^09 return tINF; //@rés @opé @opé
^A return tSUP;  //@rés @opé @opé
^B return tEQU;  //@rés @opé @opé
^C return tPRI;  //@rés

[0-9]+  {yylval = atoi(yytext); return tNB;} //(voir yacc précédent)
