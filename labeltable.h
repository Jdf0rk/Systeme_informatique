#include <stdio.h>
#include <string.h>

#define TAILLEL 1000 

struct label {

	char * nom;
	int cible;
};

int newLabel();

int setLabel(int place);

char * getNom(int indice);
