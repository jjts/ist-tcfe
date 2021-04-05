close all
clear all
format long

b=fileread('data.txt');

a = strsplit(b, ' ');

data=[];

for i=1:length(a)
  try
  if isnumeric(eval(char(a(i))))
    data=[data;a(i)];
  end  
  
  catch
  
  end_try_catch 

end

R1 = str2double(data(1))
R2 = str2double(data(2)) 
R3 = str2double(data(3)) 
R4 = str2double(data(4)) 
R5 = str2double(data(5))
R6 = str2double(data(6)) 
R7 = str2double(data(7)) 
Vs = str2double(data(8))
C  = str2double(data(9)) 
Kb = str2double(data(10)) 
Kd = str2double(data(11))
Vs_6 = Vs
datatex = fopen ("data.tex", "w");
fprintf(datatex, "$R_1$ & %.11f \\\\ \\hline \n", R1);
fprintf(datatex, "$R_2$ & %.11f \\\\ \\hline \n", R2);
fprintf(datatex, "$R_3$ & %.11f \\\\ \\hline \n", R3);
fprintf(datatex, "$R_4$ & %.11f \\\\ \\hline \n", R4);
fprintf(datatex, "$R_5$ & %.11f \\\\ \\hline \n", R5);
fprintf(datatex, "$R_6$ & %.11f \\\\ \\hline \n", R6);
fprintf(datatex, "$R_7$ & %.11f \\\\ \\hline \n", R7);
fprintf(datatex, "$C$ & %.11f \\\\ \\hline \n", C);
fprintf(datatex, "$K_b$ & %.11f \\\\ \\hline \n", Kb);
fprintf(datatex, "$K_d$ & %.11f \\\\ \\hline \n", Kd);
fclose (datatex);

%%% 1 %%%

A1 = [1,0,0,0,0,0,0,0,0;0,0,0,0,0,Kd/R6,0,0,-1;1/R1,(-1/R1)-(1/R2)-(1/R3),1/R2,1/R3,0,0,0,0,0;0,1/R2,-1/R2,0,0,0,0,-Kb,0;0,0,0,1,0,0,-1,0,1;0,1/R3,0,(-1/R4)-(1/R3)-(1/R5),1/R5,1/R7,-1/R7,0,0;0,0,0,1/R5,-1/R5,0,0,Kb,0;0,0,0,0,0,-(1/R6)-(1/R7),1/R7,0,0;0,1,0,-1,0,0,0,1,0];
      
B1 = [Vs;0;0;0;0;0;0;0;0];

sol1 = A1\B1;
 
V1 = sol1(1)
V2 = sol1(2)
V3 = sol1(3)
V5 = sol1(4)
V6 = sol1(5)
V7 = sol1(6)
V8 = sol1(7)
Vb = sol1(8)
Vd = sol1(9)
Vs = V1
V6e = V6

I1 = (V2-V1)/R1
I2 = Kb*Vb
I3 = (V5-V2)/R3
I4 = V5/R4
I5 = (V6-V5)/R5
I6 = Vd/Kd
I7 = Vd/Kd
Is = I1
Ib = Kb*Vb
Id = Vd/Kd

file1atex = fopen ("nodes1a.tex", "w");
fprintf(file1atex, "$V_1$ & %f \\\\ \\hline \n", V1);
fprintf(file1atex, "$V_2$ & %e \\\\ \\hline \n", V2);
fprintf(file1atex, "$V_3$ & %e \\\\ \\hline \n", V3);
fprintf(file1atex, "$V_5$ & %e \\\\ \\hline \n", V5);
fprintf(file1atex, "$V_6$ & %e \\\\ \\hline \n", V6);
fprintf(file1atex, "$V_7$ & %e \\\\ \\hline \n", V7);
fprintf(file1atex, "$V_8$ & %e \\\\ \\hline \n", V8);
fprintf(file1atex, "$V_b$ & %e \\\\ \\hline \n", Vb);
fprintf(file1atex, "$V_d$ & %e \\\\ \\hline \n", Vd);
fprintf(file1atex, "$V_s$ & %e \\\\ \\hline \n", Vs);
fclose (file1atex);

