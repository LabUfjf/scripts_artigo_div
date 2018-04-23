function [] = DEBUG_Kumar(P,Q,dx,xgrid,norm)


COf=((P.^2-Q.^2).^2)./(2*(P.*Q).^(3/2));
COf(isnan(COf)|isinf(COf))=0;
Kumar = sum(COf.*dx);


EQ.grid{1} = real((P.^2-Q.^2).^2);
EQ.grid{2} = real(2*(P.*Q).^(3/2));
F1 = real(EQ.grid{1}./EQ.grid{2}); F1(isnan(F1)|isinf(F1))=0;
EQ.grid{3} = F1;
EQ.sum{1} = real(sum(EQ.grid{3}.*dx));

plotDIST(P,Q,xgrid)
plotGRID(xgrid,EQ.grid,'rkbgyc',[{'Eq[1g]=(P²-Q²)²'},{'Eq[2g]=2(PQ)^{3/2}'},{'Eq[3g]=Eq[1g]/Eq[2g]'}],norm)
plotSUM(xgrid,EQ.sum,Kumar,'rkbgyc',[{'Eq[1s]=\SigmaEq[3g]dx'},{'Kumar'}],norm)

end

