close all; clear; clc;

wb = waitbar(0,'Aguarde...');
nt =20000;
for i = 1:nt
[setup] = IN(10000);
[sg,~] = datasetGenSingle(setup,'Bimodal');

bin = 100;
[xpdf,ypdf,ypdf2,xtruth,ytruth] = PoissonADD(sg,length(sg.evt),bin);
[yh,xh]=hist(sg.evt,xtruth);

% step = [1:20 80:100];
step = 1:bin;

ytruth=ytruth(step);
ypdf=ypdf(step);
ypdf2=ypdf2(step);
xpdf =xpdf(step);
xh=xh(step);
yh= yh(step);


A.m(i,:) = (ytruth-ypdf);
A.std(i) = std(ytruth-ypdf);

B.m(i,:) = (ytruth-yh);
B.std(i) = std(ytruth-yh);

C.m(i,:) = (ytruth-ypdf2);
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
[yA,xA]=hist(A.m(:),5*bin); 
[yC,xC]=hist(C.m(:),xA);
[yB,xB]=hist(B.m(:),xA);
% bar([yA; yB]')
subplot(1,2,1);stairs(xA,yA,'r');hold on
subplot(1,2,1);stairs(xC,yC,'b');
subplot(1,2,1);stairs(xB,yB,'k');
subplot(1,2,1);legend('Poisson','Round(Poisson)','Hist'); axis tight

[yA,xA]=hist(A.std,bin); 
[yC,xC]=hist(C.std,xA);
[yB,xB]=hist(B.std,xA);
% bar([yA; yB]')
subplot(1,2,2);stairs(xA,yA,'r');hold on
subplot(1,2,2);stairs(xC,yC,'b');
subplot(1,2,2);stairs(xB,yB,'k');
subplot(1,2,2);legend('Poisson','Round(Poisson)','Hist'); axis tight

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
legend('Poisson','Round(Poisson)','Hist')

figure
stem(ypdf-ypdf2)


