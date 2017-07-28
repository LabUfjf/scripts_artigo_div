clear variables; close all; clc

% PARÂMETROS DE ENTRADA:
N.EVT = 1000000;
N.DIV = 10;    % número de divisões
N.PTS = 10000; % truth

% CRIAR BANCO DE DADOS: 
[sg,bg] = datasetGenSingle(N,'Bimodal');

% GERAR PDFS:
[sg,bg] = PDFGEN(sg,bg);
% PREPARAR COMPARAÇÕES
[sg.COMP]= COMPFIX(sg,'scan');
[bg.COMP]= COMPFIX(bg,'scan');

% CALCULAR DIVERGÊNCIAS
[sg,bg] = DIVFIX(sg,bg)
