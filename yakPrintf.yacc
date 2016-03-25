%{
#include <stdio.h>
#include <stdlib.h>
#include "symtable.h"
#include "labeltable.h"

int pc=0;
int addrCond=-1;
%}
//viré le espace et sautligne et tab
//viré le main

%union {int val; char* str; float dec;}
%type <val> Affectation
%type <val> Expression
%type <val> PC
%type <val> Condition
%type <val> Conditions

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
%token <val> IF 
%token WHILE
%token AND
%token OR

%start Input

%%

Input : 		DFonction Input
			|DFonction;

DFonction : 		INT ID PO Parametres PF {printf("hello main\n");} Body; //changer eventuellement ID par main

Parametres : 		INT ID SuiteParametres
			|;
SuiteParametres : 	VIR INT ID SuiteParametres
			|;
			
Body :			AO Instructions AF			{setLabel(pc);};

Instruction :		ID Affectation				{int adresse=getVarAddr($1);
								printf("COP @%d @%d\n", adresse, $2);
								pc++;
								}
								
			|Declaration
			|PVIR;

Instructions :		Bloc Instructions
			|Bloc
			|Instruction
			|Instruction Instructions;

Bloc :			Bloc_IF
			|Bloc_WHILE
			|AFonction;
						
Condition: 		Expression INF Expression		{libererRegistre();libererRegistre();
								addrCond=getRegistre();
								printf("INF @%d @%d @%d\n", addrCond, $1, $3);
								pc++;
								$$=addrCond;
								}
								
			|Expression SUP Expression		{libererRegistre();libererRegistre();
								addrCond=getRegistre();
								printf("SUP @%d @%d @%d\n", addrCond, $1, $3);
								pc++;
								$$=addrCond;
								}
								
			|Expression EGAL EGAL Expression	{libererRegistre();libererRegistre();
								addrCond=getRegistre();
								printf("EQU @%d @%d @%d\n", addrCond, $1, $4);
								pc++;
								$$=addrCond;
								};
			

Conditions: 		Condition OR Conditions			{int addrZ = getRegistre();
								printf("AFC @%d %d\n",addrZ,0);			
								pc++;
								printf("ADD @%d @%d @%d\n", $1, $1, $3);
								pc++;
								printf("SUP @%d @%d @%d\n", $1, $1, addrZ);
								pc++;
								libererRegistre();
								addrCond=$1;
								}
			
			|Condition AND Conditions		{int addrD = getRegistre();
								printf("AFC @%d %d\n", addrD, 2);						
								pc++;
								printf("ADD @%d @%d @%d\n", $1, $1, $3);
								pc++;
								printf("EQU @%d @%d @%d\n", $1, $1, addrD);
								pc++;
								libererRegistre();
								addrCond=$1;
								}
		
			|Condition				{};

Expression:		ID 					{int addr = getVarAddr($1);
								int addrI = getRegistre(); 
								if (addr==-1){printf("La variable n'est pas déclarée\n");}
								else {printf("COP @%d @%d\n", addrI, addr);
								pc++;
								$$=addrI;}}
 			
			|ENTIER 				{int addrI=getRegistre(); 
								printf("AFC @%d %d\n", addrI, $1); 
								pc++;
								$$ = addrI; }
			
			| Expression PLUS Expression 		{libererRegistre();
								libererRegistre(); 
								int addrI=getRegistre(); 
								printf("ADD @%d @%d @%d\n", addrI, $1, $3);
								pc++;
								$$=addrI;}
			
			| Expression MOINS Expression 		{libererRegistre();
								libererRegistre(); 
								int addrI=getRegistre(); 
								printf("SOU @%d @%d @%d\n", addrI, $1, $3);
								pc++;
								$$=addrI;}
			
			| Expression MULT Expression 		{libererRegistre();
								libererRegistre(); 
								int addrI=getRegistre(); 
								printf("MULT @%d @%d @%d\n", addrI, $1, $3);
								pc++;
								$$=addrI;}
			
			| Expression DIV Expression 		{libererRegistre();
								libererRegistre(); 
								int addrI=getRegistre(); 
								printf("DIV @%d @%d @%d\n", addrI, $1, $3);
								pc++;
								$$=addrI;}
			
			| MOINS Expression %prec NEG  		{int addrZ = getRegistre();
								printf("AFC @%d %d\n", addrZ, 0);
								pc++;
								libererRegistre();
								printf("SOU @%d @%d @%d\n", $2, addrZ, $2);
								pc++;
								$$=$2;
								}
			
			| Expression EXP Expression 		{}
			
			| PO Expression PF  			{$$=$2;}
			;			

Bloc_IF:		IF PO Conditions {libererRegistre();} PF Jumpf Body		;						

Bloc_WHILE:		WHILE PO PC Conditions PF Jumpf Body 	{printf("JMP %d\n",$3);
								pc++;
								libererRegistre();};
	
Jumpf :								{int l=newLabel();
								char * nom = getNom(l);
								printf("JMF @%d %s\n",addrCond,nom);
								pc++;};

PC :								{$$=pc;};
								


Affectation :		EGAL Expression PVIR			{libererRegistre();$$=$2;};

Declaration :		INT ID PVIR				{add($2,"int", 0, 0);}
			|INT ID Affectation			{int adresse=add($2,"int", 0, 0);
								if (adresse!=-1){
									printf("COP @%d @%d\n", adresse, $3);
									pc++;}
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
			


			

