% RIEMANN SUM TEST
clear variables; close all; clc

method = 'fit';
type = 'prob';
name = {'Gaussian'};
errortype = 'poisson';
itp = {'linear'};
% for name = {'Gaussian','Bimodal','Rayleigh','Logn','Gamma'};


[setup] = IN(100,1000000);
setup.NAME = name{1};
[sg,~] = datasetGenSingle(setup,name{1},type);
nest = 1000;
nt_max = 100;
rnoise = linspace(100000000,10000000,50);
% rnoise = linspace(0.00001,0.0005,100);

wb = waitbar(0,['Aguarde[' name{1} ']']);
iest = 0;
for rn= rnoise
    iest = iest+1;
    MDiv = zeros(setup.DIV,15);
    for nt = 1:nt_max
        [xest,xgrid,yest,ygrid,ytruth] = Method_ADDNoise(setup,sg,nest,rn,name,itp,method,errortype);
        MDiv = [MDiv+DFSelectDx(xgrid,ygrid,ytruth)];
        waitbar(iest/length(rnoise))
    end
    DIVT{iest} = MDiv/nt_max;
end
%     end

close(wb)
VL={'Bias²','Variance','MISE','Linf','L2','Sorensen','Gower/Area','IP','Harmonic','Cosine','Hellinger','Squared','AddSym','Kullback','Kumar','Area'};
CL=['kr'];
ML=[':::::::::::::::'];

for reg = 1:length(rnoise)
    for div = 1:15
        M{div}(reg,:) = DIVT{reg}(:,div);
    end
end
%
% % for i=1:setup.DIV
% %     M{16}(i,:)= AT{1}{i};
% % end
%
for i=1:15
    
    % subplot(4,4,1);mesh(sg.pdf.truth.x,sg.pdf.truth.y,'k'); axis tight
    subplot(3,5,i);mesh(rnoise,sg.RoI.Xaxis,M{i}'); axis tight
    title([VL{i} '(D)'])
    ylabel(type)
    xlabel('Noise')
    zlabel('RS')
    grid on
    set(gca,'GridLineStyle',':')
    %     set(gca,'ZTickLabel',M{i})
end
