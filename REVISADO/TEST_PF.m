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
vEVT = linspace(500,10000,20);
for name = {'Gaussian','Bimodal','Trimodal','Rayleigh','Logn','Gamma','Laplace'};
wb = waitbar(0,'Aguarde...');
for j=1:length(vEVT);
    % j=j+1;
    nEVT = round(vEVT(j));
    nEST = 10;
    nROI = 1;
    nGRID = 10^5;
    ntmax = 20;
    out = [0];
    
    for i=1:ntmax
        [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
        [DATA] = datasetGenSingle(setup);
        [bin.truth,CN{j}(i,:),~]=bintruth(DATA,out,'nearest');
        [bin.truth,CL{j}(i,:),nbin]=bintruth(DATA,out,'linear');
    end
    
    % indN = find(mean(CN)==min(mean(CN)))+1;
    % indL = find(mean(CL)==min(mean(CL)))+1;
    % F(j)=indL/indN;
    waitbar(j/length(vEVT))
end
close(wb)

for e=1:length(vEVT)
    for n=1:ntmax
        VN(e,n)=find((CN{e}(n,:))==min((CN{e}(n,:))))+1;  
        VL(e,n)=find((CL{e}(n,:))==min((CL{e}(n,:))))+1;  
    end
end

F = VL./VN;
errorbar(vEVT,mean(F'),std(F')/sqrt(ntmax),'s:'); hold on
end
legend('Gaussian','Bimodal','Trimodal','Rayleigh','Logn','Gamma','Laplace')

% for i=1:ntmax
% indN = find(mean(CN)==min(mean(CN)))+1;
% indL = find(mean(CL)==min(mean(CL)))+1;
% F(i)=indL/indN;
% end

% plot(vEVT,F,':sk')
% plot(nbin,mean(CN),'k'); hold on
% plot(nbin,mean(CL),'color',[0.75 0.75 0.75])
%
% plot([indN indN],[min([mean(CN) mean(CL)]) max([mean(CN) mean(CL)])],':k')
% plot([indL indL],[min([mean(CN) mean(CL)]) max([mean(CN) mean(CL)])],':k')
% xlabel('Número de Bins')
% ylabel('Erro de Área')
% grid on
% legend('Histograma','Polígono de Frequência','Mínimo')
% set(gca,'gridlinestyle',':','yscale','log','FontSize',12);
% axis tight;

% plot(nbin,mean(CN)./mean(CL)); hold on
