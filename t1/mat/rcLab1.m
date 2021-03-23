close all
clear all
format long e

pkg load symbolic

#Declaration of the values given by the python script
R1 = 1.03431507833e003;
R2 = 2.02853090731e003;
R3 = 3.1462050633e003;
R4 = 4.03438547455e003;
R5 = 3.12170042214e003;
R6 = 2.07116379646e003;
R7 = 1.01597753093e003;
Va = 5.156959346;
Id = 1.01455683569e-003;
Kb = 7.1497941196e-003;
Kc = 8.12593642585e003;

#Matrix of the mesh method and additional equations
A = [R1+R3+R4,-R3,-R4;...
-R4,0,R4+R6+R7-Kc;...
-Kb*R3,Kb*R3-1,0];
#Matrix of the results
B = [-Va;0;0];

#Matrix of the current values
I = A\B

#Atribuitions of the values to the variables and other calculations
printf ("octaveI_TAB\n");
IA = I(1,1)
IB = I(2,1)
IC = I(3,1)
ID = Id
Ib = IB
Ic = IC
Vb = Ib/Kb
Vc = Kc*Ic
printf ("octaveI_END\n");

#Calculation of the G values of each resistor
G1 = 1/R1;
G2 = 1/R2;
G3 = 1/R3;
G4 = 1/R4;
G5 = 1/R5;
G6 = 1/R6;
G7 = 1/R7;

#Matrix of the node method and additional equations
C = [1,0,0,0,0,0,0,0;...
-G1-G2-G3,G1,G2,G3,0,0,0,0;...
Kb+G2,0,-G2,-Kb,0,0,0,0;...
0,1,0,0,-1,0,0,0;...
-Kb,0,0,Kb+G5,0,-G5,0,0;...
0,0,0,0,G6,0,-G6-G7,G7;...
0,0,0,1,-Kc*G6,0,Kc*G6,-1;...
G3,0,0,-G4-G3-G5,G4,G5,G7,-G7];

#Matrix of the results
D = [0;0;0;Va;-Id;0;0;Id];

#Matrix of the voltage values
V = C\D;

#Atribuitions of the values to the variables and other calculations
printf ("octavev_TAB\n");
V0 = V(1,1)
V1 = V(2,1)
V2 = V(3,1)
V3 = V(4,1)
V4 = V(5,1)
V5 = V(6,1)
V6 = V(7,1)
V7 = V(8,1)
Vb = V0 - V3
Ib = Vb*Kb
Vc = V3 - V7
Ic = Vc/Kc
printf ("octavev_END\n");



