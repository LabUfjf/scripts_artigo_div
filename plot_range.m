close all; clc; clear


Nomalization = 'no';
nbin = 5500;
nt_max = 100;
for name = {'Gauss','Bimodal','Rayleigh','Logn','Gamma'};
    % name = {'Gauss'};
    
    load(['FULL_DIST[' name{1} ']BIN[' num2str(nbin) ']NOISE[' 'normal' ']NORM[' Nomalization ']'],'DIV');DATA.N =DIV;
    load(['FULL_DIST[' name{1} ']BIN[' num2str(nbin) ']NOISE[' 'poisson' ']NORM[' Nomalization ']'],'DIV');DATA.P =DIV; clear INFO;
    
    bin.N=linspace(1,0,1000);
    bin.P=linspace(100,1000000,1000);
    
    DATAN = DATA.N.MEAN(3,:);
    DATAP = DATA.P.MEAN(3,:);
    
    MAXMIN.mean = max([min((DATAN)) min((DATAP))]);
    MINMAX.mean = min([max((DATAN)) max((DATAP))]);
    xrange.mean= linspace(MAXMIN.mean,MINMAX.mean,1000);
    
    xN.mean = interp1((DATAN),bin.N,xrange.mean,'linear','extrap');
    xP.mean = interp1((DATAP),bin.P,xrange.mean,'linear','extrap');
    %
    figure
    subplot(1,2,1);plot((xrange.mean),fliplr(xN.mean),'r'); hold on; axis tight
    subplot(1,2,1);plot(xrange.mean,xP.mean,'k');grid on; set(gca,'GridLineStyle',':'); axis tight
    subplot(1,2,2);plot((xrange.mean),fliplr(xN.mean/max(xN.mean)),'r'); hold on; axis tight
    subplot(1,2,2);plot(xrange.mean,xP.mean/max(xP.mean),'k');grid on; set(gca,'GridLineStyle',':'); axis tight
    
    [setup] = IN(10000,100000); setup.DIV = 1;
    [sg,~] = datasetGenSingle(setup,name{1});
    xh = linspace(min(sg.evt),max(max(sg.evt)),nbin);
    [ytruth] = GridNew(sg,xh,name);
    
    
    p=(1);
    
    [signal.N] = noiseADD(ytruth,ytruth,xN.mean(p),[],'normal');
    [signal.P] = noiseADD(ytruth,ytruth,[],xP.mean(p),'poisson');
    signal.P = signal.P/area2d(xh,signal.P);
    
    figure
    subplot(1,2,1);stairs(xh,signal.N,'r'); hold on; stairs(xh,ytruth,'k');grid on; set(gca,'GridLineStyle',':'); axis tight
    xlabel('Amplitude'); ylabel('Probability Density');
    subplot(1,2,2);stairs(xh,signal.P,'r'); hold on; stairs(xh,ytruth,'k');grid on; set(gca,'GridLineStyle',':'); axis tight
    xlabel('Amplitude'); ylabel('Probability Density');
    
    VAR_MEAN = [xN.mean(p) xP.mean(p)];
    
%  save(['VAR_MEAN[' name{1} ']BIN[' num2str(nbin) ']NORM[' Nomalization ']'],'VAR_MEAN')
end