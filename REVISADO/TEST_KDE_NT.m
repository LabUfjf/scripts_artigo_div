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
for name = {'Laplace'};
    %     wb = waitbar(0,'Aguarde...');
    for j=1:length(vEVT);
        nEVT = round(vEVT(j));
        nEST = 10;
        nROI = 1;
        nGRID = 10^5;
        ntmax = 3;
        mmax = 15;
        
        [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
        [DATA] = datasetGenSingle(setup);
        
        for i=1:ntmax
            [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
            [DATA] = datasetGenSingle(setup);
            [h] = h_plugin(DATA.sg.evt);
            [h] = h_CV(DATA.sg.evt,h.PI.SJ,h);
            [h.truth] = h_truth(DATA,nPoint);
            [A{j}(i,:),X{j}(i,:),pdf{j}(i,:)] = areaKDE(DATA,nPoint,h,inter,band);
            
           hopt{1}(i,j)= h.PI.SV;
           hopt{2}(i,j)= h.PI.SVM1;
           hopt{3}(i,j)= h.PI.SVM2;
           hopt{4}(i,j)= h.PI.SJ;
           hopt{5}(i,j)= h.PI.SC;
           hopt{6}(i,j)= h.CV.MLCV;
           hopt{7}(i,j)= h.CV.UCV;
           hopt{8}(i,j)= h.CV.BCV1;
           hopt{9}(i,j)= h.CV.BCV2;
           hopt{10}(i,j)= h.CV.CCV;
           hopt{11}(i,j)= h.CV.MCV;
           hopt{12}(i,j)= h.CV.TCV;
           hopt{13}(i,j)= h.CV.LSCV;
           hopt{14}(i,j)= h.truth;
           
            for ik = 1:14
                K{ik}(i,j)=A{j}(i,ik);
            end
            
        end
        
        %         waitbar(j/length(vEVT))
    end
    %     close(wb)
end


DADOSH = {hopt{1};hopt{2};hopt{3};hopt{4};hopt{5};hopt{6};hopt{7};hopt{8};hopt{9};hopt{10};hopt{11};hopt{12};hopt{13};hopt{14}};
PLOTBOXKDE(DADOSH,vEVT,'Eventos','h'); hold on
% DADOS = {K{1};K{2};K{3};K{4};K{5};K{6};K{7};K{8};K{9};K{10};K{11};K{12};K{13};K{14};K{15}};
figure
DADOS = {K{1};K{2};K{3};K{4};K{5};K{6};K{7};K{8};K{9};K{10};K{11};K{12};K{13};K{14}};
PLOTBOXKDE(DADOS,vEVT,'Eventos','Erro (Área)'); hold on

