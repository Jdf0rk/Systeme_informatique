%{
#include <stdio.h>
#include <stdlib.h>
%}


%%
"int"			{printf("mon int");}
"main"			{printf("fonction main");}
"const" 		{printf("constante");}
"printf"		{printf("mon printf");}
[a-zA-Z]+[a-z0-9_]* 	{printf("String %s",yytext);}
[0-9]+\.[0-9]+ 		{printf("nombre décimal %f",atof(yytext));}
[0-9]+ 			{printf("nombre entier %d",atoi(yytext));}
"+" 			{printf("Opérande +");}
"-" 			{printf("Opérande -");}
"*" 			{printf("Opérande -");}     
"/" 			{printf("Opérande /");}
"=" 			{printf("Opérande =");}
[ ] 			{printf("   ");}
[\t]		 	{printf("tab");}
"," 			{printf("virgule");}
[\n] 			{printf("\n");}
";" 			{printf(";;");}
"^" 			{printf("exp");}
"{" 			{printf("AO");}
"}" 			{printf("AF");}
"(" 			{printf("PO");}
")" 			{printf("PF");}
"\""			{printf("guillemets");}
%%
void main(void) {
	yylex();
}
