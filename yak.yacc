%{
#include <stdio.h>
#include <stdlib.h>
#include "symtable.h"
%}
//viré le espace et sautligne et tab
//viré le main

%union {int val; char* str; float dec;}
%type <val> Affectation

%token INT CONST
%token PRINT
%token <str>ID
%token <dec>DECIMAL 
%token <val>ENTIER
%token PLUS MOINS MULT DIV EGAL EXP
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
			
Expression:		ID
			|DECIMAL
			|ENTIER;
			
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
			


			

