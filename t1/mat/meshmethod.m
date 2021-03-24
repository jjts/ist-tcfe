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

M=[R1+R3+R4 -R3 -R4; R4 0 Kc-R4-R6-R7; R3 -R3+1/Kb 0]

V=[Va; 0; 0]
I=M\V
Ia=I(1)
Ib=I(2)
Ic=I(3)

file = fopen ("meshmethod.tex", "w");
fprintf(file, "$I_a$ & %e \\\\ \\hline \n", Ia);
fprintf(file, "$I_b$ & %e \\\\ \\hline \n", Ib);
fprintf(file, "$I_c$ & %e \\\\ \\hline \n", Ic);
fprintf(file, "$I_d$ & %e \\\\ \\hline \n", Id);
fclose (file);