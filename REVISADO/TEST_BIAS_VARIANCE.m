% TEST BIAS- VARIANCE
clear variables;  clc; close all;
%=========================================================================
% DESCRIÇÃO:
% Esse teste tem como intuito perceber a resposta das divergências em
% realidades controladas.
%=========================================================================
% PARÂMETROS INICIAIS - ADDSYM
%=========================================================================
norm = 'fit';
nt = 10;
nRoI = 50;
nGrid= 1e5;
nEst = 1000;
inter = 'linear';
errortype = 'poisson';
mod = 'abs';
%=========================================================================
wb = waitbar(0,'Aguarde...');
for j=1:100
    for i = 1:nt
        [setup] = IN('Gaussian','sg',errortype,'dist',inter,norm,1,nGrid,nEst,1);   % Definir os Parâmetros Iniciais
        [DATA] = datasetGenSingle(setup);
        [X.EST,X.GRID,Y.EST,Y.GRID,Y.TRUTH] = Method_ADDNoise(setup,DATA,setup.RANGE.NOISE(j));
        [P,Q,dx] = fixPQ(X.GRID,Y.GRID,Y.TRUTH);
         M = MATRIXMD(P,Q,dx,mod);
%         [K1(i,j)] = Kumar(P,Q,dx,'abs');
        
        
        [setup] = IN('Gaussian','sg',errortype,'dist',inter,norm,1,nGrid,nEst,nRoI);   % Definir os Parâmetros Iniciais
        [DATA] = datasetGenSingle(setup);
        [X.EST,X.GRID,Y.EST,Y.GRID,Y.TRUTH] = Method_ADDNoise(setup,DATA,setup.RANGE.NOISE(j));
        [P,Q,dx] = fixPQ(X.GRID,Y.GRID,Y.TRUTH);
        [KVn] = Kumar(P,Q,dx,'abs');
        Kn(i,j)=sum(KVn);
    end
    waitbar(j/100)
end
close(wb)

plot(K1,Kn,'.')