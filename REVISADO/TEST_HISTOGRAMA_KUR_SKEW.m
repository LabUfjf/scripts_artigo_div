% TEST DISTRIBUIÕES
clear variables;  clc; close all;
%=========================================================================
% TESTANDO TODAS AS DISTRIBUIÇÕES QUE SERÃO UTILIZADAS NA TESE
%=========================================================================
norm = 'fit';
inter = 'linear';
errortype = 'none';
mod = 'abs';
j=0;
cl = ['yrbgkmc'];
for name = {'Uniform','Gaussian','Bimodal','Trimodal','Rayleigh','Logn','Gamma','Laplace'};
    % name = {'Gamma'};
    nEST = 10;
    nROI = 1;
    nGRID = 10^5;
    ntmax = 100;
    vEVT = linspace(100,10000,20);
    
    wb=waitbar(0,'Aguarde...');
    for j = 1:length(vEVT)
        nEVT = round(vEVT(j));
        for i = 1:ntmax
            [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
            [DATA] = datasetGenSingle(setup);
            CR(i,j)=kurtosis(DATA.sg.evt);
            SK(i,j)=skewness(DATA.sg.evt);
        end
        waitbar(j/length(vEVT))
    end
    close(wb)
    
    errorbar(vEVT,mean(CR),std(CR)/sqrt(length(vEVT)),':sk','markersize',4); hold on
    errorbar(vEVT,mean(SK),std(SK)/sqrt(length(vEVT)),':sr','markersize',4)
    legend('Kurtosis','Skewness')
    xlabel('Número de Eventos')
    ylabel('Valores')
    grid on
    set(gca,'gridlinestyle',':','FontSize',12)
    axis tight
    
    saveas(gcf,[pwd '\TEST_HISTOGRAMA\DATA_KUR_SKEW[' name{1} ']'],'png')
    saveas(gcf,[pwd '\TEST_HISTOGRAMA\DATA_KUR_SKEW[' name{1} ']'],'fig')
    saveas(gcf,[pwd '\TEST_HISTOGRAMA\DATA_KUR_SKEW[' name{1} ']'],'eps')
    close
end