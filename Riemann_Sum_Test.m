% RIEMANN SUM TEST
clear variables; close all; clc

type = 'bypass';

ires = 0;
for Nest = round(linspace(10000,200000,20));
    ires = ires +1;
    
    for name = {'Gaussian'};
        % for name = {'Gaussian','Bimodal','Rayleigh','Logn','Gamma'};
        [setup] = IN(10000,Nest); setup.DIV = 1;
        setup.NAME = name{1};
        [sg,~] = datasetGenSingle(setup,name{1},type);
        vest = 100:100:20000;
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
                AT{i}(j)  = rsum(xgrid,abs(ygrid-ytruth),'mid');
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
    for d=1:16
        Res{ires}{d}(1,:) = [2000 5000 10000 20000];
        Res{ires}{d}(2,:)=interp1(vest,DIVT{1}(:,d),[2000 5000 10000 20000],'linear','extrap');
        Res{ires}{d}(3,:)=interp1(vest,DIVT{2}(:,d),[2000 5000 10000 20000],'linear','extrap');
    end

    if ires == 10
        figure
        plot(vest,DIVT{1}(:,16)','k'); hold on
        plot(vest,DIVT{2}(:,16)','r');
        grid on
        set(gca,'GridLineStyle',':'); axis tight;
        legend({'|TRUTH-EST| Nearest','|TRUTH-EST| Linear'},'FontSize',12)
        xlabel('Estimation Points','FontSize',14)
        ylabel('Error','FontSize',14)
        title(name{1},'FontSize',14)
        saveas(gcf,['RES_PDF' name{1}],'fig')
        saveas(gcf,['RES_PDF' name{1}],'png')
        close
    end
    clear DIVT
end

    save(['RES_MATRIX' name{1}],'Res')

