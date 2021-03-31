close all
clear all

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
R5 = str2double(vector(5))      %    UNITS ARE SAME AS THE ONES FROM DATAGEN.PY
R6 = str2double(vector(6))      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
R7 = str2double(vector(7)) 
Vs = str2double(vector(8)) 
C = str2double(vector(9)) 
Kb = str2double(vector(10)) 
Kd = str2double(vector(11)) 

fclose(fid);



#-------------------------- Writting in file to include in ngspice first simulation-----------------------------------


% ngspice_path = [this_file_path '../sim/ngdata.txt'];
fid = fopen ('../sim/ngspice_data_1.txt', "w+");

fprintf(fid, "R1 1 2 %fk \n", R1)
fprintf(fid, "R2 2 3 %fk \n", R2)
fprintf(fid, "R3 2 5 %fk \n", R3)    %---------------
fprintf(fid, "R4 0 5 %fk \n", R4)    %  Resistências
fprintf(fid, "R5 5 6 %fk \n", R5)    %---------------
fprintf(fid, "R6 na 7 %fk \n", R6)
fprintf(fid, "R7 7 8 %fk \n", R7)

fprintf(fid, "Vs 1 0 %f \n", Vs)         % Voltage source     
fprintf(fid, "Va 0 na 0V \n")           % V auxiliar
fprintf(fid, "Gb 6 3 2 5 %f \n", Kb)    % dependent current dource
fprintf(fid, "Hd 5 8 Va %f \n", Kd)      % dependent voltage source

fprintf(fid, "C 6 8 %fuF \n", C)      % Capacitor


fclose (fid);

#------------------nodal analysis------------------------

%
%
%

%_____________table printing

% filename = "nodal_octave.tex";
% fid = fopen (filename, "w+");

% fprintf(fid, "\\begin{table}[h] \n \\centering \n \\begin{tabular}{ c c } \n")
% fprintf(fid, "\\hline\n")
% fprintf(fid, "V2 & %f \\\\ \n ", x(1))
% fprintf(fid, "\\hline\n")
% fprintf(fid, "V3 & %f \\\\ \n ", x(2))
% fprintf(fid, "\\hline\n")
% fprintf(fid, "V5 & %f \\\\ \n ", x(3))
% fprintf(fid, "\\hline\n")
% fprintf(fid, "V7 & %f \\\\ \n ", x(4))
% fprintf(fid, "\\hline\n")
% fprintf(fid, "  \\end{tabular} \n \\caption{Results of Nodal Analysis using Octave} \n \\label{tab:mesh_results} \n \\end{table} \n ")


% fclose (fid);

