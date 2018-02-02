

% RIEMANN SUM TEST
clear variables; close all; clc

name = {'Gaussian'};
itp = {'linear'};
nest = 1000;
VL={'Bias','Variance','MISE','Linf','L2','Sorensen','Gower/Area','IP','Harmonic','Cosine','Hellinger','Squared','AddSym','Kullback','Kumar','Area'};
for method = {'fit','full'};
    for type = {'dist','prob','deriv'};
        for errortype = {'poisson','normal'};
            [setup] = IN(100,100000);
            setup.NAME = name{1};
            [sg,~] = datasetGenSingle(setup,name{1},type);
            [rnoise,xlab] = SETrange(errortype);
            load([pwd '\TRUTH\TEST_BIAS_VAR\MVAR[' name{1} ']METHOD[' method{1} ']ROI[' type{1} ']ERROR[' errortype{1} ']INTERP[' itp{1} ']NEST[' num2str(nest) ']'],'M')
            %             pause
            for i=1:15
                %                 subplot_tight(5,3,i, [0.075 0.075]);surf(rnoise,sg.RoI.Xaxis,M.std{i}','edgecolor','none'); axis tight; lighting gouraud; shading interp ; alpha(0.5);
                %                 if strcmp(errortype{1},'poisson')
                %                     set(gca, 'XDir','reverse')
                %                 end
                
                %                 title([VL{i}])
                %                 ylabel(type,'Fontsize',10)
                %                 xlabel(xlab,'Fontsize',10)
                %                 zlabel('STD')
                %                 grid on
                %                 set(gca,'GridLineStyle',':')
                MV(i)=max(max(M.std{i}'));
            end
            A=reshape(MV,3,5)'

            set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]);
            %             saveas(gcf,[pwd '\TRUTH\TEST_BIAS_VAR\VAR_PDF[' name{1} ']METHOD[' method{1} ']ROI[' type{1} ']ERROR[' errortype{1} ']INTERP[' itp{1} ']NEST[' num2str(nest) ']'],'pdf')
            saveas(gcf,[pwd '\TRUTH\TEST_BIAS_VAR\STD_PDF[' name{1} ']METHOD[' method{1} ']ROI[' type{1} ']ERROR[' errortype{1} ']INTERP[' itp{1} ']NEST[' num2str(nest) ']'],'png')
            close all
            
        end
    end
end