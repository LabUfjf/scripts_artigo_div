% TEST BIAS- VARIANCE
clear variables;  clc; close all;
%=========================================================================
% DESCRI��O:
% Esse teste tem como intuito perceber a resposta das diverg�ncias em
% realidades controladas.
%=========================================================================
% PAR�METROS INICIAIS - ADDSYM
%=========================================================================
norm = 'full';
nt = 10;
nRoI = 50;
nGrid= 1e5;
nEst = 1000;
inter = 'linear';
errortype = 'poisson';
%=========================================================================

for j=1:100
    for i = 1:nt
        [setup] = IN('Gaussian','sg',errortype,'dist',inter,norm,1,nGrid,nEst,1);   % Definir os Par�metros Iniciais
        [DATA] = datasetGenSingle(setup);
        [X.EST,X.GRID,Y.EST,Y.GRID,Y.TRUTH] = Method_ADDNoise(setup,DATA,setup.RANGE.NOISE(j));
        [P,Q,dx] = fixPQ(X.GRID,Y.GRID,Y.TRUTH);
        [K1(i,j)] = Kumar(P,Q,dx,'abs');
        
        
        [setup] = IN('Gaussian','sg',errortype,'dist',inter,norm,1,nGrid,nEst,nRoI);   % Definir os Par�metros Iniciais
        [DATA] = datasetGenSingle(setup);
        [X.EST,X.GRID,Y.EST,Y.GRID,Y.TRUTH] = Method_ADDNoise(setup,DATA,setup.RANGE.NOISE(j));
        [P,Q,dx] = fixPQ(X.GRID,Y.GRID,Y.TRUTH);
        [KVn] = Kumar(P,Q,dx,'abs');
        Kn(i,j)=sum(KVn);
    end
end
plot(K1,Kn,'.')