file1btex = fopen ("nodes1b.tex", "w");
fprintf(file1btex, "$I_1$ & %f \\\\ \\hline \n", I1);
fprintf(file1btex, "$I_2$ & %e \\\\ \\hline \n", I2);
fprintf(file1btex, "$I_3$ & %e \\\\ \\hline \n", I3);
fprintf(file1btex, "$I_4$ & %e \\\\ \\hline \n", I4);
fprintf(file1btex, "$I_5$ & %e \\\\ \\hline \n", I5);
fprintf(file1btex, "$I_6$ & %e \\\\ \\hline \n", I6);
fprintf(file1btex, "$I_7$ & %e \\\\ \\hline \n", I7);
fprintf(file1btex, "$I_b$ & %e \\\\ \\hline \n", Ib);
fprintf(file1btex, "$I_d$ & %e \\\\ \\hline \n", Id);
fprintf(file1btex, "$I_s$ & %e \\\\ \\hline \n", Is);
fclose (file1btex);

tabend1 = '"t2-1_END"'
tab1 = '"t2-1_TAB"'
file1sim = fopen ("ex1.cir", "w");
fprintf(file1sim, "ngspice T2-1 \n \n");
fprintf(file1sim, ".options savecurrents \n \n");
fprintf(file1sim, "Vs n1 GND %f \n", Vs);
fprintf(file1sim, "V0 GND n9 0 \n");
fprintf(file1sim, "R1 n2 n1 %fk \n", R1);
fprintf(file1sim, "R2 n3 n2 %fk \n", R2);
fprintf(file1sim, "R3 n2 n5 %fk \n", R3);
fprintf(file1sim, "R4 n5 GND %fk \n", R4);
fprintf(file1sim, "R5 n6 n5 %fk \n", R5);
fprintf(file1sim, "R6 n7 n9 %fk \n", R6);
fprintf(file1sim, "R7 n8 n7 %fk \n", R7);
fprintf(file1sim, "H1 n5 n8 V0 %fk \n", Kd);
fprintf(file1sim, "G1 n6 n3 n2 n5 %fm \n", Kb);
fprintf(file1sim, "C1 n6 n8 %fu \n \n", C);
fprintf(file1sim, ".control \n \n");
fprintf(file1sim, "op \n");
fprintf(file1sim, "echo %s \n", tab1);
fprintf(file1sim, "print all \n");
fprintf(file1sim, "echo %s \n \n", tabend1);
fprintf(file1sim, "quit \n");
fprintf(file1sim, ".endc \n \n");
fprintf(file1sim, ".end");
fclose (file1sim);

%% 2 %% 

Vs=0
Vx = 5.731698770731526+3.011723144554779
A2 = [1,0,0,0,0,0,0,0,0,0; ...
      1/R1,-(1/R1)-(1/R2)-(1/R3),1/R2,1/R3,0,0,0,0,0,0; ...
      0,1/R2,-1/R2,0,0,0,0,-Kb,0,0; ...
      0,1/R3,0,-1/R3-(1/R4)-(1/R5),1/R5,1/R7,-1/R7,0,0,-Vx; ...
      0,0,0,1/R5,-1/R5,0,0,Kb,0,Vx; ...
      0,0,0,0,0,-1/R6-(1/R7),1/R7,0,0,0; ...
      0,0,0,0,0,-1/R6,0,0,1/Kd,0; ...
      0,-1,0,1,0,0,0,1,0,0; ...
      0,0,0,0,1,0,-1,0,0,0; ...
      0,0,0,1,0,0,-1,0,1,0];
      
B2 = [0;0;0;0;0;0;0;0;Vx;0];

sol2 = A2\B2;
 
V1 = sol2(1)
V2 = sol2(2)
V3 = sol2(3)
V5 = sol2(4)
V6 = sol2(5)
V7 = sol2(6)
V8 = sol2(7)
Vb = sol2(8)
Vd = sol2(9)
Req= 1/sol2(10)
Vs = V1

I1 = (V2-V1)/R1
I2 = Vb/Kb
I3 = (V5-V2)/R3
I4 = V5/R4
I5 = (V6-V5)/R5
I6 = Vd/Kd
I7 = Vd/Kd
Is = I1
Ib = Kb*Vb
Id = Vd/Kd
Ix = Vx/Req

