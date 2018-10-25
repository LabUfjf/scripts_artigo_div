% TEST DISTRIBUIÕES
clear variables;  clc; close all;
%=========================================================================
% TESTANDO TODAS AS DISTRIBUIÇÕES QUE SERÃO UTILIZADAS NA TESE
%=========================================================================
norm = 'fit';
inter = 'linear';
errortype = 'none';
mod = 'abs';
type = 'Gaussian';
r=0;
j=0;
cl = ['yrbgkmc'];
band = 'fix';
vEVT = [5000];
% vEVT = [100 500 1000 2000];
% vEVT = [5000];
nPoint = 1000;
mod='deriv';
% for name = {'Gaussian','Bimodal','Trimodal','Rayleigh','Logn','Gamma','Laplace'};
for name = {'Gaussian'};
    %     wb = waitbar(0,'Aguarde...');
    for j=1:length(vEVT);
        nEVT = round(vEVT(j));
        nEST = 10;
        nROI = 250;
        nGRID = 10^5;
        ntmax = 1;
        mmax = 5;
        
        [setup] = IN(name{1},'sg',errortype,mod,inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
        [DATA] = datasetGenSingle(setup); n=length(DATA.sg.evt);
        for i=1:ntmax
            [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
            [DATA] = datasetGenSingle(setup);
            h.PI.SV = ((4/3)^(1/5))*(std(DATA.sg.evt)*n^(-1/5)); 
            [h] = h_CV_MLCV(DATA.sg.evt,h.PI.SV,h);
            [A{j}(i,:),X{j}(i,:),pdf{j}(i,:)] = areaKDE_VAR(DATA,nPoint,h,inter,band);
            
            for ik = 1:7
                K{ik}(i,j)=A{j}(i,ik);
            end
            
        end
        
        %         waitbar(j/length(vEVT))
    end
    %     close(wb)
end

figure
plot(X{1,1}(1).SS,pdf{1,1}(1).SS,'r');hold on
plot(X{1,1}(1).SSE2,pdf{1,1}(1).SSE2,'k')
plot(DATA.sg.pdf.truth.x,DATA.sg.pdf.truth.y,'g')
KDEMAP(DATA,X,pdf,nROI)
% DADOS = {K{1};K{2};K{3};K{4};K{5};K{6};K{7};K{8};K{9};K{10};K{11};K{12};K{13};K{14};K{15}};
[f,Xlimit] = kernelND(DATA.sg.evt,100,1,10,'fix')


figure
DADOS = {K{1};K{2};K{3};K{4};K{5};K{6};K{7}};
PLOTBOXKDE_VAR(DADOS,vEVT,'Eventos','Erro (Área)'); hold on

