// Ce fichier sert à déclarer les variables globales
// utilisées dans le yacc de l'interpreteur.
#define NB_INSTRUCTIONS 10000
#define TAILLE_TABLEAU 1100

// Notre tableau d'instruction
int ins[NB_INSTRUCTIONS][4];

// Les fonctions necessaire pour manipuler nos données
void mem(int adresse, int valeur);
int get(int adresse);
