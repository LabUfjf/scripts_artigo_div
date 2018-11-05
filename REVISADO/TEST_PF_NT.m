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
nEST = 10;
nROI = 1;
nGRID = 10^5;
binmax = 100;
ntmax = 50;
out = [];
vEVT = [100 500 1000 2000 5000];

for name = {'Uniform','Gaussian','Bimodal','Trimodal','Rayleigh','Logn','Gamma','Laplace'};
% name = {'Bimodal'};


wb=waitbar(0,'Aguarde...');
for j = 1:length(vEVT)
    nEVT = round(vEVT(j));
    for i = 1:ntmax
        [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
        [DATA] = datasetGenSingle(setup);
        bin = bin_hunter(DATA,'all','PF');
        
        BIN.FD(i,j) = bin.fd;
        BIN.SC(i,j) = bin.scott;
        BIN.ST(i,j) = bin.sturges;
        BIN.DO(i,j) = bin.doane;
        BIN.SS(i,j) = bin.shimazaki;
        BIN.RU(i,j) = bin.rudemo;
        BIN.LH(i,j) = bin.LHM;
        BIN.TR(i,j) = bin.truth;
        
        AREA.FD(i,j) = areaPF(DATA,inter,bin.fd);
        AREA.SC(i,j) = areaPF(DATA,inter,bin.scott);
        AREA.ST(i,j) = areaPF(DATA,inter,bin.sturges);
        AREA.DO(i,j) = areaPF(DATA,inter,bin.doane);
        AREA.SS(i,j) = areaPF(DATA,inter,bin.shimazaki);
        AREA.RU(i,j) = areaPF(DATA,inter,bin.rudemo);
        AREA.LH(i,j) = areaPF(DATA,inter,bin.LHM);
        AREA.TR(i,j) = areaPF(DATA,inter,bin.truth);
        
    end
    waitbar(j/length(vEVT))
end
close(wb)

DADOS_BIN = {BIN.FD-BIN.TR;BIN.SC-BIN.TR;BIN.ST-BIN.TR;BIN.DO-BIN.TR;BIN.SS-BIN.TR;BIN.RU-BIN.TR;BIN.LH-BIN.TR};
DADOS_AREA = {AREA.FD;AREA.SC;AREA.ST;AREA.DO;AREA.SS;AREA.RU;AREA.LH;AREA.TR};

figure(1)
PLOTBOX(DADOS_BIN,vEVT,'Eventos','Erro(Bins)','NorthWest'); hold on
plot([0 5000],[0 0],':k')
grid minor
set(gca,'Gridlinestyle',':')
% set(gcf, 'Position', get(0, 'Screensize'));
saveas(gcf,[pwd '\DESENVOLVIMENTO\PF[BIN][' name{1} ']'],'fig');
saveas(gcf,[pwd '\DESENVOLVIMENTO\PF[BIN][' name{1} ']'],'eps');
saveas(gcf,[pwd '\DESENVOLVIMENTO\PF[BIN][' name{1} ']'],'png');
close(1)

figure(2)
PLOTBOX(DADOS_AREA,vEVT,'Eventos','Erro(Área)','NorthEast'); hold on
grid minor
set(gca,'Gridlinestyle',':')
% set(gcf, 'Position', get(0, 'Screensize'));
saveas(gcf,[pwd '\DESENVOLVIMENTO\PF[AREA][' name{1} ']'],'fig');
saveas(gcf,[pwd '\DESENVOLVIMENTO\PF[AREA][' name{1} ']'],'eps');
saveas(gcf,[pwd '\DESENVOLVIMENTO\PF[AREA][' name{1} ']'],'png');
close(2)

save([pwd '\DESENVOLVIMENTO\PF[BIN][' name{1} ']'],'BIN');
save([pwd '\DESENVOLVIMENTO\PF[AREA][' name{1} ']'],'AREA');

end
