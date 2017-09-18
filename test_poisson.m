close all; clear; clc;

wb = waitbar(0,'Aguarde...');
nt =5000;
for i = 1:nt
[setup] = IN(1000);
[sg,~] = datasetGenSingle(setup,'Gauss');

bin = 50;
[xpdf,ypdf,ypdf2,xtruth,ytruth] = PoissonADD(sg,length(sg.evt),bin);
[yh,xh]=hist(sg.evt,xtruth);

A.m(i) = mean(ytruth-ypdf);
B.m(i) = mean(ytruth-yh);
A.std(i) = std(ytruth-ypdf);
B.std(i) = std(ytruth-yh);
C.std(i) = mean(ytruth-ypdf2);
C.std(i) = std(ytruth-ypdf2);
waitbar(i/nt)
end

close(wb)

% [mean(A.std) mean(B.std)]
% figure
% errorbar(1:nt,A.m,A.std,'.r'); hold on
% errorbar(1:nt,B.m,B.std,'.k'); axis tight
% legend('Poisson','Hist')

figure
[yA,xA]=hist(A.m,100); 
[yB,xB]=hist(B.m,xA);
% bar([yA; yB]')
stairs(xA,yA,'r');hold on
stairs(xB,yB,'k');
legend('Poisson','Hist')

% figure
% [yA,xA]=hist(A.std,50); 
% [yB,xB]=hist(B.std,xA);
% % bar([yA; yB]')
% stairs(xA,yA,'r');hold on
% stairs(xB,yB,'k');
% legend('Poisson','Hist')

figure
stairs(xpdf,ypdf-ytruth,'-r'); hold on
stairs(xpdf,ypdf2-ytruth,'-b'); hold on
stairs(xh,yh-ytruth,':k'); axis tight
d = (diff(xtruth)); d=d(1);
% plot(xtruth+d/2,ytruth,'-g')
legend('Round(Poisson)','Poisson','Hist')


