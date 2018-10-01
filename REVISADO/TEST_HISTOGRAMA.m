% TEST DISTRIBUI�ES
clear variables;  clc; close all;
%=========================================================================
% TESTANDO TODAS AS DISTRIBUI��ES QUE SER�O UTILIZADAS NA TESE
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

out = [25];

[setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Par�metros Iniciais
[DATA] = datasetGenSingle(setup);

bin=calcnbins([DATA.sg.evt; out],'all');
[bin.truth,info,nbin] =binopt(DATA,out,ntmax,name,setup);
% bin.Posterior = optBINS(DATA.sg.evt,binmax);

plot(nbin,info.MA,'-','color',[0.65 0.65 0.65]); hold on
plot(nbin,info.MA+info.SA,':','color',[0.65 0.65 0.65]); hold on
plot(nbin(bin.truth),info.MA(bin.truth),'pk','markersize',8)
plot(nbin(bin.fd-1),info.MA(bin.fd-1),'^k','markerface','none'); hold on  
plot(nbin(bin.scott-1),info.MA(bin.scott-1),'vk','markerface','none')
plot(nbin(bin.sturges-1),info.MA(bin.sturges-1),'>b','markerface','none')
plot(nbin(bin.doane-1),info.MA(bin.doane-1),'<b','markerface','none')
plot(nbin(bin.shimazaki-1),info.MA(bin.shimazaki-1),'or','markerface','none')
plot(nbin(bin.rudemo-1),info.MA(bin.rudemo-1),'sr','markerface','none')
% plot(nbin(bin.Posterior-1),info.MA(bin.Posterior-1),'og','markerface','g')
plot(nbin,info.MA-info.SA,':','color',[0.65 0.65 0.65]); hold on

grid on
axis tight
legend('\mu*','\sigma*','bin*','FD','Scott','Sturges','Doane','Shimazaki','Rudemo')
xlabel('N�mero de Bins')
ylabel('�rea do Erro')
set(gca,'gridlinestyle',':','xscale','log','yscale','log','FontSize',12)
