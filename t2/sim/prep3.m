close all;
clear all;

this_file_path = fileparts(mfilename('fullpath'));
data_path = [this_file_path '/ngspice.log'];
fid = fopen (data_path);


lines = strsplit(fileread(data_path), '\n');

fclose(fid);

u=0;
vector = [];
for n = 1:length(lines) 
    if strfind(lines{n}, '_VAL')
        u=1;
    endif
    if (strfind(lines{n}, '_END') && u==1)
        u=0;
    endif
    if (strfind(lines{n}, '=') && u==1)
        val=strsplit(lines{n}, '=')(2);
        vector = [vector ; val];
    endif


endfor


V6 = str2double(vector(1));     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
V8 = str2double(vector(2));     %  values for SIM 3
                                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

printf(".param V6in = %.11f\n", V6);
printf(".param V8in = %.11f\n", V8);
