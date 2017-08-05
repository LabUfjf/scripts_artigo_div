clear variables; close all; clc

% PARÂMETROS DE ENTRADA:
N=100000;
[setup] = IN(N);

% CRIAR BANCO DE DADOS: 
[sg,bg] = datasetGenSingle(setup,'Gauss');

% GERAR PDFS:
[sg,bg] = PDFGEN(setup,sg,bg,hist);

% PREPARAR COMPARAÇÕES
[sg.COMP]= COMPFIX(setup,sg,'scan');
% [bg.COMP]= COMPFIX(bg,'scan');

% CALCULAR DIVERGÊNCIAS
[Y.sg,sg] = DIVFIX(sg);
% [Y.bg,bg] = DIVFIX(bg);

[M] = DIVCALC(Y);


% PLOTAR RESULTADOS
% DOPLOT(M.ash.dy,M.ash.eq.dy,sg,'ASH')
% DOPLOT(M.hist.dy,M.hist.eq.dy,sg,'HIST')
% DOPLOT(M.kde.dy.fix,M.kde.eq.dy.fix,sg,'KDE FIX')
% DOPLOT(M.kde.dy.var,M.kde.eq.dy.var,sg,'KDE VAR')
