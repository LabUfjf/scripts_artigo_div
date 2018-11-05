function [] = PLOTBOX(DATA,vEVT,xtag,ytag,legpos)
% Create a cell array with the data for each group
% vEVT = [100,500,1000,2000,5000];
% colormap('prism')
% cmap = colormap;

cmap = [128,128,128;
    211,211,211;
    135,206,250;
    191, 255, 193;
    255,0,0;
    255,165,0;
    255,255,0;
    255,255,255]/255;
aboxplot(DATA,'labels',vEVT,'Colormap',cmap(1:length(DATA),:),'colorrev',false,'OutlierMarker','+')
set(gca,'Fontsize',14);
xlabel(xtag); % Set the X-axis label
ylabel(ytag); % Set the X-axis label
L = [{'FD'};{'Scott'};{'Sturges'};{'Doane'};{'Shimazaki'};{'Rudemo'};{'LHM'};{'Truth'}];
legend([L(1:length(DATA))],'Location',legpos);

end