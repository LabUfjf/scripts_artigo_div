% RIEMANN SUM TEST
clear variables; close all; clc

method = 'full';
type = 'dist';
for name = {'Gaussian'};
    % for name = {'Gaussian','Bimodal','Rayleigh','Logn','Gamma'};
    [setup] = IN(100,1000000);
    setup.NAME = name{1};
    [sg,~] = datasetGenSingle(setup,name{1},type);
    nest = 2000;
    wb = waitbar(0,['Aguarde[' name{1} ']']);
    %     for itp = {'nearest'};
    for ireg = 1:setup.DIV
        iint = 0;
        for itp = {'linear'};
            iint=iint+1;
            iest=0;
            for v=linspace(0.1,1,20)
                %             for v=linspace(100000000,1000000,20)
                iest = iest+1;
                [xest,xgrid,yest,ygrid,ytruth] = FitFullFix_Noise(setup,sg,sg.RoI.x,ireg,nest,name,itp,method,type,v,'normal',10);
                stairs(xgrid,ygrid,'.r'); hold on
                stairs(xgrid,ytruth,'.k')
                pause
                close
                %                  ygrid = ygrid+v;
                %                 [AT{iint}{ireg}(iest),E{iint}{ireg}(iest)]  = rsum(xgrid,abs(ygrid-ytruth),'mid',sg,name,0);
                DIVT{iint}{ireg}(iest,:) = DFSelectDx(xgrid,ygrid,ytruth);
                waitbar(iest/length(linspace(0.1,1,20)))
                clear ygrid
            end
        end
    end
end
close(wb)
vest = linspace(0.01,0.1,20);
VL={'Bias²','Variance','MISE','Linf','L2','Sorensen','Gower/Area','IP','Harmonic','Cosine','Hellinger','Squared','AddSym','Kullback','Kumar','Area'};
CL=['kr'];
ML=[':::::::::::::::'];

for reg = 1:setup.DIV
    for div = 1:15
        M{div}(reg,:) = DIVT{1}{reg}(:,div);
    end
end

% for i=1:setup.DIV
%     M{16}(i,:)= AT{1}{i};
% end

for i=1:15
    
    % subplot(4,4,1);mesh(sg.pdf.truth.x,sg.pdf.truth.y,'k'); axis tight
    subplot(3,5,i);mesh(vest,sg.RoI.Xaxis,(M{i})); axis tight
    title([VL{i} '(D)'])
    ylabel(type)
    xlabel('Bias')
    zlabel('RS')
    grid on
    set(gca,'GridLineStyle',':')
    %     set(gca,'ZTickLabel',M{i})
end
