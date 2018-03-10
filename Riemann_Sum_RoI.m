% RIEMANN SUM TEST
clear variables; close all; clc

method = 'full';
% for type = {'dist','prob','deriv'};
for type = {'deriv2'};
    %       for name = {'Gaussian','Bimodal','Rayleigh','Logn','Gamma'};
    for name = {'Gaussian'};
        errortype = 'no';
        for  itp = {'linear'};
            %
            
            
            [setup] = IN(100,100000);
            setup.NAME = name{1};
            [sg,~] = datasetGenSingle(setup,name{1},type);
            vest = 100:5:1500;
            % rnoise = linspace(0.00001,0.0005,100);
            
            wb = waitbar(0,['Aguarde[' name{1} ']']);
            iest = 0;
            for nest= vest
                iest = iest+1;
                MDiv = zeros(setup.DIV,15);
                [xest,xgrid,yest,ygrid,ytruth] = Method_ADDNoise(setup,sg,nest,0,name,itp,method,errortype);
                %     figure
                %     plot(xgrid(10,:),ygrid(10,:),'-r'); hold on
                %     plot(xgrid(10,:),ytruth(10,:),'-k')
                %     pause
                %         close
                %     MT(iest)=sum(ygrid(10,:)-ytruth(10,:));
                DIVT{iest} = DFSelectDx_old(xgrid,ygrid,ytruth);
                waitbar(iest/length(vest))
            end
            %     end
            
            close(wb)
            VL={'Pearson','L\infty','L2','Sorensen','Gower','IP','Harmonic','Cosine','Hellinger','Sq Euclidean','Sq \chi²','AS \chi²','KL','Taneja','KJ'};
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
                %     subplot_tight(5,3,i, [0.05 0.05]);mesh(vest,sg.RoI.Xaxis,(M{i})');
                subplot_tight(5,3,i, [0.05 0.05]);surf(vest,sg.RoI.Xaxis,M{i}','edgecolor','none'); axis tight; lighting gouraud; shading interp ; alpha(0.5);
                %     subplot(5,3,i);mesh(vest,sg.RoI.Xaxis,(M{i})'); axis tight
                title([VL{i}])
                ylabel('RoI')
                xlabel('Pts EST')
                zlabel('Área')
                grid on
                set(gca,'GridLineStyle',':')
                
            end
            %             pause
            %             INT.x = vest;
            %             INT.y = sg.RoI.Xaxis;
            %             INT.M = M{i}';
            %             set(gca,'ZTickLabel',M{i})
            %             set(gcf, 'Position', get(0, 'Screensize'));
            %             saveas(gcf,[pwd '\TRUTH\TEST_INTERP\PDF[' name{1} ']METHOD[full-fit]ROI[' type{1} ']INTERP[' itp{1} ']'],'fig')
            %             saveas(gcf,[pwd '\TRUTH\TEST_INTERP\PDF[' name{1} ']METHOD[full-fit]ROI[' type{1} ']INTERP[' itp{1} ']'],'png')
            %             save([pwd '\TRUTH\TEST_INTERP\PDF[' name{1} ']METHOD[full-fit]ROI[' type{1} ']INTERP[' itp{1} ']'],'INT')
            %             close all
        end
    end
end