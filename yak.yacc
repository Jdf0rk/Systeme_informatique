%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symtable.h"
#include "labeltable.h"

int pc=0;
int addrCond=-1;
char chaine[50];
FILE* fichier=NULL;
FILE* fichier2=NULL;
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

DFonction : 		INT ID PO Parametres PF Body; //changer eventuellement ID par main

Parametres : 		INT ID SuiteParametres
			|;
SuiteParametres : 	VIR INT ID SuiteParametres
			|;
			
Body :			AO Instructions AF			{setLabel(pc);};

Instruction :		ID Affectation				{int adresse=getVarAddr($1);
								//printf("COP @%d @%d\n", adresse, $2);
								sprintf(chaine,"5 %d %d\n",adresse, $2);
								fputs(chaine, fichier);
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
								//printf("INF @%d @%d @%d\n", addrCond, $1, $3);
								sprintf(chaine,"9 %d %d %d\n",addrCond, $1, $3);
								fputs(chaine, fichier);
								pc++;
								$$=addrCond;
								}
								
			|Expression SUP Expression		{libererRegistre();libererRegistre();
								addrCond=getRegistre();
								//printf("SUP @%d @%d @%d\n", addrCond, $1, $3);
								sprintf(chaine,"A %d %d %d\n",addrCond, $1, $3);
								fputs(chaine, fichier);
								pc++;
								$$=addrCond;
								}
								
			|Expression EGAL EGAL Expression	{libererRegistre();libererRegistre();
								addrCond=getRegistre();
								//printf("EQU @%d @%d @%d\n", addrCond, $1, $4);
								sprintf(chaine,"B %d %d %d\n",addrCond, $1, $4);
								fputs(chaine, fichier);
								pc++;
								$$=addrCond;
								};
			

Conditions: 		Condition OR Conditions			{int addrZ = getRegistre();
								//printf("AFC @%d %d\n",addrZ,0);
								sprintf(chaine,"6 %d %d\n",addrZ, 0);
								fputs(chaine, fichier);			
								pc++;
								//printf("ADD @%d @%d @%d\n", $1, $1, $3);
								sprintf(chaine,"1 %d %d %d\n",$1, $1, $3);
								fputs(chaine, fichier);	
								pc++;
								//printf("SUP @%d @%d @%d\n", $1, $1, addrZ);
								sprintf(chaine,"A %d %d %d\n",$1, $1, addrZ);
								fputs(chaine, fichier);	
								pc++;
								libererRegistre();
								addrCond=$1;
								}
			
			|Condition AND Conditions		{int addrD = getRegistre();
								//printf("AFC @%d %d\n", addrD, 2);
								sprintf(chaine,"6 %d %d\n",addrD, 2);
								fputs(chaine, fichier);						
								pc++;
								//printf("ADD @%d @%d @%d\n", $1, $1, $3);
								sprintf(chaine,"1 %d %d %d\n",$1, $1, $3);
								fputs(chaine, fichier);	
								pc++;
								//printf("EQU @%d @%d @%d\n", $1, $1, addrD);
								sprintf(chaine,"B %d %d %d\n", $1, $1, addrD);
								fputs(chaine, fichier);
								pc++;
								libererRegistre();
								addrCond=$1;
								}
		
			|Condition				{};

