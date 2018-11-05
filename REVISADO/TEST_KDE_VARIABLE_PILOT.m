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
% vEVT = [100];
vEVT = [100 500 1000 2000 5000];
% vEVT = [5000];
nPoint = 1000;
mod='dist';
% for name = {'Gaussian','Bimodal','Trimodal','Rayleigh','Logn','Gamma','Laplace'};
for name = {'Trimodal'};
    wb = waitbar(0,'Aguarde...');
    for j=1:length(vEVT);
        nEVT = round(vEVT(j));
        nEST = 10;
        nROI = 100;
        nGRID = 10^5;
        ntmax = 25;
        mmax = 5;
        
        [setup] = IN(name{1},'sg',errortype,mod,inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
        [DATA] = datasetGenSingle(setup); n=length(DATA.sg.evt);
        for i=1:ntmax
            [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
            [DATA] = datasetGenSingle(setup);
            
            bin = calcnbins(DATA.sg.evt,'Rudemo');
             h = h_methods(DATA,nPoint);
            [A.HIST{j}(i,:),X.HIST{j}(i,:),Y.HIST{j}(i,:)] = areaPILOT(DATA,nPoint,inter,'HIST',bin,h,'SSE',1);
            [A.PF{j}(i,:),X.PF{j}(i,:),Y.PF{j}(i,:)] = areaPILOT(DATA,nPoint,inter,'PF',bin,h,'SSE',1);
            [A.ASH{j}(i,:),X.ASH{j}(i,:),Y.ASH{j}(i,:)] = areaPILOT(DATA,nPoint,inter,'ASH',bin,h,'SSE',1);
            [A.KDE{j}(i,:),X.KDE{j}(i,:),Y.KDE{j}(i,:)] = areaPILOT(DATA,nPoint,inter,'KDE',bin,h,'SSE',1);
            
            for ik = 1:14
                K.HIST{ik}(i,j)=A.HIST{j}(i,ik);
                K.PF{ik}(i,j)=A.PF{j}(i,ik);
                K.ASH{ik}(i,j)=A.ASH{j}(i,ik);
                K.KDE{ik}(i,j)=A.KDE{j}(i,ik);
            end
            
        end
        
        waitbar(j/length(vEVT))
    end
    close(wb)
end


DADOS.HIST = {K.HIST{1};K.HIST{2};K.HIST{3};K.HIST{4};K.HIST{5};K.HIST{6};K.HIST{7};K.HIST{8};K.HIST{9};K.HIST{10};K.HIST{11};K.HIST{12};K.HIST{13};K.HIST{14}};
DADOS.PF = {K.PF{1};K.PF{2};K.PF{3};K.PF{4};K.PF{5};K.PF{6};K.PF{7};K.PF{8};K.PF{9};K.PF{10};K.PF{11};K.PF{12};K.PF{13};K.PF{14}};
DADOS.ASH = {K.ASH{1};K.ASH{2};K.ASH{3};K.ASH{4};K.ASH{5};K.ASH{6};K.ASH{7};K.ASH{8};K.ASH{9};K.ASH{10};K.ASH{11};K.ASH{12};K.ASH{13};K.ASH{14}};
DADOS.KDE = {K.KDE{1};K.KDE{2};K.KDE{3};K.KDE{4};K.KDE{5};K.KDE{6};K.KDE{7};K.KDE{8};K.KDE{9};K.KDE{10};K.KDE{11};K.KDE{12};K.KDE{13};K.KDE{14}};

figure(1)
PLOTBOXKDE(DADOS.HIST,vEVT,'Eventos','Erro (Área)','NorthEast'); hold on
saveas(gcf,[pwd '\DESENVOLVIMENTO\HIST[PILOT][' name{1} ']'],'fig');
saveas(gcf,[pwd '\DESENVOLVIMENTO\HIST[PILOT][' name{1} ']'],'eps');
saveas(gcf,[pwd '\DESENVOLVIMENTO\HIST[PILOT][' name{1} ']'],'png');
close(1)

figure(2)
PLOTBOXKDE(DADOS.PF,vEVT,'Eventos','Erro (Área)','NorthEast'); hold on
saveas(gcf,[pwd '\DESENVOLVIMENTO\PF[PILOT][' name{1} ']'],'fig');
saveas(gcf,[pwd '\DESENVOLVIMENTO\PF[PILOT][' name{1} ']'],'eps');
saveas(gcf,[pwd '\DESENVOLVIMENTO\PF[PILOT][' name{1} ']'],'png');
close(2)

figure(3)
PLOTBOXKDE(DADOS.ASH,vEVT,'Eventos','Erro (Área)','NorthEast'); hold on
saveas(gcf,[pwd '\DESENVOLVIMENTO\ASH[PILOT][' name{1} ']'],'fig');
saveas(gcf,[pwd '\DESENVOLVIMENTO\ASH[PILOT][' name{1} ']'],'eps');
saveas(gcf,[pwd '\DESENVOLVIMENTO\ASH[PILOT][' name{1} ']'],'png');
close(3)

figure(4)
PLOTBOXKDE(DADOS.KDE,vEVT,'Eventos','Erro (Área)','NorthEast'); hold on
saveas(gcf,[pwd '\DESENVOLVIMENTO\KDE[PILOT][' name{1} ']'],'fig');
saveas(gcf,[pwd '\DESENVOLVIMENTO\KDE[PILOT][' name{1} ']'],'eps');
saveas(gcf,[pwd '\DESENVOLVIMENTO\KDE[PILOT][' name{1} ']'],'png');
close(4)

save([pwd '\DESENVOLVIMENTO\PILOT[' name{1} ']'],'DADOS');