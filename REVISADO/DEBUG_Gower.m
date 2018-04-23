function [] = DEBUG_Gower(P,Q,dx,xgrid,norm)

Gower = sum(abs(P-Q).*dx);

EQ.grid{1} = real(abs(P-Q).*dx);
EQ.sum{1} = real(sum(EQ.grid{1}));

plotDIST(P,Q,xgrid)
plotGRID(xgrid,EQ.grid,'rkbgc',[{'Eq[1g]=|P-Q|dx'}],norm)
plotSUM(xgrid,EQ.sum,Gower,'rkbgc',[{'Eq[1s]=\SigmaEq[1g]'},{'Gower'}],norm)
