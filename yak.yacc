%{
#include <stdio.h>
#include <stdlib.h>
#include "symtable.h"
%}
//viré le espace et sautligne et tab
//viré le main

%union {int val; char* str; float dec;}
%type <val> Affectation
%type <val> Expression

%left PLUS MOINS
%left MULT DIV
%left NEG

%token EGAL
%token INT CONST
%token PRINT
%token <str>ID
%token <dec>DECIMAL 
%token <val>ENTIER
%token EXP
%token VIR PVIR
%token AO AF PO PF
%token INF SUP 
%token IF WHILE
%token AND
%token OR

%start Input

%%

Input : 		DFonction Input
			|DFonction;

DFonction : 		INT ID PO Parametres PF {printf("hello main\n");} Body; //changé ID par main
Parametres : 		INT ID SuiteParametres
			|;
SuiteParametres : 	VIR INT ID SuiteParametres
			|VIR INT;
			
Body :			AO Instructions AF;

Instruction :		ID Affectation				{int adresse=getVarAddr($1);
								printf("AFC @%d %d\n", adresse, $2);}
								
			|Declaration
			|PVIR;

Instructions :		Bloc Instructions
			|Bloc
			|Instruction
			|Instruction Instructions;

Bloc :			Bloc_IF
			|Bloc_WHILE
			|AFonction;
			
Condition: 		Expression Comparateur Expression;

Conditions: 		Condition OR Conditions
			|Condition AND Conditions
			|Condition;

Expression:		ID 					{ int addr = getVarAddr($1);
								int addrI = getRegistre(); 
								if (addr==-1){printf("La variable n'est pas déclarée\n");}
								else {printf("COP @%d %d\n", addrI, addr);$$=addrI;}}
 			
			|ENTIER 				{ int addrI=getRegistre(); printf("AFC @%d %d\n", addrI, $1); $$ = addrI; }
			| Expression PLUS Expression 		{ libererRegistre();
								libererRegistre(); 
								int addrI=getRegistre(); 
								printf("ADD @%d @%d @%d\n", addrI, $1, $3); }
			| Expression MOINS Expression {}
			| Expression MULT Expression {}
			| Expression DIV Expression {}
			| MOINS Expression %prec NEG  {}
			| Expression EXP Expression {}
			| PO Expression PF  {}
			;			

			
Comparateur:		INF				//eventuellement ne pas le factoriser
			|SUP
			|EGAL EGAL
			|INF EGAL
			|SUP EGAL;

Bloc_IF:		IF PO Conditions PF Body;

Bloc_WHILE:		WHILE PO Conditions PF Body;

Affectation :		EGAL ENTIER PVIR			{$$=$2;};

Declaration :		INT ID PVIR				{add($2,"int", 0, 0);}
			|INT ID Affectation			{int adresse=add($2,"int", 0, 0);
								if (adresse!=-1){
									printf("AFC @%d %d\n", adresse, $3);}
								else{
									printf("variable déjà déclarée\n");}
								};



AFonction :		ID PO Parametres PF PVIR;



%%
int yyerror(char *s) {
  printf("%s\n",s);
}

int main(void) {
  yyparse();
}
			


			

