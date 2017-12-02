% RIEMANN SUM TEST
clear variables; close all; clc

type = 'bypass';
ires = 0;
%  Nest = round(linspace(1000,1000000,100));
for Nest = 10000000
    ires = ires +1;
    
    for name = {'Gauss'};
        % for name = {'Gauss','Bimodal','Rayleigh','Logn','Gamma'};
        [setup] = IN(10000,Nest); setup.DIV = 1;
        setup.NAME = name{1};
        [sg,~] = datasetGenSingle(setup,name{1},type);
        vest = 100:100:20000;
        wb = waitbar(0,'Aguarde...');
        i = 0;
        for itp = {'nearest'};
            %         for itp = {'nearest','linear'};
            i=i+1;
            
            j=0;
            for nest=vest
                j = j+1;
                xest = linspace(sg.pdf.truth.x(1),sg.pdf.truth.x(end),nest);
                xgrid = sg.pdf.truth.x;
                yest = GridNew(sg,xest,name);
                ygrid = interp1(xest,yest,xgrid,itp{1},'extrap');
                ytruth = GridNew(sg,xgrid,name);
                AT1{i}(j)  = rsum(xgrid,abs(ygrid-ytruth),'mid');
                AT2{i}(j)  = rsum(xgrid,abs(ygrid-ytruth),'left');
                AT3{i}(j)  = rsum(xgrid,abs(ygrid-ytruth),'right');
                %                 [DIVT{i}(j,:)] = DFSelectDx(xgrid,ygrid,ytruth);
                waitbar(j/length(vest))
                [ERROR(j)] = ErrorMaxRS(xest,sg.pdf.truth.x,sg.pdf.truth.y);
            end
        end
        
    end
    close(wb)
    
    VL={'Bias','Variance','MISE','Linf','Lp','Sorensen','Gower','IP','Harmonic','Cosine','Hellinger','Squared','AddSym','Kullback','Kumar','Area'};
    CL=['kr'];
    ML=[':::::::::::::::'];
    %
    
    %     figure
    %     for fi = 1:2
    %         DIVT{fi}(:,size(DIVT{fi},2)+1)=AT{fi};
    % %         for d=1:16
    % %             subplot(4,4,d);plot(vest,DIVT{fi}(:,d)',CL(fi));
    % %             title([VL{d}])
    % %             xlabel('X_{EST}')
    % %             ylabel('Value')
    % %             grid on
    % %             set(gca,'GridLineStyle',':'); axis tight;
    % %             hold on
    % %             legend('Nearest','Linear')
    % %             clc
    % %         end
    %     end
    
    %     Res.nearest{ires}=interp1(vest,DIVT{1},[2000 5000 10000 15000],'linear','extrap');
    %     Res.linear{ires}=interp1(vest,DIVT{2},[2000 5000 10000 15000],'linear','extrap');
    %     clear DIVT
    
end

