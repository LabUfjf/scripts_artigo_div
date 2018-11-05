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
m = 10;
% for name = {'Uniform','Gaussian','Bimodal','Trimodal','Rayleigh','Logn','Gamma','Laplace'};
name = {'Trimodal'};
nEST = 10;
nROI = 1;
nGRID = 10^5;
binmax = 100;
ntmax = 5;
out = [];
vEVT = [100 500 1000 2000 5000];
wb=waitbar(0,'Aguarde...');
for j = 1:length(vEVT)
    nEVT = round(vEVT(j));
    for i = 1:ntmax
        [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
        [DATA] = datasetGenSingle(setup);
        bin = bin_hunter(DATA,'all','ASH');
        [x,y] = ASHmethods(DATA.sg.evt,m,inter,bin);
        
        BIN.FD(i,j) = bin.fd;
        BIN.SC(i,j) = bin.scott;
        BIN.ST(i,j) = bin.sturges;
        BIN.DO(i,j) = bin.doane;
        BIN.SS(i,j) = bin.shimazaki;
        BIN.RU(i,j) = bin.rudemo;
        BIN.LH(i,j) = bin.LHM;
        BIN.TR(i,j) = bin.truth;
        
        ygrid(1,:)=interp1(x.fd,y.fd,DATA.sg.pdf.truth.x,inter,0);
        ygrid(2,:)=interp1(x.scott,y.scott,DATA.sg.pdf.truth.x,inter,0);
        ygrid(3,:)=interp1(x.sturges,y.sturges,DATA.sg.pdf.truth.x,inter,0);
        ygrid(4,:)=interp1(x.doane,y.doane,DATA.sg.pdf.truth.x,inter,0);
        ygrid(5,:)=interp1(x.shimazaki,y.shimazaki,DATA.sg.pdf.truth.x,inter,0);
        ygrid(6,:)=interp1(x.rudemo,y.rudemo,DATA.sg.pdf.truth.x,inter,0);
        ygrid(7,:)=interp1(x.LHM,y.LHM,DATA.sg.pdf.truth.x,inter,0);
        ygrid(8,:)=interp1(x.truth,y.truth,DATA.sg.pdf.truth.x,inter,0);
        
        AREA.FD(i,j) = area2d(DATA.sg.pdf.truth.x,abs(ygrid(1,:)-DATA.sg.pdf.truth.y));
        AREA.SC(i,j) = area2d(DATA.sg.pdf.truth.x,abs(ygrid(2,:)-DATA.sg.pdf.truth.y));
        AREA.ST(i,j) = area2d(DATA.sg.pdf.truth.x,abs(ygrid(3,:)-DATA.sg.pdf.truth.y));
        AREA.DO(i,j) = area2d(DATA.sg.pdf.truth.x,abs(ygrid(4,:)-DATA.sg.pdf.truth.y));
        AREA.SS(i,j) = area2d(DATA.sg.pdf.truth.x,abs(ygrid(5,:)-DATA.sg.pdf.truth.y));
        AREA.RU(i,j) = area2d(DATA.sg.pdf.truth.x,abs(ygrid(6,:)-DATA.sg.pdf.truth.y));
        AREA.LH(i,j) = area2d(DATA.sg.pdf.truth.x,abs(ygrid(7,:)-DATA.sg.pdf.truth.y));
        AREA.TR(i,j) = area2d(DATA.sg.pdf.truth.x,abs(ygrid(8,:)-DATA.sg.pdf.truth.y));
        
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
saveas(gcf,[pwd '\DESENVOLVIMENTO\ASH[BIN][' name{1} ']'],'fig');
saveas(gcf,[pwd '\DESENVOLVIMENTO\ASH[BIN][' name{1} ']'],'eps');
saveas(gcf,[pwd '\DESENVOLVIMENTO\ASH[BIN][' name{1} ']'],'png');
close(1)

figure(2)
PLOTBOX(DADOS_AREA,vEVT,'Eventos','Erro(Área)','NorthEast'); hold on
grid minor
set(gca,'Gridlinestyle',':')
% set(gcf, 'Position', get(0, 'Screensize'));
saveas(gcf,[pwd '\DESENVOLVIMENTO\ASH[AREA][' name{1} ']'],'fig');
saveas(gcf,[pwd '\DESENVOLVIMENTO\ASH[AREA][' name{1} ']'],'eps');
saveas(gcf,[pwd '\DESENVOLVIMENTO\ASH[AREA][' name{1} ']'],'png');
close(2)

save([pwd '\DESENVOLVIMENTO\ASH[BIN][' name{1} ']'],'BIN');
save([pwd '\DESENVOLVIMENTO\ASH[AREA][' name{1} ']'],'AREA');


