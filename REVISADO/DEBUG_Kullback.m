function [] = DEBUG_Kullback(P,Q,dx,xgrid,norm)


SHf=(P.*log(P./Q));
SHf(isnan(SHf)|isinf(SHf))=0;
Kullback = sum(SHf.*dx);

EQ.grid{1} = real(log(P./Q));
EQ.grid{2} = real(P.*EQ.grid{1});
F1 = EQ.grid{2}; F1(isnan(F1)|isinf(F1))=0;
EQ.grid{2} = F1;
EQ.sum{1} = real(sum(EQ.grid{2}.*dx));

plotDIST(P,Q,xgrid)
plotGRID(xgrid,EQ.grid,'rkbgyc',[{'Eq[1g]=log(P/Q)'},{'Eq[2g]=PEq[1]'}],norm)
plotSUM(xgrid,EQ.sum,Kullback,'rkbgyc',[{'Eq[1s]=\SigmaEq[2g]dx'},{'Kullback'}],norm)

end

