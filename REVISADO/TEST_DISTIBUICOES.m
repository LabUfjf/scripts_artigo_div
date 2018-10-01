% TEST DISTRIBUIÕES
clear variables;  clc; close all;
%=========================================================================
% TESTANDO TODAS AS DISTRIBUIÇÕES QUE SERÃO UTILIZADAS NA TESE
%=========================================================================
norm = 'fit';
inter = 'linear';
errortype = 'none';
% mod = 'abs';
% for name = {'Uniform','Gaussian','Bimodal','Trimodal','Rayleigh','Logn','Gamma'};
name={'Logn'};
    %=========================================================================
    nEVT = 10000;
    nEST = 100;
    nGRID= 10^5;
    nROI = 1;
    
    [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
    setup.MINMAX.STD =4;            % STD para escolher o range das PDFs.
    [DATA] = datasetGenSingle(setup);
%     for i = 1:4
%     TEST1(i,'sg')
%     end
    
    plot(DATA.sg.pdf.truth.x,DATA.sg.pdf.truth.y,'-k')
    xlabel('Variável Aleatória','FontSize',14)
    ylabel('Densidade de Probabilidade','FontSize',14)
    grid on
    set(gca,'GridLineStyle',':')
    axis tight
    set(gca,'FontSize',12)
    
%     saveas(gcf,[pwd '\TEST_DISTRIBUICOES\DIST[' name{1} ']'],'png')
%     saveas(gcf,[pwd '\TEST_DISTRIBUICOES\DIST[' name{1} ']'],'fig')
%     close
    % pause
    % % axis([min(DATA.sg.pdf.truth.x) max(DATA.sg.pdf.truth.x) 0 max(DATA.sg.pdf.truth.y)])
% end
% bin = calcnbins(DATA.sg.evt,'fd');
% [xh,yh] = data_normalized(DATA.sg.evt,bin);
% d = diff(xh); d = d(1);
% hold on
% stairs(xh-d/2,yh,'k')