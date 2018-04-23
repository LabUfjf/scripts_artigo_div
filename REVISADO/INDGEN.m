function [IND] = INDGEN(xpdf,div)
%==========================================================================
% Objetivo: Remover Espa�os em branco entre Regi�es de Interesse
%==========================================================================
N = length(xpdf);
IND = reshape(1:N,round(N/div),div);
% IND(end+1,:)=[IND(1,2:end) length(xpdf)];

end