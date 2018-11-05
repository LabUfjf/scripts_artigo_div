% TEST DISTRIBUIÕES
clear variables;  clc; close all;
%=========================================================================
% TESTANDO TODAS AS DISTRIBUIÇÕES QUE SERÃO UTILIZADAS NA TESE
%=========================================================================
norm = 'fit';
inter = 'linear';
errortype = 'none';
type = 'Gaussian';
r=0;
j=0;
cl = ['yrbgkmc'];
band = 'fix';
vEVT = [500];
% vEVT = [100 500 1000 2000];
% vEVT = [5000];
nPoint = 1000;
mod='deriv';
% for name = {'Gaussian','Bimodal','Trimodal','Rayleigh','Logn','Gamma','Laplace'};
for name = {'Trimodal'};
    %     wb = waitbar(0,'Aguarde...');
    for j=1:length(vEVT);
        nEVT = round(vEVT(j));
        nEST = 10;
        nROI = 100;
        nGRID = 10^5;
        ntmax = 5;
           
        [setup] = IN(name{1},'sg',errortype,mod,inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
        [DATA] = datasetGenSingle(setup); n=length(DATA.sg.evt);
        for i=1:ntmax
            [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
            [DATA] = datasetGenSingle(setup);
            
            [A{j}(i,:),xgrid,ygrid{j}{i}] = areaKDE_NEWMETHOD(DATA,nPoint,inter,'ASH','Rudemo','MLCV','SSE',1);

            
            for ik = 1:4
                K{ik}(i,j)=A{j}(i,ik);
%                 K2{ik}(i,j)=A2{j}(i,ik);
            end
            
        end
        
        %         waitbar(j/length(vEVT))
    end
    %     close(wb)
end

% figure
% plot(X{1,1}(1).SS,pdf{1,1}(1).SS,'r');hold on
% plot(X{1,1}(1).SSE2,pdf{1,1}(1).SSE2,'k')
% plot(DATA.sg.pdf.truth.x,DATA.sg.pdf.truth.y,'g')

[D] = KDEMAP(DATA,xgrid,ygrid{end},nROI);

DADOS = {K{1};K{2};K{3};K{4}};

figure
PLOTBOXKDE_VAR(DADOS,vEVT,'Eventos','Erro (Área)'); hold on
