#include "symtable.h"

int compteur=0;
int compteurReg=0;
struct variable table[TAILLE];


int getVarAddr(char* nomV){
	
	int i=0;
	int found=-1;
	while (found==-1 && i<compteur){
		if (strcmp(table[i].nom,nomV)==0)
			found=i;
		i++;
	}
	return found;
}


int add (char* nom, char * type, int init, int cons){
	
	int res =-1;
	if (getVarAddr(nom)!=-1 || compteur>TAILLEVAR){
		res=-1;
	}
	else {	
		struct variable varTab = {nom, type, init, cons};
		table[compteur]= varTab;
		res=compteur;
		compteur++;
	}
	return res;
	
}

		
int getRegistre (){
	
	struct variable varTab = {"registre","registre",0,0};
	table[TAILLEVAR + compteurReg]=varTab;
	compteurReg=(compteurReg+1);
	return TAILLEVAR + compteurReg-1;
	
}

int libererRegistre(){
	
	compteurReg--;
}

void affTable() {
	
	int i;
	printf("Voici les variables : \n\n");
	for (i=0;i<compteur;i++){
		
		printf("%s %s  %d %d\n",table[i].nom, table[i].type, table[i].initialise, table[i].constante);
	}
	printf("Voici les registres : \n\n");
	for (i=TAILLEVAR;i<TAILLEVAR + compteurReg;i++){
		
		printf("%s %s  %d %d\n",table[i].nom, table[i].type, table[i].initialise, table[i].constante);
	}
	
}


