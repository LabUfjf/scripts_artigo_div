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
        [BIN,C]=calcnbins([reshape(DATA.sg.evt,length(DATA.sg.evt),1); out],'all');
        [BIN.LHM,~,~] = LHM(DATA.sg.evt,inter);
        [BIN.truth,MA,nbin]=ASHtruth(DATA,m,binmax,inter);
        [x,y] = ASHmethods(DATA.sg.evt,m,inter,BIN);        
        
        BFD(i,j) = BIN.fd;
        BSC(i,j) = BIN.scott;
        BST(i,j) = BIN.sturges;
        BDO(i,j) = BIN.doane;
        BSS(i,j) = BIN.shimazaki;
        BRU(i,j) = BIN.rudemo;
        BLH(i,j) = BIN.LHM;
        BTR(i,j) = BIN.truth;
        
        ygrid(1,:)=interp1(x.fd,y.fd,DATA.sg.pdf.truth.x,inter,0);
        ygrid(2,:)=interp1(x.scott,y.scott,DATA.sg.pdf.truth.x,inter,0);
        ygrid(3,:)=interp1(x.sturges,y.sturges,DATA.sg.pdf.truth.x,inter,0);
        ygrid(4,:)=interp1(x.doane,y.doane,DATA.sg.pdf.truth.x,inter,0);
        ygrid(5,:)=interp1(x.shimazaki,y.shimazaki,DATA.sg.pdf.truth.x,inter,0);
        ygrid(6,:)=interp1(x.rudemo,y.rudemo,DATA.sg.pdf.truth.x,inter,0);
        ygrid(7,:)=interp1(x.LHM,y.LHM,DATA.sg.pdf.truth.x,inter,0);
        ygrid(8,:)=interp1(x.truth,y.truth,DATA.sg.pdf.truth.x,inter,0);
        
        ABFD(i,j) = area2d(DATA.sg.pdf.truth.x,abs(ygrid(1,:)-DATA.sg.pdf.truth.y));
        ABSC(i,j) = area2d(DATA.sg.pdf.truth.x,abs(ygrid(2,:)-DATA.sg.pdf.truth.y));
        ABST(i,j) = area2d(DATA.sg.pdf.truth.x,abs(ygrid(3,:)-DATA.sg.pdf.truth.y));
        ABDO(i,j) = area2d(DATA.sg.pdf.truth.x,abs(ygrid(4,:)-DATA.sg.pdf.truth.y));
        ABSS(i,j) = area2d(DATA.sg.pdf.truth.x,abs(ygrid(5,:)-DATA.sg.pdf.truth.y));
        ABRU(i,j) = area2d(DATA.sg.pdf.truth.x,abs(ygrid(6,:)-DATA.sg.pdf.truth.y));
        ABLH(i,j) = area2d(DATA.sg.pdf.truth.x,abs(ygrid(7,:)-DATA.sg.pdf.truth.y));
        ABTR(i,j) = area2d(DATA.sg.pdf.truth.x,abs(ygrid(8,:)-DATA.sg.pdf.truth.y));
        
    end
    waitbar(j/length(vEVT))
end
close(wb)

figure(1)
DADOS = {BFD-BTR;BSC-BTR;BST-BTR;BDO-BTR;BSS-BTR;BRU-BTR;BLH-BTR};
figure(1)
PLOTBOX(DADOS,vEVT,'Eventos','Erro (Bins)'); hold on
plot([0 5000],[0 0],':k')
grid minor
set(gca,'Gridlinestyle',':')

DADOS_AREA = {ABFD;ABSC;ABST;ABDO;ABSS;ABRU;ABLH;ABTR};
figure(2)
PLOTBOX(DADOS_AREA,vEVT,'Eventos','Erro (Àrea)'); hold on
plot([0 5000],[0 0],':k')
grid minor
set(gca,'Gridlinestyle',':')
