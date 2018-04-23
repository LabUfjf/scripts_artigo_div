function [] = DEBUG_IP(P,Q,dx,xgrid,norm)

Innerproduct = sum(P.*Q.*dx);

EQ.grid{1} = real(P.*Q.*dx);
EQ.sum{1} = real(sum(EQ.grid{1}));

plotDIST(P,Q,xgrid)
plotGRID(xgrid,EQ.grid,'rkbgc',[{'Eq[1g]=PQdx'}],norm)
plotSUM(xgrid,EQ.sum,Innerproduct,'rkbgc',[{'Eq[1s]=\SigmaEq[1g]'},{'IP'}],norm)
