% TEST DISTRIBUIÕES
clear variables;  clc; close all;
%=========================================================================
% TESTANDO TODAS AS DISTRIBUIÇÕES QUE SERÃO UTILIZADAS NA TESE
%=========================================================================
norm = 'fit';
inter = 'linear';
errortype = 'none';
mod = 'abs';
j=0;
ntmax= 3000;
for name = {'Gaussian','Bimodal','Trimodal','Rayleigh','Logn','Gamma','Laplace'};
    for method = {'HIST','ASH'}
        for nEVT = linspace(100,100000,20);
            nROI = 1;
            nGRID = 10^5;
            [bin,C,nbin] = GENTRUTH(name{1},round(nEVT),50,'ASH');
        end
    end
end