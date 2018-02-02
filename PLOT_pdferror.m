

% RIEMANN SUM TEST
clear variables; close all; clc

method = 'full';
type = 'dist';
name = {'Gaussian'};
errortype = 'poisson';
itp = {'linear'};
% for name = {'Gaussian','Bimodal','Rayleigh','Logn','Gamma'};

[setup] = IN(100,100000); setup.DIV=1;
setup.NAME = name{1};
[sg,~] = datasetGenSingle(setup,name{1},type);
nest = 1000;

[rnoise] = SETrange(errortype)


[xest,xgrid,yest,ygrid,ytruth] = Method_ADDNoise(setup,sg,nest,rnoise(end),name,itp,method,errortype);

% plot(xest,yest)

plot(xgrid,ygrid,':r'); hold on
plot(xgrid,ytruth,'-k'); axis tight

xlabel('Amplitude')
ylabel('Probability Density')

legend('Truth+Error','Truth')