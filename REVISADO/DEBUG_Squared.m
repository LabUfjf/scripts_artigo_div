function [] = DEBUG_Squared(P,Q,dx,xgrid,norm)


L2f=(((P-Q).^2)./(P+Q)).*dx;
L2f(isnan(L2f)|isinf(L2f))=0;
Squared = sum(L2f);


EQ.grid{1} = real(((P-Q).^2));
EQ.grid{2} = real((P+Q));
F1 = real(EQ.grid{1}./EQ.grid{2}); F1(isnan(F1)|isinf(F1))=0;
EQ.grid{3} = F1;
EQ.sum{1} = real(sum(EQ.grid{3}.*dx));

plotDIST(P,Q,xgrid)
plotGRID(xgrid,EQ.grid,'rkbgyc',[{'Eq[1g]=(P-Q)²'},{'Eq[2g]=(P+Q)'},{'Eq[3g]=Eq[1g]/Eq[2g]'}],norm)
plotSUM(xgrid,EQ.sum,Squared,'rkbgyc',[{'Eq[1s]=\SigmaEq[3g]dx'},{'Squared'}],norm)

end

