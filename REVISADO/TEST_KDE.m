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
cl = ['yrbgkmc'];
% for name = {'Uniform','Gaussian','Bimodal','Trimodal','Rayleigh','Logn','Gamma'};
name = {'Trimodal'};
nEVT = 50000;
nEST = 10;
nROI = 1;
nGRID = 10^5;
binmax = 1000;
ntmax = 30;
div=2^1;          % Number of matrix divisions
[setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
[DATA] = datasetGenSingle(setup);
f=1;
% [x2v,p2v]=KDE_opt(DATA.sg.evt,2000,f,'variable');                   % Our Implementation
[x1f,pdf1f]=fastKDE(DATA.sg.evt,2000,f,div,'fix');      % Our Implementation Fast

plot(x1f,pdf1f)

% hist(DATA.sg.evt,100)

h