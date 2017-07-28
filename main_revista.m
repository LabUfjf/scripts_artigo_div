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
























% plot(sg.pdf.truth.x,sg.COMP.hist.y,'r',sg.pdf.truth.x,sg.COMP.ash.y,'k',sg.pdf.truth.x,sg.COMP.kde.y.fix,'b',sg.pdf.truth.x,sg.COMP.kde.y.var,'g')
% hold on
% plot(sg.pdf.truth.x,sg.pdf.truth.y,':k')


% tic
% wb = waitbar(0,'Aguarde ...');
% for i = 1:1
%     [sg,bg] = datasetGenSingle(N,'Bimodal');
%     [sg,bg] = PDFGEN(sg,bg);
% %     [V(i,:)] = DFSelect(sg.pdf.truth.y,sg.pdf.hist.y);
%     waitbar(i/1000)
% end
% close(wb)
% toc

% for i=1: length(sg.RoI.x.dy)
% subplot(1,2,1);plot(sg.RoI.x.dy{i},sg.RoI.y.dy{i},'.'); hold on
% subplot(1,2,1);plot(bg.RoI.x.dy{i},bg.RoI.y.dy{i},'.'); hold on
% subplot(1,2,2);plot(sg.RoI.x.py{i},sg.RoI.y.py{i},'.'); hold on
% subplot(1,2,2);plot(bg.RoI.x.py{i},bg.RoI.y.py{i},'.'); hold on
% end