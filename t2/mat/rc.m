close all
clear all

pkg load symbolic;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                                     %
%  CAREFULL -> if testing separately make sure file data.txt exists in main directory %
%                                                                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#------------------ Getting values from data.txt------------------------ WORKS

this_file_path = fileparts(mfilename('fullpath'));
data_path = [this_file_path '/../data.txt'];
fid = fopen (data_path);


lines = strsplit(fileread(data_path), '\n');

fclose(fid);


vector = [];
for n = 1:length(lines) 
    if strfind(lines{n}, '=')
        val=strsplit(lines{n}, '=')(2);
        vector = [vector ; val];
    endif
end 

vector;

R1 = str2double(vector(1)) 
R2 = str2double(vector(2)) 
R3 = str2double(vector(3)) 
R4 = str2double(vector(4))      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
R5 = str2double(vector(5))      %  values from datagen
R6 = str2double(vector(6))      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
R7 = str2double(vector(7)) 
Vs = str2double(vector(8)) 
C = str2double(vector(9)) 
Kb = str2double(vector(10)) 
Kd = str2double(vector(11)) 

R1 = R1*1000; 
R2 = R2*1000; 
R3 = R3*1000; 
R4 = R4*1000;      %%%%%%%%%%%%%%%%%%%
R5 = R5*1000;      % Getting right units for resistances
R6 = R6*1000;      %%%%%%%%%%%%%%%%%%%
R7 = R7*1000; 



#-------------------------- Writting in file to include in ngspice FIRST simulation-----------------------------------


% ngspice_path = [this_file_path '../sim/ngdata.txt'];
fid = fopen ('../sim/ngspice_data_1.txt', "w+");

fprintf(fid, "R1 1 2 %.11f \n", R1)
fprintf(fid, "R2 2 3 %.11f \n", R2)
fprintf(fid, "R3 2 5 %.11f \n", R3)    %---------------
fprintf(fid, "R4 0 5 %.11f \n", R4)    %  Resistências
fprintf(fid, "R5 5 6 %.11f \n", R5)    %---------------
fprintf(fid, "R6 na 7 %.11f \n", R6)
fprintf(fid, "R7 7 8 %.11f \n", R7)

fprintf(fid, "Vs 1 0 %.11f \n", Vs)         % Voltage source     
fprintf(fid, "Va 0 na 0V \n")           % V auxiliar
fprintf(fid, "Gb 6 3 2 5 %.11f \n", Kb)    % dependent current dource
fprintf(fid, "Hd 5 8 Va %.11f \n", Kd)      % dependent voltage source

fprintf(fid, "C 6 8 %.11fuF \n", C)      % Capacitor


fclose (fid);

#------------------------- Theoretical analysis number 1 -----------------------------------------------------------



C1 = 1/R1;
C2 = 1/R2;
C3 = 1/R3;
C4 = 1/R4;
C5 = 1/R5;
C6 = 1/R6;
C7 = 1/R7;

A = [1,         0,   0,         0,      0,       0,   0;
     C1, -C1-C2-C3,  C2,        C3,      0,       0,   0;
      0,     C2+Kb, -C2,       -Kb,      0,       0,   0;
      0,       -Kb,   0,     C5+Kb,    -C5,       0,   0;
      0,         0,   0,         0,      0,  -C6-C7,  C7;
      0,         0,   0,         1,      0,   Kd*C6,  -1;
      0,        C3,   0, -C3-C4-C5,     C5,      C7,  -C7];

b = [Vs; 0; 0; 0; 0; 0; 0];

x = A\b

V1 = x(1)
V2 = x(2)
V3 = x(3)
V5 = x(4)
V6 = x(5)
V7 = x(6)
V8 = x(7)

%_____________table printing

filename = "ex1_octave.tex";
fid = fopen (filename, "w+");

fprintf(fid, "\\begin{table}[h] \n \\centering \n \\begin{tabular}{ c c } \n")
fprintf(fid, "\\hline\n")
fprintf(fid, "V(1) & %.11f \\\\ \n ", V1)
fprintf(fid, "\\hline\n")
fprintf(fid, "V(2) & %.11f \\\\ \n ", V2)
fprintf(fid, "\\hline\n")
fprintf(fid, "V(3) & %.11f \\\\ \n ", V3)
fprintf(fid, "\\hline\n")
fprintf(fid, "V(5) & %.11f \\\\ \n ", V5)
fprintf(fid, "\\hline\n")
fprintf(fid, "V(6) & %.11f \\\\ \n ", V6)
fprintf(fid, "\\hline\n")
fprintf(fid, "V(7) & %.11f \\\\ \n ", V7)
fprintf(fid, "\\hline\n")
fprintf(fid, "V(8) & %.11f \\\\ \n ", V8)
fprintf(fid, "\\hline\n")
fprintf(fid, "  \\end{tabular} \n \\caption{Results of Nodal Analysis using Octave} \n \\label{tab:mesh_results} \n \\end{table} \n ")


fclose (fid);


#-------------------------- Writting in file to include in ngspice SECOND simulation-----------------------------------


% ngspice_path = [this_file_path '../sim/ngdata.txt'];
fid = fopen ('../sim/ngspice_data_2.txt', "w+");

Vx= V6-V8

fprintf(fid, ".param R1 = %.11f\n", R1)
fprintf(fid, ".param R2 = %.11f\n", R2)
fprintf(fid, ".param R3 = %.11f\n", R3)
fprintf(fid, ".param R4 = %.11f\n", R4)
fprintf(fid, ".param R5 = %.11f\n", R5)
fprintf(fid, ".param R6 = %.11f\n", R6)
fprintf(fid, ".param R7 = %.11f\n\n", R7)
fprintf(fid, ".param Vs = 0V\n")
fprintf(fid, ".param Vx = %.6fV\n\n", Vx)
fprintf(fid, ".param Kb = %.11f\n", Kb)
fprintf(fid, ".param Kd = %.11f\n", Kd)

fclose (fid);


#-------------------------- Writting in file to include in ngspice THIRD simulation-----------------------------------


% ngspice_path = [this_file_path '../sim/ngdata.txt'];
fid = fopen ('../sim/ngspice_data_3.txt', "w+");

fprintf(fid, ".param R1 = %.11f\n", R1)
fprintf(fid, ".param R2 = %.11f\n", R2)
fprintf(fid, ".param R3 = %.11f\n", R3)
fprintf(fid, ".param R4 = %.11f\n", R4)
fprintf(fid, ".param R5 = %.11f\n", R5)
fprintf(fid, ".param R6 = %.11f\n", R6)
fprintf(fid, ".param R7 = %.11f\n\n", R7)
fprintf(fid, ".param Vs = 0V\n")
fprintf(fid, ".param C1 = %.11fuF\n\n", C)
fprintf(fid, ".param Kb = %.11f\n", Kb)
fprintf(fid, ".param Kd = %.11f\n", Kd)

fclose (fid);

%-------------------------------------------------------------------------------------
