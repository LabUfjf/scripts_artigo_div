function [] = DEBUG_Harmonic(P,Q,dx,xgrid,norm)

IPf1 = (P.*Q)./(P+Q);
IPf1(isnan(IPf1)|isinf(IPf1))=0;
Harmonic = 2*sum(IPf1.*dx);

EQ.grid{1} = real(P.*Q);
EQ.grid{2} = real(P+Q);
F1 = real(EQ.grid{1}./EQ.grid{2}); F1(isnan(F1)|isinf(F1))=0;
EQ.grid{3} = F1;
EQ.sum{1} = real(2*sum(F1.*dx));

plotDIST(P,Q,xgrid)
plotGRID(xgrid,EQ.grid,'rkbgc',[{'Eq[1g]=PQ'},{'Eq[2g]=P+Q'},{'Eq[3g]=Eq[1g]/Eq[2g]'}],norm)
plotSUM(xgrid,EQ.sum,Harmonic,'rkbgc',[{'Eq[1s]=2\SigmaEq[3g]dx'},{'Harmonic'}],norm)



end