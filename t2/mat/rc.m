close all
clear all


R1 = 1.03919759193e+3
R2 = 2.06836523173e+3
R3 = 3.03375774261e+3 
R4 = 4.12779067183e+3 
R5 = 3.11985677803e+3 
R6 = 2.04513887844e+3 
R7 = 1.04289965713e+3
    
Va = 5.00439410964 

Id = 1.04536428769e-3
Kb = 7.25705461539e-3 
Kc = 8.23640363075e-3 



G1 = 1/R1
G2 = 1/R2
G3 = 1/R3
G4 = 1/R4
G5 = 1/R5
G6 = 1/R6
G7 = 1/R7
G67 = 1/(R6+R7)  


#------------------nodal analysis------------------------

#conductance matrix 
A=[G1+G2+G3, -G2, 0, -1*(1-Kc*G67)*G3; -G2-Kb, G2, 0, Kb*(1-Kc*G67); Kb, 0, G5, -1*(G5+Kb)*(1-Kc*G67); -G3, 0, -G5, (1-Kc*G67)*(G3+G4+G5) + G67 ]

#Stimuli vector 
B=[Va*G1; 0; Id; -Id]

x=A\B

filename = "nodal_octave.tex";
fid = fopen (filename, "w+");

fprintf(fid, "\\begin{table}[h] \n \\centering \n \\begin{tabular}{ c c } \n")
fprintf(fid, "\\hline\n")
fprintf(fid, "V2 & %f \\\\ \n ", x(1))
fprintf(fid, "\\hline\n")
fprintf(fid, "V3 & %f \\\\ \n ", x(2))
fprintf(fid, "\\hline\n")
fprintf(fid, "V5 & %f \\\\ \n ", x(3))
fprintf(fid, "\\hline\n")
fprintf(fid, "V7 & %f \\\\ \n ", x(4))
fprintf(fid, "\\hline\n")
fprintf(fid, "  \\end{tabular} \n \\caption{Results of Nodal Analysis using Octave} \n \\label{tab:mesh_results} \n \\end{table} \n ")


fclose (fid);

#------------------mesh analysis -------------------------	

#Resistance matrix 
C = [R1+R3+R4, -R3, -R4, 0; (Kb*R3)/(1-Kb*R3), 1, 0 , 0; -R4, 0, (R4+R6+R7-Kc), 0; 0,0,0,1 ]


#Stimuli vector 
D = [-Va; 0 ; 0 ; Id] 

x=C\D

filename = "mesh_octave.tex";
fid = fopen (filename, "w+");

fprintf(fid, "\\begin{table}[h] \n \\centering \n \\begin{tabular}{ c c } \n")

fprintf(fid, "\n \\hline\n")
fprintf(fid, "$y_1$ & %f \\\\ \n ", x(1))
fprintf(fid, "\\hline\n")
fprintf(fid, "$y_2$ & %f \\\\ \n ", x(2))
fprintf(fid, "\\hline\n")
fprintf(fid, "$y_3$ & %f \\\\ \n ", x(3))
fprintf(fid, "\\hline\n")
fprintf(fid, "$y_4$ & %f \\\\ \n ", x(4))
fprintf(fid, "\\hline\n")

fprintf(fid, "  \\end{tabular} \n \\caption{Results of Mesh Analysis using Octave} \n \\label{tab:mesh_results} \n \\end{table} \n ")


fclose (fid);