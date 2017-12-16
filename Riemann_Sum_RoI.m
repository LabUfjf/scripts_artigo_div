% RIEMANN SUM TEST
clear variables; close all; clc

method = 'fit';
type = 'deriv';

for name = {'Rayleigh'};
    % for name = {'Gauss','Bimodal','Rayleigh','Logn','Gamma'};
    
    [setup] = IN(100,2000000);
    setup.NAME = name{1};
    [sg,~] = datasetGenSingle(setup,name{1},type);
    vest = 10:1:100;
    wb = waitbar(0,'Aguarde...');
    %     for itp = {'nearest'};
    for ireg = 1:setup.DIV
        iint = 0;
        for itp = {'nearest'};
            iint=iint+1;
            iest=0;
            for nest=vest
                iest = iest+1;
                [xest,xgrid,yest,ygrid,ytruth] = FitFullFix(setup,sg,sg.RoI.x,ireg,nest,name,itp,method,type);
                [AT{iint}{ireg}(iest),E{iint}{ireg}(iest)]  = rsum(xgrid,abs(ygrid-ytruth),'mid',sg,name);
                DIVT{iint}{ireg}(iest,:) = DFSelectDx(xgrid,ygrid,ytruth);
                waitbar(iest/length(vest))
                
                
                
            end
            legend('Truth','Est','Grid','RoI')
                pause
        end
    end
end
close(wb)

VL={'Bias²','Variance','MISE','Linf','Lp','Sorensen','Gower','IP','Harmonic','Cosine','Hellinger','Squared','AddSym','Kullback','Kumar','Area'};
CL=['kr'];
ML=[':::::::::::::::'];

for reg = 1:setup.DIV
    for div = 1:15
        M{div}(reg,:) = DIVT{1}{reg}(:,div);
    end
end

for i=1:setup.DIV
    M{16}(i,:)= AT{1}{i};
end

for i=1:16
    
    % subplot(4,4,1);mesh(sg.pdf.truth.x,sg.pdf.truth.y,'k'); axis tight
    subplot(4,4,i);mesh(vest,sg.RoI.Xaxis,(M{i})); axis tight
    title([VL{i} '(D)'])
    ylabel(type)
    xlabel('X_{EST}')
    zlabel('RS')
    grid on
    set(gca,'GridLineStyle',':')
    %     set(gca,'ZTickLabel',M{i})
end
