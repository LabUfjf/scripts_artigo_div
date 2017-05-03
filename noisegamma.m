function [penew]=noisegamma(pe,ne)
%%=========================================================================
%% Função para calcular ruído gamma nas probabilidades
%%=========================================================================
%% Entradas:
%           pe - Vetor com as probabilidades de função analitica
%           ne - Número de eventos (Nesse caso representa a taxa de precisão da medida)
%           doPlot - Flag para gerar plots de check
%% Saída:
%           pe - Vetor com as novas probabilidades
%%

%% Calculo dos parametros da função Gamma

alfa=ne;    % Valor Alfa da distribuição Gamma
beta=pe/ne; % Valor Beta da distribuição Gamma

penew = gamrnd(alfa,beta);
% penew=zeros(1,length(pe));
% 
% z=waitbar(0','Wait a few weeks...');
% for i=1:length(pe)
%     [penew(i),~] = randgamma(ne,pe(i),1,[0 ne*pe(i)*10],10e3);
%     waitbar(i/length(pe))
% end
% close(z)

% if (doPlot.ruido==1)
%     figure;
%     plot(x.truth,penew,'.','DisplayName',['P.Q(' num2str(ne) ',\beta)'])
%     hold on
% %     plot(x.truth,penew2,'.k','DisplayName','Truth+NoiseGamma')
%     plot(x.truth,pe,'.r','DisplayName','P(\mu,\sigma)')
%     legend('show')
%     xlabel('Data Value')
%     ylabel('Probability')
%     pause
%     
% end

end