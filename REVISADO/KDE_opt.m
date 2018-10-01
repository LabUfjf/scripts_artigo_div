function [x,p]=KDE_opt(data_k,nPoint,f,type)
% disp(['[KDE][OPTIMIZER][..]']); %display de controle
%==========================================================================
% KERNEL Optimizer para problemas de 1 Dimensão:
%=================================================
% Entradas: data_k: distribuição 
%           nPoint: número de pontos do kernel
%           f: fator de suavização do lambda ótimo
%           type: (tipo de banda do KDE)
%                 - 'variable' : Kernel de Banda variável
%                 - 'fix': Kernel de Banda Fixa
%                 - 'both': Calcular os dois tipos de banda
%=================================================
% Saídas:   x: range X do Kernel
%           p: probabilidades do Kernel
%==========================================================================
% Proteção do número de eventos
%==========================================================================
doPlot = 0;
n = 2000000;    %numero maximo de eventos
if length(data_k)>n;
    ind= randperm(length(data_k));
    ind= ind(1:n);
    data_k=data_k(ind);
end
if length(data_k)<=100000
    ne=length(data_k);
else
    ne = 100000;
end
%==========================================================================
% Calculo do Valor Otimo de binagem
%==========================================================================
% optN = sshist(data_k);  %cálculo da binagem ótima para o histograma baseado em L1 loss
optN = sqrt(length((data_k)));
[xhko,yhko] = data_normalized(data_k,optN);
%==========================================================================
% Calculando Lambda Ótimo
%==========================================================================
proby=interp1(xhko,yhko,data_k,'pchip');                         % Cálculo das probabilidades dos eventos de kernel
lambda_opt=exp((length(data_k)^-1)*sum(log(proby(proby~=0))));   % Calculo do lambda otimo pela teoria do paper
% disp(['[KDE][OPTIMIZER][OK]']);                                  % Display de controle
%==========================================================================
% Cálculando KERNEL
%==========================================================================
[p,x] = kernelND(data_k(1:ne)',nPoint,f*lambda_opt,{optN},type); % Rodando o Kernel com lambda ótimo para 1D
%==========================================================================
% Cálculo do Erro dos Hitogramas Kernel/Validação
%==========================================================================
[yk,xk]=hist(data_k,optN);              %calculo do histograma do kernel pra calcular o erro do hist
ak=area2d(xk,yk);                       %calculo da área do hist do kernel pro calculo do erro
[xkn,ykn]=data_normalized(data_k,optN); %histograma normalizado do Kernel
areaKDE=area2d(x{1},p);
%==========================================================================
% Plots Finais
%==========================================================================
if doPlot == 1
figure
shadedErrorBar(xkn,ykn,(sqrt(yk)/ak),'g');
hold on
plot(x{1},p,'.k');
title(['KDE Test - Area KDE = ' num2str(areaKDE) ])
ylabel('Probability Density Estimate')
xlabel('Amplitude');
end