file2atex = fopen ("nodes2a.tex", "w");
fprintf(file2atex, "$V_1$ & %f \\\\ \\hline \n", V1);
fprintf(file2atex, "$V_2$ & %e \\\\ \\hline \n", V2);
fprintf(file2atex, "$V_3$ & %e \\\\ \\hline \n", V3);
fprintf(file2atex, "$V_5$ & %e \\\\ \\hline \n", V5);
fprintf(file2atex, "$V_6$ & %e \\\\ \\hline \n", V6);
fprintf(file2atex, "$V_7$ & %e \\\\ \\hline \n", V7);
fprintf(file2atex, "$V_8$ & %e \\\\ \\hline \n", V8);
fprintf(file2atex, "$V_b$ & %e \\\\ \\hline \n", Vb);
fprintf(file2atex, "$V_d$ & %e \\\\ \\hline \n", Vd);
fprintf(file2atex, "$V_s$ & %e \\\\ \\hline \n", Vs);
fprintf(file2atex, "$V_x$ & %e \\\\ \\hline \n", Vx);
fclose (file2atex);

file2btex = fopen ("nodes2b.tex", "w");
fprintf(file2btex, "$I_1$ & %f \\\\ \\hline \n", I1);
fprintf(file2btex, "$I_2$ & %e \\\\ \\hline \n", I2);
fprintf(file2btex, "$I_3$ & %e \\\\ \\hline \n", I3);
fprintf(file2btex, "$I_4$ & %e \\\\ \\hline \n", I4);
fprintf(file2btex, "$I_5$ & %e \\\\ \\hline \n", I5);
fprintf(file2btex, "$I_6$ & %e \\\\ \\hline \n", I6);
fprintf(file2btex, "$I_7$ & %e \\\\ \\hline \n", I7);
fprintf(file2btex, "$I_b$ & %e \\\\ \\hline \n", Ib);
fprintf(file2btex, "$I_d$ & %e \\\\ \\hline \n", Id);
fprintf(file2btex, "$I_s$ & %e \\\\ \\hline \n", Is);
fprintf(file2btex, "$I_x$ & %e \\\\ \\hline \n", Ix);
fclose (file2btex);

tabend2 = '"t2-2_END"'
tab2 = '"t2-2_TAB"'
file2sim = fopen ("ex2.cir", "w");
fprintf(file2sim, "ngspice T2b \n \n");
fprintf(file2sim, ".options savecurrents \n \n");
fprintf(file2sim, "Vs n1 GND %f \n", Vs);
fprintf(file2sim, "V0 GND n9 0 \n");
fprintf(file2sim, "R1 n2 n1 %fk \n", R1);
fprintf(file2sim, "R2 n3 n2 %fk \n", R2);
fprintf(file2sim, "R3 n2 n5 %fk \n", R3);
fprintf(file2sim, "R4 n5 GND %fk \n", R4);
fprintf(file2sim, "R5 n6 n5 %fk \n", R5);
fprintf(file2sim, "R6 n7 n9 %fk \n", R6);
fprintf(file2sim, "R7 n8 n7 %fk \n", R7);
fprintf(file2sim, "H1 n5 n8 V0 %fk \n", Kd);
fprintf(file2sim, "G1 n6 n3 n2 n5 %fm \n", Kb);
fprintf(file2sim, "Vx n6 n8 %f \n \n", Vx);
fprintf(file2sim, ".control \n \n");
fprintf(file2sim, "op \n");
fprintf(file2sim, "echo %s \n", tab2);
fprintf(file2sim, "print all \n");
fprintf(file2sim, "echo %s \n \n", tabend2);
fprintf(file2sim, "quit \n");
fprintf(file2sim, ".endc \n \n");
fprintf(file2sim, ".end");
fclose (file2sim);

%% 3 %%

A = Vx
t = 0:0.1:20;
V6n = A*exp(-t/Req*C);
fig1 = figure ();
plot(t, V6n)
xlabel ("t (ms)")
ylabel ("V6n (V)")
title ("Natural Solution V6n(t)")
print (fig1, "naturalana.eps", "-color");

