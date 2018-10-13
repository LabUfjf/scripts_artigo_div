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
% vEVT = linspace(500,10000,20);
vEVT = 50000;
% for name = {'Gaussian','Bimodal','Trimodal','Rayleigh','Logn','Gamma','Laplace'};
for name = {'Gaussian'};
        
    for j=1:length(vEVT);
        % j=j+1;
        nEVT = round(vEVT(j));
        nEST = 10;
        nROI = 1;
        nGRID = 10^5;
        ntmax = 10;
        wb = waitbar(0,'Aguarde...');
        for i=1:ntmax
            [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
            [DATA] = datasetGenSingle(setup);
            [BIN,~] = calcnbins(DATA.sg.evt, 'all');
            [BIN.truth]=bintruth(DATA,[],'linear');
            for m=1:20
                [x,y] = ASHmethods(DATA.sg.evt,m,BIN);
                
                ygrid(1,:)=interp1(x.fd,y.fd,DATA.sg.pdf.truth.x,'linear',0);
                ygrid(2,:)=interp1(x.scott,y.scott,DATA.sg.pdf.truth.x,'linear',0);
                ygrid(3,:)=interp1(x.sturges,y.sturges,DATA.sg.pdf.truth.x,'linear',0);
                ygrid(4,:)=interp1(x.doane,y.doane,DATA.sg.pdf.truth.x,'linear',0);
                ygrid(5,:)=interp1(x.shimazaki,y.shimazaki,DATA.sg.pdf.truth.x,'linear',0);
                ygrid(6,:)=interp1(x.rudemo,y.rudemo,DATA.sg.pdf.truth.x,'linear',0);
                ygrid(7,:)=interp1(x.truth,y.truth,DATA.sg.pdf.truth.x,'linear',0);
                
                A(1,m)=area2d(DATA.sg.pdf.truth.x,abs(ygrid(1,:)-DATA.sg.pdf.truth.y));
                A(2,m)=area2d(DATA.sg.pdf.truth.x,abs(ygrid(2,:)-DATA.sg.pdf.truth.y));
                A(3,m)=area2d(DATA.sg.pdf.truth.x,abs(ygrid(3,:)-DATA.sg.pdf.truth.y));
                A(4,m)=area2d(DATA.sg.pdf.truth.x,abs(ygrid(4,:)-DATA.sg.pdf.truth.y));
                A(5,m)=area2d(DATA.sg.pdf.truth.x,abs(ygrid(5,:)-DATA.sg.pdf.truth.y));
                A(6,m)=area2d(DATA.sg.pdf.truth.x,abs(ygrid(6,:)-DATA.sg.pdf.truth.y));
                A(7,m)=area2d(DATA.sg.pdf.truth.x,abs(ygrid(7,:)-DATA.sg.pdf.truth.y));
            end
            MA(i,:,:)=A'; 
            waitbar(i/ntmax)
        end  
        close(wb)
    end
    
end

MRA=reshape(mean(MA),m,size(ygrid,1));
SRA=reshape(std(MA),m,size(ygrid,1));

createfigureASH([1:m], MRA, SRA/sqrt(m)); 
