function [h] = h_CV(DATA,ho,h)
type = 'Gaussian';
[~,~,DATA]= format_data(DATA);
DATA = DATA';
r = 0;
hv=linspace(0.15*ho,2*ho,50);

wb=waitbar(0,'Aguarde[CV]...');
for i = 1:length(hv);
    Cost_MLCV(i)=MLCVfast(DATA,hv(i));
    Cost_UCV(i)=UCVfast(DATA,hv(i),r,type);
    Cost_BCV1(i)=BCV1fast(DATA,hv(i),r,type);
    Cost_BCV2(i)=BCV2fast(DATA,hv(i),r,type);
    Cost_CCV(i)=CCVfast(DATA,hv(i),r,type);
    Cost_MCV(i)=MCVfast(DATA,hv(i),r,type);
    Cost_TCV(i)=TCVfast(DATA,hv(i),r,type);
    Cost_LSCV(i)=LSCVfast(DATA,hv(i));
    waitbar(i/length(hv))
end
close(wb)

h.CV.MLCV=hv(find(Cost_MLCV==max(Cost_MLCV)));
h.CV.UCV=hv(find(Cost_UCV==min(Cost_UCV)));
h.CV.BCV1=hv(find(Cost_BCV1==min(Cost_BCV1)));
h.CV.BCV2=hv(find(Cost_BCV2==min(Cost_BCV2)));
h.CV.CCV=hv(find(Cost_CCV==min(Cost_CCV)));
h.CV.MCV=hv(find(Cost_MCV==min(Cost_MCV)));
h.CV.TCV=hv(find(Cost_TCV==min(Cost_TCV)));
h.CV.LSCV=hv(find(Cost_LSCV==min(Cost_LSCV)));

h.CV.Cost(1,:) =  Cost_MLCV;
h.CV.Cost(2,:) =  Cost_UCV;
h.CV.Cost(3,:) =  Cost_BCV1;
h.CV.Cost(4,:) =  Cost_BCV2;
h.CV.Cost(5,:) =  Cost_CCV;
h.CV.Cost(6,:) =  Cost_MCV;
h.CV.Cost(7,:) =  Cost_TCV;
h.CV.Cost(8,:) =  Cost_LSCV;