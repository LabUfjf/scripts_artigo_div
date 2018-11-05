% TEST DISTRIBUIÕES
clear variables;  clc; close all;
%=========================================================================
% TESTANDO TODAS AS DISTRIBUIÇÕES QUE SERÃO UTILIZADAS NA TESE
%=========================================================================
norm = 'fit';
inter = 'nearest';
errortype = 'none';
mod = 'abs';
j=0;
cl = ['yrbgkmc'];
binmax = 100;
% for vEVT = [100 500 1000 2000 5000];
vEVT = 500;
out = [];
% for name = {'Gaussian','Bimodal','Trimodal','Rayleigh','Logn','Gamma','Laplace'};
for name = {'Gaussian'};
    
    for j=1:length(vEVT);
        % j=j+1;
        nEVT = round(vEVT(j));
        nEST = 10;
        nROI = 1;
        nGRID = 10^5;
        ntmax = 5;
        mmax = 15;
        wb = waitbar(0,'Aguarde...');
        for i=1:ntmax
            [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
            [DATA] = datasetGenSingle(setup);
            [BIN]=calcnbins([reshape(DATA.sg.evt,length(DATA.sg.evt),1); out],'all');
            BIN.scott = round(range([reshape(DATA.sg.evt,length(DATA.sg.evt),1); out])/(2.57*std([reshape(DATA.sg.evt,length(DATA.sg.evt),1); out])*DATA.sg.n.evt^(-1/5)));
            for m=1:mmax
                 [BIN.truth,MA,nbin]=ASHtruth(DATA,m,binmax,inter);
                [x,y] = ASHmethods(DATA.sg.evt,m,inter,BIN);
                
                ygrid(1,:)=interp1(x.fd,y.fd,DATA.sg.pdf.truth.x,inter,0);
                ygrid(2,:)=interp1(x.scott,y.scott,DATA.sg.pdf.truth.x,inter,0);
                ygrid(3,:)=interp1(x.sturges,y.sturges,DATA.sg.pdf.truth.x,inter,0);
                ygrid(4,:)=interp1(x.doane,y.doane,DATA.sg.pdf.truth.x,inter,0);
                ygrid(5,:)=interp1(x.shimazaki,y.shimazaki,DATA.sg.pdf.truth.x,inter,0);
                ygrid(6,:)=interp1(x.rudemo,y.rudemo,DATA.sg.pdf.truth.x,inter,0);
                ygrid(7,:)=interp1(x.LHM,y.LHM,DATA.sg.pdf.truth.x,inter,0);
                ygrid(8,:)=interp1(x.truth,y.truth,DATA.sg.pdf.truth.x,inter,0);
                
                A{1}(i,m)=area2d(DATA.sg.pdf.truth.x,abs(ygrid(1,:)-DATA.sg.pdf.truth.y));
                A{2}(i,m)=area2d(DATA.sg.pdf.truth.x,abs(ygrid(2,:)-DATA.sg.pdf.truth.y));
                A{3}(i,m)=area2d(DATA.sg.pdf.truth.x,abs(ygrid(3,:)-DATA.sg.pdf.truth.y));
                A{4}(i,m)=area2d(DATA.sg.pdf.truth.x,abs(ygrid(4,:)-DATA.sg.pdf.truth.y));
                A{5}(i,m)=area2d(DATA.sg.pdf.truth.x,abs(ygrid(5,:)-DATA.sg.pdf.truth.y));
                A{6}(i,m)=area2d(DATA.sg.pdf.truth.x,abs(ygrid(6,:)-DATA.sg.pdf.truth.y));
                A{7}(i,m)=area2d(DATA.sg.pdf.truth.x,abs(ygrid(7,:)-DATA.sg.pdf.truth.y));
                A{8}(i,m)=area2d(DATA.sg.pdf.truth.x,abs(ygrid(8,:)-DATA.sg.pdf.truth.y));
                
            end
            waitbar(i/ntmax)
        end
        close(wb)
    end
    
end

figure(1)
DADOS = {A{1};A{2};A{3};A{4};A{5};A{6};A{7};A{8}};
figure(1)

PLOTBOX(DADOS,[1:mmax],'M','Erro (Área)'); hold on
% plot([0 20.5],[0 0],':k'); hold on
%  ADD_xtick(cell2mat(DADOS),[0:20]+0.5)
grid minor

% set(gca, 'XTickLabel', '');