transient = '"Transient Analysis"'
file3sim = fopen ("ex3.cir", "w");
fprintf(file3sim, "ngspice T2c \n \n");
fprintf(file3sim, ".options savecurrents \n \n");
fprintf(file3sim, "Vs n1 GND %f \n", Vs);
fprintf(file3sim, "V0 GND n9 0 \n");
fprintf(file3sim, "R1 n2 n1 %fk \n", R1);
fprintf(file3sim, "R2 n3 n2 %fk \n", R2);
fprintf(file3sim, "R3 n2 n5 %fk \n", R3);
fprintf(file3sim, "R4 n5 GND %fk \n", R4);
fprintf(file3sim, "R5 n6 n5 %fk \n", R5);
fprintf(file3sim, "R6 n7 n9 %fk \n", R6);
fprintf(file3sim, "R7 n8 n7 %fk \n", R7);
fprintf(file3sim, "H1 n5 n8 V0 %fk \n", Kd);
fprintf(file3sim, "G1 n6 n3 n2 n5 %fm \n", Kb);
fprintf(file3sim, "C1 n6 n8 %fu \n \n", C);
fprintf(file3sim, ".ic v(n6) = %f v(n8) = 0 \n \n", Vx);
fprintf(file3sim, ".control \n \n");
fprintf(file3sim, "op \n");
fprintf(file3sim, "echo %s \n", transient);
fprintf(file3sim, "tran 0.1m 20m uic \n");
fprintf(file3sim, "set hcopypscolor=0 \n set color0=white \n set color1=black \n set color2=red \n set color3=blue \n set color4=violet \n set color5=rgb:3/8/0 \n set color6=rgb:4/0/0 \n");
fprintf(file3sim, "hardcopy naturalsim.ps v(n6)  \n");
fprintf(file3sim, "echo naturalsim_FIG \n");
fprintf(file3sim, "quit \n");
fprintf(file3sim, ".endc \n \n");
fprintf(file3sim, ".end");
fclose (file3sim);

%% 4 %%

f=1000
Vs=1
w=2*pi*f
Zc=1/w*C*j
A3 = [1,0,0,0,0,0,0,0,0; ...
      1/R1,-(1/R1)-(1/R2)-(1/R3),1/R2,1/R3,0,0,0,0,0; ...
      0,1/R2,-1/R2,0,0,0,0,-Kb,0; ...
      0,1/R3,0,-1/R3-(1/R4)-(1/R5),1/R5+1/Zc,1/R7,-1/R7-1/Zc,0,0; ...
      0,0,0,1/R5,-1/R5-(1/Zc),0,1/Zc,Kb,0; ...
      0,0,0,0,0,-1/R6-(1/R7),1/R7,0,0; ...
      0,0,0,1,0,0,-1,0,1; ...
      0,-1,0,1,0,0,0,1,0;
      0,0,0,0,0,-1/R6,0,0,1/Kd]; ...

B3 = [Vs;0;0;0;0;0;0;0;0];

sol3 = A3\B3;
 
V1 = sol3(1);
V2 = sol3(2)
V3 = sol3(3)
V5 = sol3(4)
V6 = sol3(5)
V7 = sol3(6)
V8 = sol3(7)
Vb = sol3(8)
Vd = sol3(9)
Vs = V1

AV1 = abs(V1)
AV2 = abs(V2)
AV3 = abs(V3)
AV5 = abs(V5)
AV6 = abs(V6)
AV7 = abs(V7)
AV8 = abs(V8)
PhV1 = angle(V1) 
PhV2 = angle(V2) 
PhV3 = angle(V3) 
PhV5 = angle(V5) 
PhV6 = angle(V6) 
PhV7 = angle(V7) 
PhV8 = angle(V8) 

V6f = AV6*cos(t*2*pi - PhV6);

file4atex = fopen ("nodes4a.tex", "w");
fprintf(file4atex, "$V_1$ & %e \\\\ \\hline \n", AV1);
fprintf(file4atex, "$V_2$ & %e \\\\ \\hline \n", AV2);
fprintf(file4atex, "$V_3$ & %e \\\\ \\hline \n", AV3);
fprintf(file4atex, "$V_5$ & %e \\\\ \\hline \n", AV5);
fprintf(file4atex, "$V_6$ & %e \\\\ \\hline \n", AV6);
fprintf(file4atex, "$V_7$ & %e \\\\ \\hline \n", AV7);
fprintf(file4atex, "$V_8$ & %e \\\\ \\hline \n", AV8);
fclose (file4atex);

