function [h] = h_CV_MLCV(DATA,ho,h)
type = 'Gaussian';
[~,~,DATA]= format_data(DATA);
DATA = DATA';
r = 0;
hv=linspace(0.05*ho,2.5*ho,50);

wb=waitbar(0,'Aguarde[CV]...');
for i = 1:length(hv);
    Cost_MLCV(i)=MLCVfast(DATA,hv(i));
    waitbar(i/length(hv))
end
close(wb)

h.CV.MLCV=hv(find(Cost_MLCV==max(Cost_MLCV)));
h.CV.Cost(1,:) =  Cost_MLCV;
