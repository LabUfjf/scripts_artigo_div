close all; clear; clc;

wb = waitbar(0,'Aguarde...');
nt =10000;
N = 100000;
name ={'Logn'};

for i = 1:nt
    [setup] = IN(N,100000);
    [sg,~] = datasetGenSingle(setup,name{1});
    bin = 100;
    %     xtruth = linspace(min(sg.pdf.truth.x),max(sg.pdf.truth.x),bin);
    xtruth = linspace(min(sg.evt),max(sg.evt),bin);
    xpdf = xtruth;
    
    [ytruth] = GridNew(sg,xtruth,name);
    [ypdf] = PoissonADD(ytruth,ytruth,N);
    
    [yh,xh]=hist(sg.evt,xtruth);
    
    ypdf = ypdf/area2d(xtruth,ypdf);
    yh = yh/area2d(xh,yh);
    ytruth = ytruth/area2d(xtruth,ytruth);
%      stairs(xtruth,ytruth,'g');hold on
%         stairs(xtruth,ypdf,'k');hold on
%         stairs(xh,yh,'r');
%         pause
       

    step = 1:bin;
    
    ytruth=ytruth(step);
    ypdf=ypdf(step);
    xpdf =xpdf(step);
    xh=xh(step);
    yh= yh(step);
    
    A.m(i,:) = (ytruth-ypdf);
    A.std(i) = std(ytruth-ypdf);
    B.m(i,:) = (ytruth-yh);
    B.std(i) = std(ytruth-yh);
    
    waitbar(i/nt)
end

close(wb)
figure
[yA,xA]=hist(A.m(:),200);
[yB,xB]=hist(B.m(:),xA);
subplot(1,2,1);stairs(xA,yA,'r');hold on
subplot(1,2,1);stairs(xB,yB,'k');
subplot(1,2,1);legend('Poisson','Hist'); axis tight
subplot(1,2,1);title('Mean'); grid on; set(gca,'GridLineStyle',':');

[yA,xA]=hist(A.std,100);
[yB,xB]=hist(B.std,xA);
subplot(1,2,2);stairs(xA,yA,'r');hold on
subplot(1,2,2);stairs(xB,yB,'k');
subplot(1,2,2);legend('Poisson','Hist'); axis tight
subplot(1,2,2);title('Std'); grid on; set(gca,'GridLineStyle',':');

saveas(gcf,['PLOT_HIST(PH)[' name{1} ']BIN[' num2str(bin)],'fig')
close

wb2 = waitbar(0,'Aguarde...');
for i = 1:nt
    tic
    [pdfC] = PoissonADD_old(ypdf,ypdf,N);
    [pdfD] = PoissonADD(ypdf,ypdf,N);
    
    pdfC = pdfC/area2d(xtruth,pdfC);
    pdfD = pdfD/area2d(xtruth,pdfD);
    
    C.mean(i,:)=pdfC-ytruth;
    D.mean(i,:)=pdfD-ytruth;
    C.std(i)=std(pdfC-ytruth);
    D.std(i)=std(pdfD-ytruth);
    % stairs(pdfC,'r'); hold on
    % stairs(pdfD,'k')
    
    waitbar(i/nt)
end
close(wb2)

figure
[yC,xC]=hist(C.mean(:),200);
[yD,xD]=hist(D.mean(:),xC);
subplot(1,2,1);stairs(xC,yC,'r');hold on
subplot(1,2,1);stairs(xD,yD,'k');
subplot(1,2,1);legend('Poisson Cont','Poisson Disc'); axis tight
subplot(1,2,1);title('Mean'); grid on; set(gca,'GridLineStyle',':');

[yC,xC]=hist(C.std,100);
[yD,xD]=hist(D.std,xC);
subplot(1,2,2);stairs(xC,yC,'r');hold on
subplot(1,2,2);stairs(xD,yD,'k');
subplot(1,2,2);legend('Poisson Cont','Poisson Disc'); axis tight
subplot(1,2,2);title('Std'); grid on; set(gca,'GridLineStyle',':');

saveas(gcf,['PLOT_HIST(PCPD)[' name{1} ']BIN[' num2str(bin)],'fig')
close

% figure
% [yA,xA]=hist(A.std,50);
% [yB,xB]=hist(B.std,xA);
% % bar([yA; yB]')
% stairs(xA,yA,'r');hold on
% stairs(xB,yB,'k');
% legend('Poisson','Hist')

% figure
% stairs(xpdf,ypdf-ytruth,'-r'); hold on
% stairs(xpdf,ypdf2-ytruth,'-b'); hold on
% stairs(xh,yh-ytruth,':k'); axis tight
% d = (diff(xtruth)); d=d(1);
% % plot(xtruth+d/2,ytruth,'-g')
% legend('Poisson','Round(Poisson)','Hist')

% figure
% stem(ypdf-ypdf2)


