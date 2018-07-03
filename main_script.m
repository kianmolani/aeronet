tic

clear all
close all

%read AOD data
fname='20170101_20171231_Fort_McMurray_AOD.txt';
data=aeronet_read_AOD(fname);

%plot angstrom exponent measurements
figure(1); 
clf;
aeronet_plot_data(data.dateAndTime, data.angstrom, 'Angstrom Exponent', strcat(data.version,{'; '}, data.location,{'; '},{'Angstrom '}, data.level, {'; Data from '}, extractBefore(fname,5)))

%plot aod measurements
figure(2); 
clf;
aeronet_plot_data(data.dateAndTime, data.aod, 'Aerosol Optical Depth', strcat(data.version,{'; '}, data.location,{'; '},{'AOD '}, data.level, {'; Data from '}, extractBefore(fname,5)))


%read SDA data
fname='20170101_20171231_Fort_McMurray_SDA.txt';
data=aeronet_read_SDA(fname);

%plot aod total, fine, and coarse measurements
figure(3); 
clf;
aeronet_plot_data(data.dateAndTime, data.aodTotalFineCoarse, 'SDA Aerosol Optical Depth', strcat(data.version,{'; '}, data.location,{'; '},{'SDA AOD '}, data.level, {'; Data from '}, extractBefore(fname,5)))

toc
