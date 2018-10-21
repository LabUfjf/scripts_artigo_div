function [] = PLOTBOXKDE_VAR(DATA,vEVT,xtag,ytag)
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
    0, 255, 0;
    61, 149, 6;
    0, 48, 0;
    0, 0, 255;
    0, 0, 86;
    204, 0, 153;
    255, 128, 223;
    255,255,255]/255;
aboxplot(DATA,'labels',vEVT,'Colormap',cmap(1:length(DATA),:),'colorrev',false,'OutlierMarker','+')
xlabel(xtag); % Set the X-axis label
ylabel(ytag); % Set the X-axis label
L = [{'[PI]SV'};{'[CV]MLCV'};{'SS'};{'[SV]BE'};{'[SV]SSE'};{'[MLCV]BE'};{'[MLCV]SSE'}];
legend([L(1:length(DATA))],'Location','SouthWest');

end

