close all; clear; clc;


[setup] = IN(10000,10000);
[sg,~] = datasetGenSingle(setup,'Gauss');



m = 0.1; %mean = lambda (pode variar para testar)
N = 100;
r = poissrnd(m,N,1); %gerando sinal para testar
% penew = gamrnd(alfa,beta);
%aplicando a função proposta ('poisson contínua')
bin = 50;
[xpdf,ypdf] = PoissonADD(sg,length(sg.evt),bin)
[yh,xh]=hist(sg.evt,xpdf);
stairs(xpdf,ypdf,':k'); hold on
stairs(xh,yh,':r'); axis tight
%comparando resultados
% figure;
% hold on;
% [a b] = hist(r, max(r)-min(r)+1);
% % plot(min(r):max(r),a/N, 'o', 'MarkerFaceColor','blue');
% % plot(x,y, 'or');
% 
% 
% 
% plot(sg.pdf.truth.x,sg.pdf.truth.y)