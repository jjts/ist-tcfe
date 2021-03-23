close all
clear all

%%EXAMPLE SYMBOLIC COMPUTATIONS

pkg load symbolic
 R1=1.00781211614e3
 R2=2.003112223204e3
 R3=3.04503555589e3
 R4=4.17896607062e3
 R5=3.10615699135e3
 R6=2.06090134563e3
 R7=1.00634569025e3
 Va=5.04864033546
 I=1.02502620056e-3
 Kb=7.05958243757e-3
 Kc=8.03913881798e3
G1=1/R1
G2=1/R2
G3=1/R3
G4=1/R4
G5=1/R5
G6=1/R6
G7=1/R7
 A=[0,0,0,1;R1+R3+R4,-R3,-R4,0;-R4,0,R4+R6+R7-Kc,0;-R3*Kb,R3*Kb-1,0,0]
 B=[I;-Va;0;0]
 C=A\B
 D=[1,0,0,0,0,0,0;0,G1+G2+G3,-G2,-G3,0,0,0;0,G1+Kb,-G2,-Kb,0,0,0;0,0,0,0,0,G6+G7,-G7;0,0,0,1,0,-Kc*G6,-1;0,Kb,0,-Kb-G5,G5,0,0;G1,-G1,0,-G4,0,-G6,0]
 E=[Va;0;0;0;0;I;0]
 F=D\E
Ia=C(1,1)
Ib=C(2,1)
Ic=C(3,1)
Id=C(4,1)
V0=F(1,1)
V1=F(2,1)
V2=F(3,1)
V4=F(4,1)
V5=F(5,1)
V6=F(6,1)
V7=F(7,1)

 fid=fopen("data_current_tab.tex","w")
fprintf(fid,"@$I_{a}$ & %f \\\\ \hline \n",Ia)
fprintf(fid,"@$I_{b}$ & %f \\\\ \hline \n",Ib)
fprintf(fid,"@$I_{c}$ & %f \\\\ \hline \n",Ic)
fprintf(fid,"@$I_{d}$ & %f \\\\ \hline \n",Id)
fclose(fid)

 fid=fopen("data_voltage_tab.tex","w")
fprintf(fid,"@$V_{0}$ & %f \\\\ \hline \n",V0)
fprintf(fid,"@$V_{1}$ & %f \\\\ \hline \n",V1)
fprintf(fid,"@$V_{2}$ & %f \\\\ \hline \n",V2)
fprintf(fid,"@$V_{4}$ & %f \\\\ \hline \n",V4)
fprintf(fid,"@$V_{5}$ & %f \\\\ \hline \n",V5)
fprintf(fid,"@$V_{6}$ & %f \\\\ \hline \n",V6)
fprintf(fid,"@$V_{7}$ & %f \\\\ \hline \n",V7)
fclose(fid)

 
