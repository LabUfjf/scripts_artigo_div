function [IND] = INDGEN(xpdf,div)
%==========================================================================
% Objetivo: Remover Espaços em branco entre Regiões de Interesse
%==========================================================================
N = length(xpdf);
IND = reshape(1:N,round(N/div),div);
% IND(end+1,:)=[IND(1,2:end) length(xpdf)];

end