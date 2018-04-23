function [] = DEBUG_Linf(P,Q,xgrid,norm)

LInf = max(abs(P-Q));

EQ.grid{1} = real(abs(P-Q));
EQ.sum{1} = real(max(EQ.grid{1}));

plotDIST(P,Q,xgrid)
plotGRID(xgrid,EQ.grid,'rkbgc',[{'Eq[1g]=|P-Q|'}],norm)
plotSUM(xgrid,EQ.sum,LInf,'rkbgc',[{'Eq[1s]=max(Eq[1g])'},{'L\infty'}],norm)
