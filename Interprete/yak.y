%{
#include <stdio.h>
#include <stdlib.h>
#include "interpreteur.h"

// Le compteur d'instruction
int i = 0;

void yyerror(char *msg) {
  fflush(stdout);
	fprintf(stderr, "*** %s\n", msg);
  }
int yylex();

%}

%token tADD
%token tMUL
%token tSOU
%token tDIV
%token tCOP
%token tAFC
%token tJMP
%token tJMF
%token tINF
%token tSUP
%token tEQU
%token tPRI
%token tNB

%start S

%%

S: ope S
  | ope ;

ope:   tADD tNB tNB tNB {
                                  ins[i][0] = 0x1; // [i][0] =opé, [i][1] = param 1; i++;
                                  ins[i][1] = $2; // @rés
                                  ins[i][2] = $3; // @opé1
                                  ins[i][3] = $4; // @opé2
                                  i++;
                                }
      |tMUL tNB tNB tNB {
                                  ins[i][0] = 0x2;
                                  ins[i][1] = $2; // @rés
                                  ins[i][2] = $3; // @opé1
                                  ins[i][3] = $4; // @opé2
                                  i++;
                                }

      |tSOU tNB tNB tNB {
                                  ins[i][0] = 0x3;
                                  ins[i][1] = $2; // @rés
                                  ins[i][2] = $3; // @opé1
                                  ins[i][3] = $4; // @opé2
                                  i++;
                                }
      |tDIV tNB tNB tNB {
                                  ins[i][0] = 0x4;
                                  ins[i][1] = $2; // @rés
                                  ins[i][2] = $3; // @opé1
                                  ins[i][3] = $4; // @opé2
                                  i++;
                                }
      |tCOP tNB tNB    {
                                  ins[i][0] = 0x05;
                                  ins[i][1] = $2; //opé1
                                  ins[i][2] = $3; //opé2
                                  i++;
                                }

      |tAFC tNB tNB    {
                                  ins[i][0] = 0x06;
                                  ins[i][1] = $2; //opé1
                                  ins[i][2] = $3; //constante
                                  i++;
                                }


      |tJMP tNB        {
                                  ins[i][0] = 0x7;
                                  ins[i][1] = $2;
                                  i++;
                                }

      |tJMF tNB tNB    {
                                  ins[i][0] = 0x8;
                                  ins[i][1] = $2;
                                  ins[i][2] = $3;
                                  i++;
                                }
      |tINF tNB tNB tNB  {
                                  ins[i][0] = 0x09;
                                  ins[i][1] = $2; // @rés
                                  ins[i][2] = $3; // @opé1
                                  ins[i][3] = $4; // @opé2
                                  i++;
                                }
      |tSUP tNB tNB tNB  {
                                  ins[i][0] = 0xA;
                                  ins[i][1] = $2; // @rés
                                  ins[i][2] = $3; // @opé1
                                  ins[i][3] = $4; // @opé2
                                  i++;
                                }
      |tEQU tNB tNB tNB  {
                                  ins[i][0] = 0xB;
                                  ins[i][1] = $2; // @rés
                                  ins[i][2] = $3; // @opé1
                                  ins[i][3] = $4; // @opé2
                                  i++;
                                }
      |tPRI tNB        {
                                  ins[i][0] = 0xC;
                                  ins[i][1] = $1;
                                  i++;
                                }
      

%%

int main()
{

    yyparse();
    int n = 0;
    int flag = 0;
    while(n < i)
    {
      switch(ins[n][0])
      {
        case 0x1 : //tADD
        {
          int somme = get(ins[n][2]) + get(ins[n][3]);
          mem(ins[n][1],somme);
          break;
        }
        case 0x2 : //tMUL
        {
          int produit = get(ins[n][2])*get(ins[n][3]);
          mem(ins[n][1],produit);
          break;
        }
        case 0x3  : //SOU
        {
          int difference = get(ins[n][2]) - get(ins[n][3]);
          mem(ins[n][1], difference);
          break;
        }
        case 0x4 : //DIV
        {
          int quotient = get(ins[n][2]) / get(ins[n][3]);
          mem(ins[n][1], quotient);
          break;
        }
        case 0x5 : //COP
        {
          mem(ins[n][1], get(ins[n][2]));
          break;
        }
        case 0x6  : //AFC
        {
          mem(ins[n][1], ins[n][2]);
          break;
        }
        case 0x7 : //JMP
        {
          n = ins[n][1];
          flag = 1 ;
          break;
        }
        case 0x8  : //JMF
        {
          if(get(ins[n][1]== 0))
          {
            n = ins[n][2] ;
            flag = 1 ;
          }

          break;
        }
        case 0x9  : //INF
        {
          if (ins[n][2] < ins[n][3])
          {
            ins[n][1] = 1; // TRUE
            }else{
            ins[n][1] = 0; // FALSE
          }
          break;
        }
        case 0xA  : //SUP
        {
        if (ins[n][2] > ins[n][3])
        {
          ins[n][1] = 1; // TRUE
          }else{
          ins[n][1] = 0; // FALSE
        }
          break;
        }
        case 0xB  : //EQU
        {
        if (ins[n][2] == ins[n][3])
        {
          ins[n][1] = 1; // TRUE
          }else{
          ins[n][1] = 0; // FALSE
        }

          break;
        }
        case 0xC  : //PRI
        {
          //TODO: implémenter le printf

          break;
        }

      }
      if(flag == 0)
      {
        n++;
      }
      flag = 0;
    }
}
