#include "labeltable.h"

int compteurNewL=0;
int compteurSetL=0;
struct label tableL[TAILLEL];

int newLabel() {
	
	char nom[10];
	sprintf(nom,"L%d",compteurNewL);
	struct label lab = {nom,-1};
	tableL[compteurNewL]=lab;
	compteurSetL=compteurNewL;
	compteurNewL++;
	return compteurNewL-1;
 }
 
 int setLabel(int place){
 	
 	int reussite=1;
 	if (tableL[compteurSetL].cible==-1){
 		tableL[compteurSetL].cible=place;
 		while (tableL[compteurSetL].cible!=-1 && compteurSetL>0){
 			 	compteurSetL--;
 		}
 	}
 	else{
 		reussite=0;
 	}
 	return reussite;
 }
 
 char * getNom(int indice){
 	
 	return tableL[indice].nom;
 }
 
 int getLabel (int indice) {
 	
 	return tableL[indice].cible;
 }		
