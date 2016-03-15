#include "./interpreteur.h"

//Notre jolie tableau de données
int memoire[TAILLE_TABLEAU];


void mem(int adresse, int valeur)
{
  memoire[adresse] = valeur;
}


int get(int adresse)
{
  int res = memoire[adresse];
  return res;
}
