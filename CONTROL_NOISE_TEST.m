clear variables; close all; clc

nest = 1000;
vROI = [200];
name  = {'Logn'};
itp = {'linear'};
type = {'dist'};
errortype = {'poisson'};

[setup] = IN(100,500000);
setup.NAME = name{1};
setup.DIV = vROI;
[sg,~] = datasetGenSingle(setup,name{1},type);
[rnoise,xlab] = SETrange(errortype);
rn = rnoise(1);
[xest,xgrid,yest,~,~] = Method_ADDNoise(setup,sg,nest,rn,name,itp,'fit',errortype);

[KT,SK,PB] = FIND_KURT_SKEW(sg,xgrid,xest,yest,rn,errortype,name);


