% RIEMANN SUM TEST
clear variables; close all; clc

name = {'Gaussian'};
itp = {'linear'};
for method = {'full','fit'};
    for type = {'dist','prob','deriv'};
        for errortype = {'poisson','poisson'};
            % for name = {'Gaussian','Bimodal','Rayleigh','Logn','Gamma'};
            [setup] = IN(100,100000);
            setup.NAME = name{1};
            [sg,~] = datasetGenSingle(setup,name{1},type);
            nest = 1000;
            nt_max = 50;
            [rnoise,xlab] = SETrange(errortype);
            
            wb = waitbar(0,['Aguarde[' name{1} ']']);
            iest = 0;
            for rn= rnoise
                iest = iest+1;
                MDiv = zeros(setup.DIV,15);
                for nt = 1:nt_max
                    [xest,xgrid,yest,ygrid,ytruth] = Method_ADDNoise(setup,sg,nest,rn,name,itp,method,errortype);
                    MD(nt,:,:) = DFSelectDx(xgrid,ygrid,ytruth);
                    waitbar(iest/length(rnoise))
                 end
                M3D.mean = mean(MD);
                M3D.max = max(MD);
                M3D.min = min(MD);
                M3D.std = std(MD);
                
                for i = 1:15
                    DIVNT.mean(:,i)=M3D.mean(:,:,i);
                    DIVNT.max(:,i)=M3D.max(:,:,i);
                    DIVNT.min(:,i)=M3D.min(:,:,i);
                    DIVNT.std(:,i)=M3D.std(:,:,i);
                end
                
                DIVT.mean{iest} = DIVNT.mean;
                DIVT.max{iest} = DIVNT.max;
                DIVT.min{iest} = DIVNT.min;
                DIVT.std{iest} = DIVNT.std;
            end
            
            close(wb)
            VL={'Pearson','MISE','Linf','L2','Sorensen','Gower/Area','IP','Harmonic','Cosine','Hellinger','Squared','AddSym','Kullback','Taneja','Kumar'};
            
            for reg = 1:length(rnoise)
                for div = 1:15
                    M.mean{div}(reg,:) = DIVT.mean{reg}(:,div);
                    M.max{div}(reg,:) = DIVT.max{reg}(:,div);
                    M.min{div}(reg,:) = DIVT.min{reg}(:,div);
                    M.std{div}(reg,:) = DIVT.std{reg}(:,div);
                end
            end
            
            for i=1:15
                %       subplot_tight(5,3,i, [0.05 0.05]);surf(rnoise,sg.RoI.Xaxis,M.mean{i}'+M.std{i}','edgecolor','none'); axis tight; lighting gouraud; shading interp ; colormap; alpha(0.1);
                %       subplot_tight(5,3,i, [0.05 0.05]);surf(rnoise,sg.RoI.Xaxis,M.mean{i}'-M.std{i}','edgecolor','none'); axis tight; lighting gouraud; shading interp ; colormap; alpha(0.1);
                subplot_tight(5,3,i, [0.05 0.05]);surf(rnoise,sg.RoI.Xaxis,M.mean{i}','edgecolor','none'); axis tight; lighting gouraud; shading interp ; alpha(0.5);
                %       subplot(5,3,i);surf(rnoise,sg.RoI.Xaxis,M.mean{i}'+M.std{i}','edgecolor','none'); axis tight; lighting gouraud; shading interp ; colormap; alpha(0.1);
                %       subplot(5,3,i);surf(rnoise,sg.RoI.Xaxis,M.mean{i}'-M.std{i}','edgecolor','none'); axis tight; lighting gouraud; shading interp ; colormap; alpha(0.1);
                %       subplot(5,3,i);surf(rnoise,sg.RoI.Xaxis,M.mean{i}','edgecolor','none'); axis tight; lighting gouraud; shading interp ; alpha(0.5);
                title([VL{i}])
                ylabel(type)
                xlabel(xlab)
                zlabel('RS')
                grid on
                set(gca,'GridLineStyle',':')
            end
            pause
            % set(gcf, 'Position', get(0, 'Screensize'));
            saveas(gcf,[pwd '\TRUTH\TEST_BIAS_VAR\VAR_PDF[' name{1} ']METHOD[' method{1} ']ROI[' type{1} ']ERROR[' errortype{1} ']INTERP[' itp{1} ']NEST[' num2str(nest) ']'],'fig')
            save([pwd '\TRUTH\TEST_BIAS_VAR\MVAR[' name{1} ']METHOD[' method{1} ']ROI[' type{1} ']ERROR[' errortype{1} ']INTERP[' itp{1} ']NEST[' num2str(nest) ']'],'M')
            close all
            
        end
    end
end