Expression:		ID 					{int addr = getVarAddr($1);
								int addrI = getRegistre(); 
								if (addr==-1){//printf("La variable n'est pas déclarée\n");
									yyerror("La variable n'est pas déclarée\n");}
								else {//printf("COP @%d @%d\n", addrI, addr);
								sprintf(chaine,"5 %d %d\n",addrI, addr);
								fputs(chaine, fichier);
								pc++;
								$$=addrI;}}
 			
			|ENTIER 				{int addrI=getRegistre(); 
								//printf("AFC @%d %d\n", addrI, $1); 
								sprintf(chaine,"6 %d %d\n",addrI, $1);
								fputs(chaine, fichier);	
								pc++;
								$$ = addrI; }
			
			| Expression PLUS Expression 		{libererRegistre();
								libererRegistre(); 
								int addrI=getRegistre(); 
								//printf("ADD @%d @%d @%d\n", addrI, $1, $3);
								sprintf(chaine,"1 %d %d %d\n",addrI, $1, $3);
								fputs(chaine, fichier);	
								pc++;
								$$=addrI;}
			
			| Expression MOINS Expression 		{libererRegistre();
								libererRegistre(); 
								int addrI=getRegistre(); 
								//printf("SOU @%d @%d @%d\n", addrI, $1, $3);
								sprintf(chaine,"3 %d %d %d\n",addrI, $1, $3);
								fputs(chaine, fichier);	
								pc++;
								$$=addrI;}
			
			| Expression MULT Expression 		{libererRegistre();
								libererRegistre(); 
								int addrI=getRegistre(); 
								//printf("MUL @%d @%d @%d\n", addrI, $1, $3);
								sprintf(chaine,"2 %d %d %d\n",addrI, $1, $3);
								fputs(chaine, fichier);	
								pc++;
								$$=addrI;}
			
			| Expression DIV Expression 		{libererRegistre();
								libererRegistre(); 
								int addrI=getRegistre(); 
								//printf("DIV @%d @%d @%d\n", addrI, $1, $3);
								sprintf(chaine,"4 %d %d %d\n",addrI, $1, $3);
								fputs(chaine, fichier);	
								pc++;
								$$=addrI;}
			
			| MOINS Expression %prec NEG  		{int addrZ = getRegistre();
								//printf("AFC @%d %d\n", addrZ, 0);
								sprintf(chaine,"6 %d %d\n",addrZ, 0);
								fputs(chaine, fichier);	
								pc++;
								libererRegistre();
								//printf("SOU @%d @%d @%d\n", $2, addrZ, $2);
								sprintf(chaine,"3 %d %d %d\n", $2, addrZ, $2);
								fputs(chaine, fichier);	
								pc++;
								$$=$2;
								}
			
			| Expression EXP Expression 		{}
			
			| PO Expression PF  			{$$=$2;}
			;			

Bloc_IF:		IF PO Conditions {libererRegistre();} PF Jumpf Body		;						

Bloc_WHILE:		WHILE PO PC Conditions PF Jumpf Body 	{//printf("JMP %d\n",$3);
								sprintf(chaine,"7 %d\n",$3);
								fputs(chaine, fichier);	
								pc++;
								libererRegistre();};
	
Jumpf :								{int l=newLabel();
								char * nom = getNom(l);
								//printf("JMF @%d %s\n",addrCond,nom);
								sprintf(chaine,"8 %d %s\n", addrCond, nom);
								fputs(chaine, fichier);	
								pc++;};

PC :								{$$=pc;};
								


Affectation :		EGAL Expression PVIR			{libererRegistre();$$=$2;};

Declaration :		INT ID PVIR				{add($2,"int", 0, 0);}

			|INT ID Affectation			{int adresse=add($2,"int", 0, 0);
								if (adresse!=-1){
									//printf("COP @%d @%d\n", adresse, $3);
									sprintf(chaine,"5 %d %d\n",adresse, $3);
									fputs(chaine, fichier);
									pc++;}
								else{
									//printf("variable déjà déclarée\n");}
									yyerror("La variable n'est pas déclarée\n");}					
								};



AFonction :		ID PO Parametres PF PVIR;



%%
int yyerror(char *s) {
	printf("%s\n",s);
	fclose(fichier);
	fichier = fopen("./assembleur", "w+");
	fprintf (fichier,"%s\n",s);
	fclose(fichier);
	exit(666);
}

int main(void) {
 
 	char car;
 	char tcar[3];
 	int label;
 	int i=0;
	fichier = fopen("./temp", "w+");
	yyparse();
	//on remplace les labels par leur valeur dans la table
	fclose(fichier);
	fichier = fopen("./temp", "r");
	fichier2 = fopen("./assembleur", "w+");
	car = fgetc(fichier); // On lit le caractère
	while (car != EOF) {
		if (car != 'L') {
			fputc(car,fichier2);
		}else{
			label = 0;
			car = fgetc(fichier);
			//fseek(fichier, 1, SEEK_CUR);
			while (car != '\n' && car != EOF){
				//tcar[i]=fgetc(fichier);
				//i++;
				label = label * 10 + car - '0';
				car = fgetc(fichier);
			}
			printf("LABEL: %d %d\n", label, getLabel(label));
			fprintf(fichier2, "%d\n", getLabel(label));
			if (car == EOF) {
				break;
			}
		}
		car = fgetc(fichier); // On lit le caractère
        }
        
        fclose(fichier);
  	fclose(fichier2);
}
			


			

