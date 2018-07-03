function [] = aeronet_plot_points(dateAndTime, data, yAxisLabel, titleName)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

set(gcf,'position',[300,300,800,300]); %set position property of current figure (in pixels)
plotbrowser('on'); %allows user to hide/display plots of subsets of data

if yAxisLabel == "Aerosol Optical Depth"
    subplot('position',[0.08 0.14 0.73 0.76]);
    hold on;
    plot(dateAndTime,data(:,1),'-','Color',[0,0,0]);
    plot(dateAndTime,data(:,2),'-','Color',[1,0,0]);
    plot(dateAndTime,data(:,3),'-','Color',[0.49803921568,0.24705882352,0]);
    plot(dateAndTime,data(:,6),'-','Color',[0.49803921568,0.54901960784,0]);
    plot(dateAndTime,data(:,15),'-','Color',[0,0.49803921568,0]);
    plot(dateAndTime,data(:,18),'-','Color',[0.2431372549,0.34117647058,0.54901960784]);
    plot(dateAndTime,data(:,21),'-','Color',[0,0,1]);
    plot(dateAndTime,data(:,22),'-','Color',[0,0,0.74901960784]);
    l = legend('AOD_1640','AOD_1020','AOD_870','AOD_675','AOD_500','AOD_440','AOD_380','AOD_340');
end

if yAxisLabel == "Angstrom Exponent"
    sub=subplot('position',[0.08 0.14 0.73 0.76]);
    hold on;
    plot(dateAndTime,data(:,1),'-','Color',[0,0,0]);
    plot(dateAndTime,data(:,2),'-','Color',[1,0,0]);
    plot(dateAndTime,data(:,3),'-','Color',[0.49803921568,0.24705882352,0]);
    plot(dateAndTime,data(:,4),'-','Color',[0.49803921568,0.54901960784,0]);
    plot(dateAndTime,data(:,5),'-','Color',[0,0.49803921568,0]);
    l = legend('Angstrom_440-870','Angstrom_380-500','Angstrom_440-675','Angstrom_500-870','Angstrom_340-440');
end

if yAxisLabel == "SDA Aerosol Optical Depth"
    sub=subplot('position',[0.08 0.14 0.73 0.76]);
    hold on;
    plot(dateAndTime,data(:,1),'-','Color','k');
    plot(dateAndTime,data(:,2),'-','Color','r');
    plot(dateAndTime,data(:,3),'-','Color','b');
    l = legend('Total_500nm','Fine_500nm','Coarse_500nm');
end

set(l, 'Interpreter', 'none');

title(titleName,'interpreter','none');  %does not mistake underscores as subscripts

yval = get(gca,'ylim'); %get minimum and maximum of y-values (two elements)
minval = yval(1);
maxval = yval(2);
ylim([minval maxval]); %sets y-axis limits to minimum and maximum y-values
ylabel(yAxisLabel,'fontsize',12);
xlabel('Year/Month','fontsize',12);

%round scale to full years 
aero.minDateAndTime = min(dateAndTime);  %convert to serial date number
aero.maxDateAndTime = max(dateAndTime);
xlim([aero.minDateAndTime, aero.maxDateAndTime]);
datetick('x','yy/mm','keeplimits'); %date formatting

grid on; 

%histogram
sub=subplot('position',[0.83 0.14 0.15 0.76]);
set(histogram(data, 100,'Orientation','horizontal'), 'facecolor',[0.7 0.7 0.7]);
set(gca, 'XScale','log');
ylim([minval maxval]); 
xlabel('freq','fontsize',12);
tmp=get(gca,'xtick');

grid on;

end
