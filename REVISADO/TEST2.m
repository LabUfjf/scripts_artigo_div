function [] = TEST2()
clear

VCTEST = 100;

for name = {'Gaussian'};
    % for name = {'Gaussian','Bimodal','Rayleigh','Logn','Gamma'};
    [setup] = IN(name{1},'sg','normal','deriv','linear','mix',10,1e5,100,20); % Definir os Parâmetros Iniciais
    [DATA] = datasetGenSingle(setup);                                            % Gerar os Dados à partir desses Parâmetros
    wb = waitbar(0,['Aguarde[' name{1} ']']);
%     
%     pause
    iest=0;
    for NEST=VCTEST
        iest = iest+1;        
        setup.EST = NEST;
        [M] = MD(setup,DATA);
        DIVT{iest} = M;
        waitbar(iest/length(VCTEST))
    end
    
    
    
    close(wb)
    
    for reg = 1:length(VCTEST)
        for div = 1:15
            M2{div}(reg,:) = DIVT{reg}(:,div);
        end
    end

    
        figure
    for i=1:15
        % subplot(4,4,1);mesh(sg.pdf.truth.x,sg.pdf.truth.y,'k'); axis tight
        %         figure(i)
        subplot(5,3,i);mesh(VCTEST,DATA.sg.RoI.Xaxis,M2{i}'); axis tight
        title([setup.TYPE.MD{i}])
%         ylabel(type)
%         xlabel('X_{EST}')
%         zlabel('Riemann Sum')
%         grid on
%         set(gca,'GridLineStyle',':')
        %     set(gca,'ZTickLabel',M{i})
        %         set(gcf, 'Position', get(0, 'Screensize'));
        %         saveas(gcf,[pwd '\TRUTH\METRICA[' VL{i} ']PDF[' name{1} ']METHOD[' method ']ROI[' type ']INTERP[' itp{1} ']'],'fig')
        %         saveas(gcf,[pwd '\TRUTH\METRICA[' VL{i} ']PDF[' name{1} ']METHOD[' method ']ROI[' type ']INTERP[' itp{1} ']'],'png')
        %         close all
    end
    
end

