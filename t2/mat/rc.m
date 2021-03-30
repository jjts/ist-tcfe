close all
clear all

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

vector; #=cell2mat(vector) #-------remove comma to test output 

R1 = str2double(vector(1)) 
R2 = str2double(vector(2)) 
R3 = str2double(vector(3)) 
R4 = str2double(vector(4)) 
R5 = str2double(vector(5)) 
R6 = str2double(vector(6)) 
R7 = str2double(vector(7)) 
Vs = str2double(vector(8)) 
C = str2double(vector(9)) 
Kb = str2double(vector(10)) 
Kd = str2double(vector(11)) 

fclose(fid);

#-------------------------------- ---------------------------------------



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

