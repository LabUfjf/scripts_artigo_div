clear variables;  clc;
% close all;
load f
load rangeRoI
load modelfit
% DEBUG FUNÇÔES
%=========================================================================
% PARÂMETROS INICIAIS - ADDSYM
%=========================================================================
norm = 'fit';
nt = 1;
nRoI = 1;
nGrid= 1e5;
nEst = 1000;
inter = 'nearest';
errortype = 'normal';
%=========================================================================
VCTEST = 10:10:1000;
for nt = 1:100
[setup] = IN('Gaussian','sg',errortype,'dist',inter,norm,1,nGrid,nEst,nRoI);   % Definir os Parâmetros Iniciais
[DATA] = datasetGenSingle(setup);
iest = 0;
wb = waitbar(0,'Aguarde...')
for NEST=VCTEST
    iest = iest+1;
    setup.EST = NEST;
    [M] = MD(setup,DATA);
    DIVT{iest} = M;
    D(iest,nt)= DIVT{iest}(5);
    waitbar(iest/length(VCTEST))
end
close(wb)
end

hold on
plot(VCTEST,mean(D'),'.:k')