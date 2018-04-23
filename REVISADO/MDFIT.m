function [M] = MDFIT(RN,L1,IP,xgrid,Pfit,Qfit)
%==========================================================================
% Objetivo: * Calcular as Medidas de Distancia com a normalizção FULL
%==========================================================================
Pfit=Pfit(:,1:end-1)';
Qfit=Qfit(:,1:end-1)';
dxfit = diff(xgrid');
%% ========================================================================
%% Blocos em comum:
%==========================================================================
PQ.SUB = Pfit-Qfit;
PQ.SUM = Pfit+Qfit;
PQ.MULT = Pfit.*Qfit;
%% ========================================================================
% FAMILIA LP MINKOWSKI
%==========================================================================
    LP.LInf = max(abs(PQ.SUB));
    
    LP.L2N = sqrt(sum(((PQ.SUB).^2).*dxfit));
%% ========================================================================    
% L1 FAMILY
%==========================================================================
    L1.Gower = sum(abs(PQ.SUB).*dxfit);
%% ========================================================================    
% Squared-Chord Family
%==========================================================================
    SQ.Hellinger = sqrt(((1/2)*sum(((sqrt(Pfit)-sqrt(Qfit)).^2).*dxfit)));
%% ========================================================================    
% Squared L2 Family
%==========================================================================
    L2.MISE = sum(((PQ.SUB).^2).*dxfit);
    
    L2f=(((PQ.SUB).^2)./(PQ.SUM)).*dxfit;
    L2f(isnan(L2f)|isinf(L2f))=0;
    L2.Squared = sqrt(sum(L2f));
    
    L2f3 = (((PQ.SUB).^2).*((PQ.SUM)))./PQ.MULT;
    L2f3(isnan(L2f3)|isinf(L2f3))=0;
    L2.AddSym = sum(L2f3.*dxfit); 
%% ========================================================================    
% Shannons entropy Family
%==========================================================================
    SHf=(Pfit.*log((Pfit./Qfit)));
    SHf(isnan(SHf)|isinf(SHf))=0;
    SH.Kullback = sum(SHf.*dxfit);
%% ========================================================================    
% Combinations Family
%==========================================================================
    Cot = ((PQ.SUM)/2).*log((PQ.SUM)./(2*sqrt(PQ.MULT)));
    Cot(isnan(Cot)|isinf(Cot))=0;
    CO.Taneja = sum(Cot.*dxfit);
    
    COf=((Pfit.^2-Qfit.^2).^2)./(2*(PQ.MULT).^(3/2));
    COf(isnan(COf)|isinf(COf))=0;
    CO.Kumar = sum(COf.*dxfit); 
%% ========================================================================
% Concatena todas as Medidas de Distância em uma MATRIZ
%==========================================================================
M = ([(cell2mat(struct2cell(RN))') ...
    (cell2mat(struct2cell(LP))') ...
    (cell2mat(struct2cell(L1))') ...
    (cell2mat(struct2cell(IP))') ...
    (cell2mat(struct2cell(SQ))') ...
    (cell2mat(struct2cell(L2))') ...
    cell2mat(struct2cell(SH))' ...
    (cell2mat(struct2cell(CO))')]);

M=real(M);

end