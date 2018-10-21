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
for name = {'Gaussian','Bimodal','Trimodal','Rayleigh','Logn','Gamma','Laplace'};
    for method = {'HIST','ASH'}
        for nEVT = [100 500 1000 2000 5000];
            [bin,C,nbin] = GENTRUTH(name{1},round(nEVT),100,method{1});
        end
    end
end