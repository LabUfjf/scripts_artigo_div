function [M] = MD(setup,DATA)
%==========================================================================
% Objetivo: * Adicionar Diferentes Tipos de Ruído por RoI 
%           * Fazer Normalização adequada
%           * Calcular as Medidas de Distância por RoI
%==========================================================================
setup.TYPE.NORM = 'full';
[X.EST,X.GRID,Y.EST,Y.GRID,Y.TRUTH] = Method_ADDNoise(setup,DATA,setup.RANGE.NOISE(1));
[RN,L1,IP] = MDFULL(X.GRID,Y.GRID,Y.TRUTH);


setup.TYPE.NORM = 'fit';
[X.EST,X.GRID,Y.EST,Y.GRID,Y.TRUTH] = Method_ADDNoise(setup,DATA,setup.RANGE.NOISE(1));
[M] = MDFIT(RN,L1,IP,X.GRID,Y.GRID,Y.TRUTH);

% MD_DEBUG(X.GRID,Y.GRID,Y.TRUTH,'Taneja','do');
% pause
end