file4btex = fopen ("nodes4b.tex", "w");
fprintf(file4btex, "$Ph_1$ & %e \\\\ \\hline \n", PhV1);
fprintf(file4btex, "$Ph_2$ & %e \\\\ \\hline \n", PhV2);
fprintf(file4btex, "$Ph_3$ & %e \\\\ \\hline \n", PhV3);
fprintf(file4btex, "$Ph_5$ & %e \\\\ \\hline \n", PhV5);
fprintf(file4btex, "$Ph_6$ & %e \\\\ \\hline \n", PhV6);
fprintf(file4btex, "$Ph_7$ & %e \\\\ \\hline \n", PhV7);
fprintf(file4btex, "$Ph_8$ & %e \\\\ \\hline \n", PhV8);
fclose (file4btex);

file4sim = fopen ("ex4.cir", "w");
fprintf(file4sim, "ngspice T2d \n \n");
fprintf(file4sim, ".options savecurrents \n \n");
fprintf(file4sim, "Vs n1 GND 0  ac 1 sin(0 1 1k)\n");
fprintf(file4sim, "V0 GND n9 0 \n");
fprintf(file4sim, "R1 n2 n1 %fk \n", R1);
fprintf(file4sim, "R2 n3 n2 %fk \n", R2);
fprintf(file4sim, "R3 n2 n5 %fk \n", R3);
fprintf(file4sim, "R4 n5 GND %fk \n", R4);
fprintf(file4sim, "R5 n6 n5 %fk \n", R5);
fprintf(file4sim, "R6 n7 n9 %fk \n", R6);
fprintf(file4sim, "R7 n8 n7 %fk \n", R7);
fprintf(file4sim, "H1 n5 n8 V0 %fk \n", Kd);
fprintf(file4sim, "G1 n6 n3 n2 n5 %fm \n", Kb);
fprintf(file4sim, "C1 n6 n8 %fu \n \n", C);
fprintf(file4sim, ".ic v(n6) = %f v(n8) = 0 \n \n", Vx);
fprintf(file4sim, ".control \n \n");
fprintf(file4sim, "op \n");
fprintf(file4sim, "echo %s \n", transient);
fprintf(file4sim, "tran 0.1m 20m uic \n");
fprintf(file4sim, "set hcopypscolor=0 \n set color0=white \n set color1=black \n set color2=red \n set color3=blue \n set color4=violet \n set color5=rgb:3/8/0 \n set color6=rgb:4/0/0 \n");
fprintf(file4sim, "hardcopy totalsim.ps v(n6) v(n1) \n");
fprintf(file4sim, "echo totalsim_FIG \n");
fprintf(file4sim, "quit \n");
fprintf(file4sim, ".endc \n \n");
fprintf(file4sim, ".end");
fclose (file4sim);

%% 5 %%

pos = 0:0.1:20;
Vspos = sin(2*pi*pos);
V6pos = V6n + V6f;

neg = -5:0.1:0;
Vsneg = Vs_6+0*neg;
V6neg = V6e+0*neg;

ttot=[neg,pos];
Vstot = [Vsneg Vspos];
V6tot = [V6neg, V6pos];

