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
band = 'fix';
% vEVT = [100 500 1000 2000 5000];
vEVT = [100 500 1000];
% vEVT = [5000];
nPoint = 100;
% for name = {'Gaussian','Bimodal','Trimodal','Rayleigh','Logn','Gamma','Laplace'};
for name = {'Trimodal'};
    %     wb = waitbar(0,'Aguarde...');
    for j=1:length(vEVT);
        nEVT = round(vEVT(j));
        nEST = 10;
        nROI = 1;
        nGRID = 10^5;
        ntmax = 50;
        mmax = 15;
        
        [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
        [DATA] = datasetGenSingle(setup);
         [h] = h_plugin(DATA.sg.evt);
        [h] = h_CV(DATA.sg.evt,h.PI.SJ,h);
        %         pause
        for i=1:ntmax
            [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
            [DATA] = datasetGenSingle(setup);
            [A{j}(i,:),X{j}(i,:),pdf{j}(i,:)] = areaKDE(DATA,nPoint,h,inter,band);
            
            for ik = 1:13
                K{ik}(i,j)=A{j}(i,ik);
            end
            
        end
        
        %         waitbar(j/length(vEVT))
    end
    %     close(wb)
end




% DADOS = {K{1};K{2};K{3};K{4};K{5};K{6};K{7};K{8};K{9};K{10};K{11};K{12};K{13};K{14};K{15}};

DADOS = {K{1};K{2};K{3};K{4};K{5};K{6};K{7};K{8};K{9};K{10};K{11};K{12};K{13}};
PLOTBOXKDE(DADOS,vEVT,'Eventos','Erro (Área)'); hold on

