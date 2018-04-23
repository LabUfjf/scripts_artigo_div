function [] = DEBUG_L2N(P,Q,dx,xgrid,norm)

L2N = sqrt(sum(((P-Q).^2).*dx));

EQ.grid{1} = real(((P-Q).^2).*dx);
EQ.sum{1} = real(sqrt(sum(EQ.grid{1})));

plotDIST(P,Q,xgrid)
plotGRID(xgrid,EQ.grid,'rkbgc',[{'Eq[1g]=(P-Q)²dx'}],norm)
plotSUM(xgrid,EQ.sum,L2N,'rkbgc',[{'Eq[1s]=\surd\SigmaEq[1g]'},{'L2-Norm'}],norm)
