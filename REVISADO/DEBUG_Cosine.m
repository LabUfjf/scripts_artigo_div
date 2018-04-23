function [] = DEBUG_Cosine(P,Q,dx,xgrid,norm)

Cosine = (sum(P.*Q.*dx)./(sqrt(sum((P.^2).*dx)).*sqrt(sum((Q.^2).*dx))));

EQ.grid{1} = real(P.*Q.*dx);

EQ.sum{1} = real(sum(EQ.grid{1}));
EQ.sum{2} = real(sqrt(sum((P.^2).*dx)));
EQ.sum{3} = real(sqrt(sum((Q.^2).*dx)));
EQ.sum{4} = real(EQ.sum{2}.*EQ.sum{3});
EQ.sum{5} = real(EQ.sum{1}./EQ.sum{4});

plotDIST(P,Q,xgrid)
plotGRID(xgrid,EQ.grid,'rkbgyc',[{'Eq[1g]=PQdx'}],norm)
plotSUM(xgrid,EQ.sum,Cosine,'rkbgyc',[{'Eq[1s]=\SigmaEq[1g]'},{'Eq[2s]=\surd\SigmaP²dx'},{'Eq[3s]=\surd\SigmaQ²dx'},{'Eq[4s]=Eq[2s]Eq[3s]'},{'Eq[5s]=Eq[1s]/Eq[4s]'},{'Cosine'}],norm)

end

