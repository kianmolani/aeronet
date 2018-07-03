function [data] = aeronet_read_SDA(filename)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%Open file for reading only
fileID = fopen(filename, 'r');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                READ HEADER                 %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('aeronet_read_SDA: reading file header...');

for i = 1:7
    header{i} = fgetl(fileID);
end

%line #1: aeronet and SDA version numbers
temp = header{1};
data.version = strrep(temp,';',',');

%line #2: location
data.location = header{2};

%line #3: level
temp = header{3};
data.level = erase(temp, "Version 3: SDA Retrieval ");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                 READ DATA                  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('aeronet_read_SDA: reading data from file...');

T = readtable(filename, 'HeaderLines', 6);
numberOfRows = height(T);

fclose(fileID);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%      CONVERT AND STORE SPECIFIED DATA      %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%memory allocation
data.dateAndTime(1:numberOfRows,1:2) = NaN;
data.aodTotalFineCoarse(1:numberOfRows,1:3) = NaN;

%process each column 
disp('aeronet_read_SDA: storing AOD total, fine, and coarse measurements...');
columnNumber = 1;
C = table2cell(T);

%date and time
data.dateAndTime = datenum([C{1:numberOfRows,columnNumber}]') + datenum([C{1:numberOfRows,columnNumber+1}]');

%aod total, fine, coarse
for i = 1:numberOfRows
    columnNumber = 5;
    for j = 1:3
        if C{i,columnNumber} < 0
            C{i,columnNumber} = NaN;
        end
        data.aodTotalFineCoarse(i,j) = C{i,columnNumber};
        columnNumber = columnNumber + 1;
    end
end

disp('aeronet_read_SDA: Process Complete!');

end

