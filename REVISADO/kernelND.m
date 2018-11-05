function [X,f] = kernelND(DATA,nPoint,est,bin,h,type,dolambda)
% disp(['[KDE][PDF][..]']); %display de controle
%==========================================================================
% KERNEL UniDimensional UFJF
%==========================================================================
% Entradas: x: dados de Kernel N-Dimensional
%           nPoint: n�mero de pontos do kernel
%           lambda: fator de suaviza��o
%           optN: Binagem �tima do Histograma via L1 Loss
%           type: (tipo de banda do KDE)
%                 - 'variable' : Kernel de Banda vari�vel
%                 - 'fix': Kernel de Banda Fixa
%                 - 'both': Calcular os dois tipos de banda
%=========================================================
% Sa�das:   Xlimit: range X do Kernel
%           f: probabilidades do Kernel
%==========================================================================
%==========================================================================
x = DATA.sg.evt; 
% nPoint = 1000;
% est='ASH';
% bin_method = 'Rudemo';
% h_method = 'MLCV';
% type = 'SSE';
% dolambda = 1;
% h = h.PI.SJ
[~,hi,X,H] = PILOT(DATA,nPoint,est,bin,h,type,dolambda);

%==========================================================================
% Transformando par�metros em matriz
%==========================================================================
% x=cell2mat(x);
% X=cell2mat(X');
% n = cell2mat(n);
%==========================================================================
% Construindo o KDE
%==========================================================================

switch type
    case 'fix'
        [X,f] = KDEfixed(x,X,H,nPoint,n,nd);
    case 'SSE'
        [X,f] = KDESSE(x,{hi},nPoint);
    case 'BE'
        [X,f] = KDEBE(x,X,{hk},nPoint,n,nd);
end
