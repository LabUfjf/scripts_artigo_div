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
% for name = {'Gaussian','Bimodal','Trimodal','Rayleigh','Logn','Gamma','Laplace'};
%     j=j+1;
 for   name = {'Bimodal'};
    nEVT = 5000;
    nEST = 10;
    nROI = 1;
    nGRID = 10^5;
    ntmax = 50;
    out = [0];
    
    [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
    [DATA] = datasetGenSingle(setup);
    
    [bin,C]=calcnbins([reshape(DATA.sg.evt,length(DATA.sg.evt),1); out],'all');
    [bin.truth,info,nbin] =binopt(out,ntmax,setup);
    
    CB=round((bin.rudemo+bin.fd)/2);
    
    plot(nbin,info.MA,'-','color',[0.65 0.65 0.65]); hold on
    plot(nbin,info.MA+info.SA,':','color',[0.65 0.65 0.65]); hold on
    plot(nbin(bin.truth),info.MA(bin.truth),'pk','markersize',8)
    plot(nbin(bin.fd-1),info.MA(bin.fd-1),'^k','markerface','none'); hold on
    plot(nbin(bin.scott-1),info.MA(bin.scott-1),'vk','markerface','none')
    plot(nbin(bin.sturges-1),info.MA(bin.sturges-1),'>b','markerface','none')
    plot(nbin(bin.doane-1),info.MA(bin.doane-1),'<b','markerface','none')
    plot(nbin(bin.shimazaki-1),info.MA(bin.shimazaki-1),'or','markerface','none')
    plot(nbin(bin.rudemo-1),info.MA(bin.rudemo-1),'sr','markerface','none')
    plot(nbin(CB-1),info.MA(CB-1),'sm','markerface','none')
    plot(nbin,info.MA-info.SA,':','color',[0.65 0.65 0.65]); hold on
    
    grid on
    axis tight
    legend('\mu*','\sigma*','bin*','FD','Scott','Sturges','Doane','Shimazaki','Rudemo','CB')
    xlabel('Número de Bins')
    ylabel('Área do Erro')
    set(gca,'gridlinestyle',':','xscale','log','yscale','log','FontSize',12)
    
    pause
    
    rb=2:length(C.shimazaki+1);
    figure(1)
    V1(j,:)=C.shimazaki(rb-1);
    ind1(j) = find(V1(j,:)==min(V1(j,:)));
    plot(rb,V1(j,:)); legend('SS'); hold on; grid on; axis tight
    xlabel('Número de Bins')
    ylabel('C(\Delta)')
    
    
    figure(2)
    V2(j,:)=C.rudemo(rb-1);
    ind2(j) = find(V2(j,:)==min(V2(j,:)));
    plot(rb,V2(j,:)); legend('Rudemo'); hold on; grid on; axis tight
    xlabel('Número de Bins')
    ylabel('Q(h)')
end


for j=1:7
    figure(1)
    plot(rb(ind1(j)),V1(j,ind1(j)),'sk')
    legend('Gaussian','Bimodal','Trimodal','Rayleigh','Logn','Gamma','Laplace','Mínimo')
      set(gca,'gridlinestyle',':','xscale','log','yscale','log','FontSize',12)
    figure(2)
    plot(rb(ind2(j)),V2(j,ind2(j)),'sk')
    legend('Gaussian','Bimodal','Trimodal','Rayleigh','Logn','Gamma','Laplace','Mínimo')
      set(gca,'gridlinestyle',':','xscale','log','yscale','log','FontSize',12)
end