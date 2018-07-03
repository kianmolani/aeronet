function [data] = aeronet_read_AOD(filename)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%Open file for reading only
fileID = fopen(filename, 'r');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                READ HEADER                 %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('aeronet_read_AOD: reading file header...');

for i = 1:7
    header{i} = fgetl(fileID);
end

%line #1: version number
temp = header{1};
data.version = erase(temp, ";");

%line #2: location
data.location = header{2};

%line #3: level
temp = header{3};
data.level = erase(temp, "Version 3: AOD ");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                 READ DATA                  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('aeronet_read_AOD: reading data from file...');

T = readtable(filename, 'HeaderLines', 6);
numberOfRows = height(T);

fclose(fileID);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%      CONVERT AND STORE SPECIFIED DATA      %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%memory allocation
data.dateAndTime(1:numberOfRows,1:2) = NaN;
data.aod(1:numberOfRows,1:29) = NaN;
data.angstrom(1:numberOfRows,1:6) = NaN;

%process each column 
disp('aeronet_read_AOD: storing AOD and angstrom exponent measurements...');
columnNumber = 1;
C = table2cell(T);

%date and time
data.dateAndTime = datenum([C{1:numberOfRows,columnNumber}]') + datenum([C{1:numberOfRows,columnNumber+1}]');

%aod values
for i = 1:numberOfRows
    columnNumber = 5;
    for j = 1:22
        if C{i,columnNumber} < 0
            C{i,columnNumber} = NaN;
        end
        data.aod(i,j) = C{i,columnNumber};
        columnNumber = columnNumber + 1;
    end
end

for i = 1:numberOfRows
    columnNumber = 28;
    for j = 23:29
        if C{i,columnNumber} < 0
            C{i,columnNumber} = NaN;
        end
        data.aod(i,j) = C{i,columnNumber};
        columnNumber = columnNumber + 1;
    end
end

%angstrom exponent
for i = 1:numberOfRows
    columnNumber = 65;
    for j = 1:5
        if C{i,columnNumber} < 0
            C{i,columnNumber} = NaN;
        end
        data.angstrom(i,j) = C{i,columnNumber};
        columnNumber = columnNumber + 1;
    end
end

disp('aeronet_read_AOD: Process Complete!');

end
