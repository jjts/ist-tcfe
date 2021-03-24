clear all

R1 = 1.01080769792 
R2 = 2.07664633274 
R3 = 3.12595649013 
R4 = 4.18722214507 
R5 = 3.0841699201 
R6 = 2.00179338129 
R7 = 1.04556537884 
Va = 5.00120775651 
Id = 1.03136220214 
Kb = 7.12593545434 
Kc = 8.24048597287
G1=1/R1;
G2=1/R2;
G3=1/R3;
G4=1/R4;
G5=1/R5;
G6=1/R6;
G7=1/R7;

M=[G1 -G1-G2 G2 0 0 0 0 0 -G3 0; ...
    0 G2 -G2 0 0 0 0 0 Kb 0; ...
    0 0 0 0 G5 -G5 0 0 -Kb 0; ...
    0 0 0 G6 0 0 -G6 0 0 -1/Kc; ...
    0 0 0 0 0 0 -G7 G7 0 1/Kc; ...
    1 0 0 -1 0 0 0 0 0 0; ...
    0 1 0 0 -1 0 0 0 -1 0; ...
    0 0 0 0 1 0 0 0 0 0; ...
    0 0 0 0 1 0 0 -1 0 -1; ...
    -G1 G1 0 -G4 G4 0 0 0 0 -1/Kc]
V=[0; 0; -Id; 0; 0; Va; 0; 0; 0; 0]
I=M\V
V1=I(1)
V2=I(2)
V3=I(3)
V4=I(4)
V5=I(5)
V6=I(6)
V7=I(7)
V8=I(8)
Vb=I(9)
Vc=I(10)

file = fopen ("nodemethod.tex", "w");
fprintf(file, "$V_5$ & %e \\\\ \\hline \n", V5);
fprintf(file, "$V_1$ & %e \\\\ \\hline \n", V1);
fprintf(file, "$V_2$ & %e \\\\ \\hline \n", V2);
fprintf(file, "$V_3$ & %e \\\\ \\hline \n", V3);
fprintf(file, "$V_4$ & %e \\\\ \\hline \n", V4);
fprintf(file, "$V_6$ & %e \\\\ \\hline \n", V6);
fprintf(file, "$V_7$ & %e \\\\ \\hline \n", V7);
fprintf(file, "$V_8$ & %e \\\\ \\hline \n", V8);
fprintf(file, "$V_a$ & %e \\\\ \\hline \n", Va);
fprintf(file, "$V_b$ & %e \\\\ \\hline \n", Vb);
fprintf(file, "$V_c$ & %e \\\\ \\hline \n", Vc);
fclose (file);