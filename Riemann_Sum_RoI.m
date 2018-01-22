% RIEMANN SUM TEST
clear variables; close all; clc

method = 'full';
type = 'deriv';
name = {'Gaussian'};
errortype = 'no';
itp = {'nearest'};
% for name = {'Gaussian','Bimodal','Rayleigh','Logn','Gamma'};


[setup] = IN(100,10000);
setup.NAME = name{1};
[sg,~] = datasetGenSingle(setup,name{1},type);
nt_max = 1;
vest = 100:5:2000;
% rnoise = linspace(0.00001,0.0005,100);

wb = waitbar(0,['Aguarde[' name{1} ']']);
iest = 0;
for nest= vest
    iest = iest+1;
    MDiv = zeros(setup.DIV,15);
    [xest,xgrid,yest,ygrid,ytruth] = Method_ADDNoise(setup,sg,nest,0,name,itp,method,errortype);
    %             plot(ygrid(10,:)-ytruth(10,:),'.r');
    %     plot(xgrid(10,:),ygrid(10,:),'.r'); hold on
    %         plot(xgrid(25,:),ygrid(25,:),'.r'); hold on
    %     plot(xgrid(10,:),ytruth(10,:),'.k')
    %     pause
    %     close
    %     MT(iest)=sum(ygrid(10,:)-ytruth(10,:));
    DIVT{iest} = DFSelectDx(xgrid,ygrid,ytruth);
    waitbar(iest/length(vest))
end
%     end

close(wb)
VL={'Bias²','Variance','MISE','Linf','L2','Sorensen','Gower/Area','IP','Harmonic','Cosine','Hellinger','Squared','AddSym','Kullback','Kumar','Area'};
CL=['kr'];
ML=[':::::::::::::::'];

for reg = 1:length(vest)
    for div = 1:15
        M{div}(reg,:) = DIVT{reg}(:,div);
    end
end

for i=1:15
    % subplot(4,4,1);mesh(sg.pdf.truth.x,sg.pdf.truth.y,'k'); axis tight
    %         figure(i)
    subplot(5,3,i);mesh(vest,sg.RoI.Xaxis,(M{i})'); axis tight
    title([VL{i}])
    ylabel(type)
    xlabel('X_{EST}')
    zlabel('Riemann Sum')
    grid on
    set(gca,'GridLineStyle',':')
    %     set(gca,'ZTickLabel',M{i})
    %         set(gcf, 'Position', get(0, 'Screensize'));
    %         saveas(gcf,[pwd '\TRUTH\METRICA[' VL{i} ']PDF[' name{1} ']METHOD[' method ']ROI[' type ']INTERP[' itp{1} ']'],'fig')
    %         saveas(gcf,[pwd '\TRUTH\METRICA[' VL{i} ']PDF[' name{1} ']METHOD[' method ']ROI[' type ']INTERP[' itp{1} ']'],'png')
    %         close all
end