fig3 = figure ();
plot(ttot, Vstot, 'r', ttot, V6tot, 'b')
xlabel ("t (ms)")
ylabel ("Voltage (V)")
print (fig3, "5ex.eps", "-color");
frequency = '"Frequency Analysis"'
file5sim = fopen ("ex5.cir", "w");
fprintf(file5sim, "ngspice T2e \n \n");
fprintf(file5sim, ".options savecurrents \n \n");
fprintf(file5sim, "Vs n1 GND 0  ac 1 sin(0 1 1k)\n");
fprintf(file5sim, "V0 GND n9 0 \n");
fprintf(file5sim, "R1 n2 n1 %fk \n", R1);
fprintf(file5sim, "R2 n3 n2 %fk \n", R2);
fprintf(file5sim, "R3 n2 n5 %fk \n", R3);
fprintf(file5sim, "R4 n5 GND %fk \n", R4);
fprintf(file5sim, "R5 n6 n5 %fk \n", R5);
fprintf(file5sim, "R6 n7 n9 %fk \n", R6);
fprintf(file5sim, "R7 n8 n7 %fk \n", R7);
fprintf(file5sim, "H1 n5 n8 V0 %fk \n", Kd);
fprintf(file5sim, "G1 n6 n3 n2 n5 %fm \n", Kb);
fprintf(file5sim, "C1 n6 n8 %fu \n \n", C);
fprintf(file5sim, ".ic v(n6) = %f v(n8) = 0 \n \n", Vx);
fprintf(file5sim, ".control \n \n");
fprintf(file5sim, "op \n");
fprintf(file5sim, "echo %s \n", frequency);
fprintf(file5sim, "ac dec 1000 0.1 1MEG \n");
fprintf(file5sim, "set hcopypscolor=0 \n set color0=white \n set color1=black \n set color2=red \n set color3=blue \n set color4=violet \n set color5=rgb:3/8/0 \n set color6=rgb:4/0/0 \n");
fprintf(file5sim, "hardcopy finalsima.ps vdb(n6) vdb(n1) xlimit 1 1000k \n");
fprintf(file5sim, "echo finalsima_FIG \n");
fprintf(file5sim, "hardcopy finalsimb.ps cph(n6) cph(n1) xlimit 1 1000k \n");
fprintf(file5sim, "echo finalsimb_FIG \n");
fprintf(file5sim, "let outd(V6) = 180/PI*cph(n6) \n let outd(Vs) = 180/PI*cph(n1) \n");
fprintf(file5sim, "hardcopy finalsimc.ps outd(V6) outd(Vs) xlimit 1 1000k \n");
fprintf(file5sim, "echo finalsimb_FIG \n");
fprintf(file5sim, "quit \n");
fprintf(file5sim, ".endc \n \n");
fprintf(file5sim, ".end");
fclose (file5sim);

%% 6 %%

frequencia = logspace(-6, 6, 200);

for k = 1:200
Z = 1/(j*2*pi*frequencia(k)*C)
A6 = [1,0,0,0,0,0,0,0,0; ...
      1/R1,-(1/R1)-(1/R2)-(1/R3),1/R2,1/R3,0,0,0,0,0; ...
      0,1/R2,-1/R2,0,0,0,0,-Kb,0; ...
      0,1/R3,0,-1/R3-(1/R4)-(1/R5),1/R5+1/Z,1/R7,-1/R7-1/Z,0,0; ...
      0,0,0,1/R5,-1/R5-(1/Z),0,1/Z,Kb,0; ...
      0,0,0,0,0,-1/R6-(1/R7),1/R7,0,0; ...
      0,0,0,1,0,0,-1,0,1; ...
      0,-1,0,1,0,0,0,1,0;
      0,0,0,0,0,-1/R6,0,0,1/Kd]; ...

B6 = [Vs;0;0;0;0;0;0;0;0];

sol6 = A6\B6;

V1 = sol6(1);
V2 = sol6(2);
V3 = sol6(3);
V5 = sol6(4);
V6fre(k) = sol6(5);
V7 = sol6(6);
V8 = sol6(7);
Vb = sol6(8);
Vd = sol6(9);
Vsfre(k) = sol6(1);
Vxfre(k) = - sol6(7) + sol6(5);
endfor

fig6a = figure ();
plot(log10(frequencia), 20*log10(abs(Vxfre)), 'g');
hold on
plot(log10(frequencia), 20*log10(abs(Vsfre)), 'b');
plot(log10(frequencia), 20*log10(abs(V6fre)), 'r');
xlabel ("log scale f (Hz)");
ylabel ("Magnitude (dB)");
title ("Frequency Response")
axis([-3 4 -30 10])
print (fig6a, "ex6mag.eps", "-color");

fig6b = figure ();
plot(log10(frequencia), (angle(Vxfre))*180/pi, 'g');
hold on
plot(log10(frequencia), (angle(Vsfre))*180/pi, 'b');
hold on
plot(log10(frequencia), (angle(V6fre))*180/pi, 'r');
xlabel ("log scale f (Hz)");
ylabel ("Phase (degrees)");
title ("Frequency Response")
axis([-6 6 -200 3])
print (fig6b, "ex6pha.eps", "-color");
