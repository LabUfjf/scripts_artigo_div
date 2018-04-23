clear variables;  clc;
close all;
load f
load rangeRoI
load modelfit
% DEBUG FUNÇÔES
%=========================================================================
% PARÂMETROS INICIAIS - ADDSYM
%=========================================================================
norm = 'fit';
nt = 1;
nRoI = 100;
nGrid= 1e4;
nEst = 1000;
inter = 'nearest';
    %=========================================================================
for errortype = {'normal','poisson','noisemix'};   
    [setup] = IN('Gaussian','sg',errortype{1},'dist',inter,norm,1,nGrid,nEst,nRoI);   % Definir os Parâmetros Iniciais
    setup.MINMAX.STD = 4;
    [DATA] = datasetGenSingle(setup);
    for i = 1:3
        DEBUG_function(setup,DATA,i)
    end
    
end
