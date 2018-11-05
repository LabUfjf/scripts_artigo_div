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
% vEVT = [1000];
vEVT = [500 1000 5000];
% vEVT = [5000];
nPoint = 1000;
mod='dist';
% for name = {'Gaussian','Bimodal','Trimodal','Rayleigh','Logn','Gamma','Laplace'};
% for name = {'Trimodal'};
%     wb = waitbar(0,'Aguarde...');
name{1}='Gaussian';
name{2}='Logn';
for j=1:length(vEVT);
    nEVT = round(vEVT(j));
    nEST = 10;
    nROI = 100;
    nGRID = 10^5;
    ntmax = 1;
    for i=1:ntmax
        [setup.d1] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
        [setup.d2] = IN(name{2},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
        [DATA.d1] = datasetGenSingle(setup.d1);
        [DATA.d2] = datasetGenSingle(setup.d2);

%         pause
        DATA.sg.evt = [DATA.d1.sg.evt DATA.d2.sg.evt];
        [h] = h_hunter2D(DATA,nPoint,r,method);
        [X.SV,pdf.SV] = kernelND(DATA,[100 100],h,'ASH','Rudemo','MLCV','SSE',1);
       
        [A{j}(i,:),xgrid,ygrid{j}{i}] = areaKDE_METHODS(DATA,nPoint,inter,'ASH','Rudemo','MLCV','SSE',1);
        
        for ik = 1:3
            K{ik}(i,j)=A{j}(i,ik);
        end
        
    end

end


[D] = KDEMAP(DATA,xgrid,ygrid{2},nROI);

DADOS = {K{1};K{2};K{3}};

figure
PLOTBOXKDE_VAR(DADOS,vEVT,'Eventos','Erro (Área)'); hold on
