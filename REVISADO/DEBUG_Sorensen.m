function [] = DEBUG_Sorensen(P,Q,dx,xgrid,norm)

Sorensen = sum(abs(P-Q).*dx)./sum(abs(P+Q).*dx);

EQ.grid{1} = real(abs(P-Q).*dx);
EQ.grid{2} = real(abs(P+Q).*dx);

EQ.sum{1} = real(sum(EQ.grid{1}));
EQ.sum{2} = real(sum(EQ.grid{2}));
EQ.sum{3} = real(EQ.sum{1}./EQ.sum{2});

plotDIST(P,Q,xgrid)
plotGRID(xgrid,EQ.grid,'rkbgc',[{'Eq[1g]=|P-Q|dx'},{'Eq[2g]=|P+Q|dx'}],norm)
plotSUM(xgrid,EQ.sum,Sorensen,'rkbgc',[{'Eq[1s]=\SigmaEq[1g]'},{'Eq[2s]=\SigmaEq[2g]'},{'Eq[3s]=Eq[1s]\Eq[2s]'},{'Sorensen'}],norm)



