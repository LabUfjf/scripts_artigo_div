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
% for name = {'Uniform','Gaussian','Bimodal','Trimodal','Rayleigh','Logn','Gamma','Laplace'};
name = {'Gamma'};
nEST = 10;
nROI = 1;
nGRID = 10^5;
binmax = 100;
ntmax = 30;
out = [];
vEVT = linspace(100,10000,20);

wb=waitbar(0,'Aguarde...');
for j = 1:length(vEVT)
    nEVT = round(vEVT(j));
    for i = 1:ntmax
        [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
        [DATA] = datasetGenSingle(setup);
        [bin,C]=calcnbins([reshape(DATA.sg.evt,length(DATA.sg.evt),1); out],'all');
        [bin.truth]=bintruth(DATA,out);
        BFD(i,j) = bin.fd;
        BSC(i,j) = bin.scott;
        BST(i,j) = bin.sturges;
        BDO(i,j) = bin.doane;
        BSS(i,j) = bin.shimazaki;
        BRU(i,j) = bin.rudemo;
        BTR(i,j) = bin.truth;
    end
    waitbar(j/length(vEVT))
end
close(wb)

figure(1)
errorbar(vEVT,mean(BFD),std(BFD)/sqrt(ntmax),'o:k','markersize',4); hold on
errorbar(vEVT,mean(BSC),std(BSC)/sqrt(ntmax),'o:r','markersize',4);
errorbar(vEVT,mean(BST),std(BST)/sqrt(ntmax),'o:c','markersize',4);
errorbar(vEVT,mean(BDO),std(BDO)/sqrt(ntmax),'o:b','markersize',4);
errorbar(vEVT,mean(BSS),std(BSS)/sqrt(ntmax),'*:g','markersize',4);
errorbar(vEVT,mean(BRU),std(BRU)/sqrt(ntmax),'*:m','markersize',4);
errorbar(vEVT,mean(BTR),std(BTR)/sqrt(ntmax),'*-k','markersize',4);
ylabel('Número de Bins')
xlabel('Amostras')
axis tight
grid on
set(gca,'gridlinestyle',':','FontSize',12)
legend('FD','Scott','Sturges','Doane','Shimazaki','Rudemo','Truth')

figure(2)
errorbar(vEVT,mean(BTR)-mean(BFD),(std(BTR)+std(BFD))/sqrt(ntmax),'o:k','markersize',4); hold on
errorbar(vEVT,mean(BTR)-mean(BSC),(std(BTR)+std(BSC))/sqrt(ntmax),'o:r','markersize',4);
errorbar(vEVT,mean(BTR)-mean(BST),(std(BTR)+std(BST))/sqrt(ntmax),'o:c','markersize',4);
errorbar(vEVT,mean(BTR)-mean(BDO),(std(BTR)+std(BDO))/sqrt(ntmax),'o:b','markersize',4);
errorbar(vEVT,mean(BTR)-mean(BSS),(std(BTR)+std(BSS))/sqrt(ntmax),'*:g','markersize',4);
errorbar(vEVT,mean(BTR)-mean(BRU),(std(BTR)+std(BRU))/sqrt(ntmax),'*:m','markersize',4);
ylabel('Erro de Estimação dos Bins')
xlabel('Amostras')
axis tight
grid on
set(gca,'gridlinestyle',':','FontSize',12)
legend('FD','Scott','Sturges','Doane','Shimazaki','Rudemo')

% [bin.truth,info,nbin] =binopt(DATA,out,ntmax,name,setup);
% % bin.Posterior = optBINS(DATA.sg.evt,binmax);
%
% plot(nbin,info.MA,'-','color',[0.65 0.65 0.65]); hold on
% plot(nbin,info.MA+info.SA,':','color',[0.65 0.65 0.65]); hold on
% plot(nbin(bin.truth),info.MA(bin.truth),'pk','markersize',8)
% plot(nbin(bin.fd-1),info.MA(bin.fd-1),'^k','markerface','none'); hold on
% plot(nbin(bin.scott-1),info.MA(bin.scott-1),'vk','markerface','none')
% plot(nbin(bin.sturges-1),info.MA(bin.sturges-1),'>b','markerface','none')
% plot(nbin(bin.doane-1),info.MA(bin.doane-1),'<b','markerface','none')
% plot(nbin(bin.shimazaki-1),info.MA(bin.shimazaki-1),'or','markerface','none')
% plot(nbin(bin.rudemo-1),info.MA(bin.rudemo-1),'sr','markerface','none')
% % plot(nbin(bin.Posterior-1),info.MA(bin.Posterior-1),'og','markerface','g')
% plot(nbin,info.MA-info.SA,':','color',[0.65 0.65 0.65]); hold on
%
% grid on
% axis tight
% legend('\mu*','\sigma*','bin*','FD','Scott','Sturges','Doane','Shimazaki','Rudemo')
% xlabel('Número de Bins')
% ylabel('Área do Erro')
% set(gca,'gridlinestyle',':','xscale','log','yscale','log','FontSize',12)
%
%
% rb=20:length(C.shimazaki+1);
% figure
% subplot(1,2,1);plot(rb,C.shimazaki(rb-1),'-k'); legend('SS'); hold on; grid on; axis tight
% set(gca,'gridlinestyle',':','xscale','log','FontSize',12)
% subplot(1,2,2);plot(rb,C.rudemo(rb-1),'-k'); legend('Rudemo'); hold on; grid on; axis tight
% set(gca,'gridlinestyle',':','xscale','log','FontSize',12)