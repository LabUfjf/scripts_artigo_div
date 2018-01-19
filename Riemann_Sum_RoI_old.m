% RIEMANN SUM TEST
clear variables; close all; clc

method = 'full';
type = 'deriv';

for name = {'Gaussian'};
% for name = {'Gaussian','Bimodal','Rayleigh','Logn','Gamma'};
    [setup] = IN(100,1000000);
    setup.NAME = name{1};
    [sg,~] = datasetGenSingle(setup,name{1},type);
    vest = 10:1:100;
    wb = waitbar(0,['Aguarde[' name{1} ']']);
    %     for itp = {'nearest'};
    for ireg = 1:setup.DIV
        iint = 0;
        for itp = {'nearest'};
            iint=iint+1;
            iest=0;
            for nest=vest
                iest = iest+1;
                [xest,xgrid,yest,ygrid,ytruth] = FitFullFix(setup,sg,sg.RoI.x,ireg,nest,name,itp,method,type,'bypass');
                %                 [AT{iint}{ireg}(iest),E{iint}{ireg}(iest)]  = rsum(xgrid,abs(ygrid-ytruth),'mid',sg,name,0);
                DIVT{iint}{ireg}(iest,:) = DFSelectDx(xgrid,ygrid,ytruth);
                waitbar(iest/length(vest))
            end
        end
    end
    
    close(wb)
    
    VL={'Bias²','Variance','MISE','Linf','L2','Sorensen','Gower[Area]','IP','Harmonic','Cosine','Hellinger','Squared','AddSym','Kullback','Kumar'};
    CL=['kr'];
    ML=[':::::::::::::::'];
    
    for reg = 1:setup.DIV
        for div = 1:15
            M{div}(reg,:) = DIVT{1}{reg}(:,div);
        end
    end
    
    figure
    for i=1:15
        % subplot(4,4,1);mesh(sg.pdf.truth.x,sg.pdf.truth.y,'k'); axis tight
%         figure(i)
        subplot(5,3,i);mesh(vest,sg.RoI.Xaxis,(M{i})); axis tight
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
end

