%{
#include <stdio.h>
#include <stdlib.h>
#include "./interpreteur.h"
%}

%token ADD
%token MUL
%token SOU
%token DIV
%token COP
%token AFC
%token JMP
%token JMF
%token INF
%token SUP
%token EQU
%token PRI
%token NB

%start S

%%
S: opé S {

ADD:        ADD NB NB NB {
                            ins[i][0] = 0x1; // [i][0] =opé, [i][1] = param 1; i++;
                            ins[i][1] = $2; // @rés
                            ins[i][2] = $3; // @opé1
                            ins[i][3] = $4; // @opé2
                            i++;
                          }
MUL:        MUL NB NB NB {
                            ins[i][0] = 0x2;
                            ins[i][1] = $2; // @rés
                            ins[i][2] = $3; // @opé1
                            ins[i][3] = $4; // @opé2
                            i++;
                          }

SOU:        SOU NB NB NB {
                            ins[i][0] = 0x3;
                            ins[i][1] = $2; // @rés
                            ins[i][2] = $3; // @opé1
                            ins[i][3] = $4; // @opé2
                            i++;
                          }
DIV:        DIV NB NB NB {
                            ins[i][0] = 0x4;
                            ins[i][1] = $2; // @rés
                            ins[i][2] = $3; // @opé1
                            ins[i][3] = $4; // @opé2
                            i++;
                          }
COP:        COP NB NB    {
                            ins[i][0] = 0x05;
                            ins[i][1] = $2; //opé1
                            ins[i][2] = $3; //opé2
                            i++;
                          }

AFC:        AFC NB NB    {
                            ins[i][0] = 0x06;
                            ins[i][1] = $2; //opé1
                            ins[i][2] = $3; //constante
                            i++;
                          }


JMP:        JMP NB        {
                            ins[i][0] = 0x7;
                            ins[i][1] = $2;
                            i++;
                          }

JMF:        JMF NB NB    {
                            ins[i][0] = 0x8;
                            ins[i][1] = $2;
                            ins[i][2] = $3;
                            i++;
                          }
INF:        INF NB NB NB  {
                            ins[i][0] = 0x09;
                            ins[i][1] = $2; // @rés
                            ins[i][2] = $3; // @opé1
                            ins[i][3] = $4; // @opé2
                            i++;
                          }
SUP:        SUP NB NB NB  {
                            ins[i][0] = 0xA;
                            ins[i][1] = $2; // @rés
                            ins[i][2] = $3; // @opé1
                            ins[i][3] = $4; // @opé2
                            i++;
                          }
EQU:        EQU NB NB NB  {
                            ins[i][0] = 0xB;
                            ins[i][1] = $2; // @rés
                            ins[i][2] = $3; // @opé1
                            ins[i][3] = $4; // @opé2
                            i++;
                          }
PRI:        PRI NB        {
                            ins[i][0] = 0xC;
                            ins[i][1] = $1;
                            i++;
                          }

        }

%%
yyparse();
int n = 0;
int flag = 0;
while(n < i)
{
  switch(ins[n][0])
  {
    case 0x1 : //ADD
    {
      int somme = get(ins[n][2]) + get(ins[n][3]);
      mem(ins[n][1],somme);
      break;
    }
    case 0x2 : //MUL
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
      flag = 1
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
      
      break;
    }
    case 0xA  :
    {

      break;
    }
    case 0xB  :
    {

      break;
    }
    case 0xC  :
    {

      break;
    }

  }
  if(flag == 0)
  {
    n++;
  }
  flag = 0;
}
