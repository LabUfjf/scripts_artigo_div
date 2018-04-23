function [] = DEBUG_Taneja(P,Q,dx,xgrid,norm)


Cot = ((P+Q)/2).*log((P+Q)./(2*sqrt(P.*Q)));
Cot(isnan(Cot)|isinf(Cot))=0;
Taneja = sum(Cot.*dx);

EQ.grid{1} = real((P+Q)/2);
EQ.grid{2} =  real(log((P+Q)./(2*sqrt(P.*Q))));
F1 = real(EQ.grid{1}.*EQ.grid{2}); F1(isnan(F1)|isinf(F1))=0;
EQ.grid{3} = F1;
EQ.sum{1} = real(sum(EQ.grid{3}.*dx));

plotDIST(P,Q,xgrid)
plotGRID(xgrid,EQ.grid,'rkbgyc',[{'Eq[1g]=(P+Q)/2'},{'Eq[2g]=log[(P+Q)/(2*sqrt(P.*Q))]'},{'Eq[3g]=Eq[1g]Eq[2g]'}],norm)
plotSUM(xgrid,EQ.sum,Taneja,'rkbgyc',[{'Eq[1s]=\SigmaEq[3g]dx'},{'Taneja'}],norm)

end

