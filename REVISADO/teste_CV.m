close; clear variables; clc;
load bimodal
DATA = bimodal(:);
DATA = DATA(~isnan(DATA));
type = 'Gaussian';
METHOD = 'BC1';
% DATA = randn(1000,1);
r = 0;
[nd,n,DATA]= format_data(DATA);
[h] = h_plugin(DATA); 
[h] = h_CV(DATA,h.PI.SC,h);


hsilver =((4/(nd+2))^(1/(nd+4)))*std(DATA)*n^(-1/(nd+4));
hos = ((243 *(2*r+1)*Rg(kernel_fun_der(type,r)))/(35* A2_kM(type)^2))^(1/(2*r+5)) * std(DATA) * n^(-1/(2*r+5));
hv=linspace(0.15*hos,2*hos,50);
hSJ = SJbandwidth(DATA);
% [H, P, h] = bootmode (DATA, 2, 10);


wb=waitbar(0,'Aguarde...');
for i = 1:length(hv);
    %     CV(i)=MLCV(DATA,hv(i));
    %     CV(i)=UCV(DATA,hv(i),r,type);
    %     CV(i)=BCV1(DATA,hv(i),r,type);
    %     CV(i)=BCV2(DATA,hv(i),r,type);
    %     CV(i)=CCV(DATA,hv(i),r,type);
    %     CV(i)=MCV(DATA,hv(i),r,type);
    %     CV(i)=TCV(DATA,hv(i),r,type); % Problem
    %     CV(i)=LSCV(DATA,hv(i)); % Problem
    waitbar(i/length(hv))
end
close(wb)
subplot(1,2,2);plot(hv,CV);axis tight; hold on

