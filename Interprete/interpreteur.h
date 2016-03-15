// Ce fichier sert à déclarer les variables globales
// utilisées dans le yacc de l'interpreteur.
#DEFINE NB_INSTRUCTIONS 10000
#DEFINE TAILLE_TABLEAU 1100

// Notre tableau d'instruction
int ins[NB_INSTRUCTIONS][4];

// Le compteur d'instruction
int i = 0;

// Les fonctions necessaire pour manipuler nos données
void mem(int adresse, int valeur);
int get(int adresse);
