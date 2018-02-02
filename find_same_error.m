% RIEMANN SUM TEST
clear variables; close all; clc

method = 'full';
type = 'dist';
name = {'Gaussian'};
itp = {'linear'};

for errortype = {'poisson'};

[setup] = IN(100,100000); setup.DIV=1;
setup.NAME = name{1};
[sg,~] = datasetGenSingle(setup,name{1},type);
nest = 1000;
nt_max = 50;

if strcmp(errortype,'normal')
    rnoise = linspace(0,0.01,1000);
else
    rnoise = linspace(1000000000,100000,1000);
end

wb = waitbar(0,['Aguarde[' name{1} ']']);

iest = 0;
for rn= rnoise
    iest = iest+1;
    MDiv = zeros(setup.DIV,15);
    for nt = 1:nt_max
        [xest,xgrid,yest,ygrid,ytruth] = Method_ADDNoise(setup,sg,nest,rn,name,itp,method,errortype);
        [AT(nt)]  = rsum(xgrid,abs(ygrid-ytruth),'mid',sg,name,1);
    end
    V.mean(iest) = mean(AT);
    V.std(iest) = std(AT)/sqrt(nt_max);
    waitbar(iest/length(rnoise))
end
close(wb)
V.noise = rnoise;
% errorbar(V.rnoise,V.mean,V.std)

save([pwd '\TRUTH\TEST_ERROR\VEC_ERROR2[' errortype{1} ']PDF[' name{1} ']METHOD[' method ']INTERP[' itp{1} ']'],'V')

end