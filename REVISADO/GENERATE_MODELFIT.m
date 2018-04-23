
clear variables; close all; clc;
load f
load rangeRoI

%=========================================================================
% PARÂMETROS INICIAIS - ADDSYM
%=========================================================================
errortype = 'poisson';
norm = 'fit';
nt = 100;
nRoI = 100;
nGrid= 1e5;
nEst = 1000;
%=========================================================================

[setup] = IN('Gaussian','sg',errortype,'dist','nearest',norm,1,nGrid,nEst,nRoI);   % Definir os Parâmetros Iniciais
setup.MINMAX.STD = 4;
[DATA] = datasetGenSingle(setup);
 [xest,xgrid,yest,ygrid,ytruth] = Method_ADDNoise(setup,DATA,setup.RANGE.NOISE(1));
wb = waitbar(0,'Aguarde...')
for i=1:length(setup.RANGE.NOISE)
    [mfit] = NoiseMix(xest,yest,setup.RANGE.NOISE(i))
    modelfit{i}=mfit;
    waitbar(i/length(setup.RANGE.NOISE))
end
close(wb)