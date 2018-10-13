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
vEVT = linspace(100,5000,10);
% vEVT = 50000;
% for name = {'Gaussian','Bimodal','Trimodal','Rayleigh','Logn','Gamma','Laplace'};
for name = {'Gaussian'};
     wb = waitbar(0,'Aguarde...');
    for j=1:length(vEVT);
        nEVT = round(vEVT(j));
        nEST = 10;
        nROI = 1;
        nGRID = 10^5;
        ntmax = 10;
        m=10;
       
        for i=1:ntmax
            [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
            [DATA] = datasetGenSingle(setup);
            [BIN,~] = calcnbins(DATA.sg.evt, 'all');
            [BIN.truth]=bintruth(DATA,[],'linear');
            [x,y] = ASHmethods(DATA.sg.evt,m,BIN);
            [BIN.truth]=bintruth(DATA,[],'nearest');
            [xh,yh] = HISTmethods(DATA.sg.evt,BIN);
            
            ygrid(1,:)=interp1(x.fd,y.fd,DATA.sg.pdf.truth.x,'linear',0);
            ygrid(2,:)=interp1(x.scott,y.scott,DATA.sg.pdf.truth.x,'linear',0);
            ygrid(3,:)=interp1(x.sturges,y.sturges,DATA.sg.pdf.truth.x,'linear',0);
            ygrid(4,:)=interp1(x.doane,y.doane,DATA.sg.pdf.truth.x,'linear',0);
            ygrid(5,:)=interp1(x.shimazaki,y.shimazaki,DATA.sg.pdf.truth.x,'linear',0);
            ygrid(6,:)=interp1(x.rudemo,y.rudemo,DATA.sg.pdf.truth.x,'linear',0);
            ygrid(7,:)=interp1(x.truth,y.truth,DATA.sg.pdf.truth.x,'linear',0);
            
            ygridh(1,:)=interp1(xh.fd,yh.fd,DATA.sg.pdf.truth.x,'linear',0);
            ygridh(2,:)=interp1(xh.scott,yh.scott,DATA.sg.pdf.truth.x,'linear',0);
            ygridh(3,:)=interp1(xh.sturges,yh.sturges,DATA.sg.pdf.truth.x,'linear',0);
            ygridh(4,:)=interp1(xh.doane,yh.doane,DATA.sg.pdf.truth.x,'linear',0);
            ygridh(5,:)=interp1(xh.shimazaki,yh.shimazaki,DATA.sg.pdf.truth.x,'linear',0);
            ygridh(6,:)=interp1(xh.rudemo,yh.rudemo,DATA.sg.pdf.truth.x,'linear',0);
            ygridh(7,:)=interp1(xh.truth,yh.truth,DATA.sg.pdf.truth.x,'linear',0);
            
            
            A(1,i)=area2d(DATA.sg.pdf.truth.x,abs(ygrid(1,:)-DATA.sg.pdf.truth.y));
            A(2,i)=area2d(DATA.sg.pdf.truth.x,abs(ygrid(2,:)-DATA.sg.pdf.truth.y));
            A(3,i)=area2d(DATA.sg.pdf.truth.x,abs(ygrid(3,:)-DATA.sg.pdf.truth.y));
            A(4,i)=area2d(DATA.sg.pdf.truth.x,abs(ygrid(4,:)-DATA.sg.pdf.truth.y));
            A(5,i)=area2d(DATA.sg.pdf.truth.x,abs(ygrid(5,:)-DATA.sg.pdf.truth.y));
            A(6,i)=area2d(DATA.sg.pdf.truth.x,abs(ygrid(6,:)-DATA.sg.pdf.truth.y));
            A(7,i)=area2d(DATA.sg.pdf.truth.x,abs(ygrid(7,:)-DATA.sg.pdf.truth.y));
            
            Ah(1,i)=area2d(DATA.sg.pdf.truth.x,abs(ygridh(1,:)-DATA.sg.pdf.truth.y));
            Ah(2,i)=area2d(DATA.sg.pdf.truth.x,abs(ygridh(2,:)-DATA.sg.pdf.truth.y));
            Ah(3,i)=area2d(DATA.sg.pdf.truth.x,abs(ygridh(3,:)-DATA.sg.pdf.truth.y));
            Ah(4,i)=area2d(DATA.sg.pdf.truth.x,abs(ygridh(4,:)-DATA.sg.pdf.truth.y));
            Ah(5,i)=area2d(DATA.sg.pdf.truth.x,abs(ygridh(5,:)-DATA.sg.pdf.truth.y));
            Ah(6,i)=area2d(DATA.sg.pdf.truth.x,abs(ygridh(6,:)-DATA.sg.pdf.truth.y));
            Ah(7,i)=area2d(DATA.sg.pdf.truth.x,abs(ygridh(7,:)-DATA.sg.pdf.truth.y));
            
            
            
        end
    
        %
        MA(j,:)=mean(A');
        SA(j,:)=std(A')/sqrt(ntmax);
        
        MAh(j,:)=mean(Ah');
        SAh(j,:)=std(Ah')/sqrt(ntmax);
               
        waitbar(j/length(vEVT))
    end
    createfigureASH(vEVT, MAh-MA, SA/sqrt(ntmax));
    createfigureASH(vEVT, MAh, SAh/sqrt(ntmax));
    
end

    close(wb)