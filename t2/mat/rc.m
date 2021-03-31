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
R5 = str2double(vector(5))      %    UNITS NEED TO BE CHANGED
R6 = str2double(vector(6))      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
R7 = str2double(vector(7)) 
Vs = str2double(vector(8)) 
C = str2double(vector(9)) 
Kb = str2double(vector(10)) 
Kd = str2double(vector(11)) 

fclose(fid);



#-------------------------- Writting in file to include in ngspice-----------------------------------


% ngspice_path = [this_file_path '../sim/ngdata.txt'];
fid = fopen ('../sim/ngspice_data.txt', "w+");

fprintf(fid, "R1 1 2 %f \n", R1)
fprintf(fid, "R2 1 2 %f \n", R2)
fprintf(fid, "R3 1 2 %f \n", R3)
fprintf(fid, "R4 1 2 %f \n", R4)    %%%%%%%%%%% INCERT DATA AS IF IN NGSPICE
fprintf(fid, "R5 1 2 %f \n", R5)      
fprintf(fid, "R6 1 2 %f \n", R6)
fprintf(fid, "R7 1 2 %f \n", R7)


fclose (fid);

#------------------nodal analysis------------------------



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

