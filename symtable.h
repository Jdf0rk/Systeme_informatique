#include <stdio.h>
#include <string.h>
#define TAILLE 1100 
#define TAILLEVAR 1000



struct variable {

	char * nom;
	char * type;
	int initialise;
	int constante;
};


int add (char* nom, char* type, int init, int cons);

int getVarAddr (char * nom);

int getRegistre ();

int libererRegistre();

void affTable();
