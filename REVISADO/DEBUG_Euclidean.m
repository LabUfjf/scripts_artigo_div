function [] = DEBUG_Euclidean(P,Q,dx,xgrid,norm)

MISE = sum(((P-Q).^2).*dx);
 
EQ.grid{1} = real(((P-Q).^2).*dx);
EQ.sum{1} = real(sum(EQ.grid{1}));

plotDIST(P,Q,xgrid)
plotGRID(xgrid,EQ.grid,'rkbgyc',[{'Eq[1g]=(P-Q)²dx'}],norm)
plotSUM(xgrid,EQ.sum,MISE,'rkbgyc',[{'Eq[1s]=\SigmaEq[1g]'},{'Euclidean'}],norm)

end

