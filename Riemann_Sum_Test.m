% RIEMANN SUM TEST
clear variables; close all; clc

type = 'bypass';

ires = 0;
for Nest = 1000000;
    %     for Nest = round(linspace(1000,100000,500));
    ires = ires +1;
    
    for name = {'Gaussian'};
        % for name = {'Gaussian','Bimodal','Rayleigh','Logn','Gamma'};
        [setup] = IN(10000,Nest); setup.DIV = 1;
        setup.NAME = name{1};
        [sg,~] = datasetGenSingle(setup,name{1},type);
        vest = round(linspace(2,2000,1000));
        wb = waitbar(0,'Aguarde...');
        i = 0;
        %         for itp = {'nearest'};
        for itp = {'nearest','linear'};
            i=i+1;
            
            j=0;
            for nest=vest
                j = j+1;
                xest = linspace(sg.pdf.truth.x(1),sg.pdf.truth.x(end),nest);
                xgrid = sg.pdf.truth.x;
                yest = GridNew(sg,xest,name);
                ygrid = interp1(xest,yest,xgrid,itp{1},'extrap');
                ytruth = GridNew(sg,xgrid,name);
                [AT{i}(j),E{i}(j)]  = rsum(xgrid,abs(ygrid-ytruth),'mid');
                [DIVT{i}(j,:)] = DFSelectDx(xgrid,ygrid,ytruth);
                waitbar(j/length(vest))
            end
        end
        
    end
    close(wb)
    
    VL={'Bias','Variance','MISE','Linf','Lp','Sorensen','Gower','IP','Harmonic','Cosine','Hellinger','Squared','AddSym','Kullback','Kumar','Area'};
    CL=['kr'];
    ML=[':::::::::::::::'];
    
    for fi = 1:2
        DIVT{fi}(:,16)=AT{fi};
    end
    RV = [10 50 100 250 500 2000];
    for d=1:16
        Res{d}(1,:) = RV;
        Res{d}(2,:)=interp1(vest,DIVT{1}(:,d),RV,'linear','extrap');
        Res{d}(3,:)=interp1(vest,DIVT{2}(:,d),RV,'linear','extrap');
    end
    
    
    for i=1:16
        subplot(4,4,i); plot(vest,DIVT{1}(:,i)','k'); hold on
        subplot(4,4,i); plot(vest,DIVT{2}(:,i)','r');
        grid on
        set(gca,'GridLineStyle',':'); axis tight;
        %         legend({'|TRUTH-EST| Nearest','|TRUTH-EST| Linear'})
                xlabel('Estimation Points')
                ylabel('Error Area')
        %         title(name{1})
        title(VL{i})
    end
    saveas(gcf,[pwd '\RS\RES_PDF_' name{1}],'fig')
    close
    
    
    
    if ires == 10
        figure
        plot(vest,AT{1}','k'); hold on
        plot(vest,AT{2}','r');
        grid on
        set(gca,'GridLineStyle',':'); axis tight;
        legend({'|TRUTH-EST| Nearest','|TRUTH-EST| Linear'},'FontSize',12)
        xlabel('Estimation Points','FontSize',14)
        ylabel('Error Area','FontSize',14)
        title(name{1},'FontSize',14)
    end
    
    saveas(gcf,[pwd '\RS\RES_PDF_AREA_' name{1}],'fig')
    close
%     
%     clear DIVT
end

% save([pwd '\RS\RES_MATRIX' name{1}],'Res')

