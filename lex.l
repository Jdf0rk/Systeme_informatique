%{
#include <stdlib.h>
#include "yak.h"
%}


%%
"int"			{return INT;}
"const" 		{return CONST;}
"printf"		{return PRINT;}
"if"			{return IF;}
"while"			{return WHILE;}
[A-Za-z][A-Za-z0-9]* 	{yylval.str=strdup(yytext); printf("%s\n",yylval.str); return ID ;} 
[0-9]+\.[0-9]+ 		{yylval.dec = atof(yytext); return DECIMAL;}
[0-9]+ 			{yylval.val = atoi(yytext); return ENTIER;}
"+" 			{return PLUS;}
"-" 			{return MOINS;}
"*" 			{return MULT;}     
"/" 			{return DIV;}
"=" 			{return EGAL;}
[ ] 			{;}
[\t]		 	{;}
"," 			{return VIR;}
[\n] 			{;}
";" 			{return PVIR;}
"^" 			{return EXP;}
"{" 			{return AO;}
"}" 			{return AF;}
"(" 			{return PO;}
")" 			{return PF;}
"<"			{return INF;}
">"			{return SUP;}
"||"			{return OR;}
"&&"			{return AND;}

