function [pdf] = PoissonADD(yh,yfull,N)
%==========================================================================
% Objetivo: * Emular ru�do de poisson cont�nuo
%==========================================================================
[~,ind]= ismember(yh,yfull);
yfull = yfull/(sum(yfull));
yfull = yfull*(N);
yfull(yfull==0) = min(yfull(yfull>0));
outPDF = random('Poisson',yfull);
pdf = outPDF(ind);
end