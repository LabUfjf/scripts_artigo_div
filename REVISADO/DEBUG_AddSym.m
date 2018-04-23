function [] = DEBUG_AddSym(P,Q,dx,xgrid,norm)


L2f3 = (((P+Q).^2).*((P+Q)))./(P.*Q);
L2f3(isnan(L2f3)|isinf(L2f3))=0;
AddSym = sum(L2f3.*dx);


EQ.grid{1} = real(((P+Q).^2).*(P+Q));
EQ.grid{2} = real(P.*Q);
F1 = real(EQ.grid{1}./EQ.grid{2}); F1(isnan(F1)|isinf(F1))=0;
EQ.grid{3} = F1;
EQ.sum{1} = real(sum(EQ.grid{3}.*dx));

plotDIST(P,Q,xgrid)
plotGRID(xgrid,EQ.grid,'rkbgyc',[{'Eq[1g]=(P+Q)²(P+Q)'},{'Eq[2g]=(PQ)'},{'Eq[3g]=Eq[1g]/Eq[2g]'}],norm)
plotSUM(xgrid,EQ.sum,AddSym,'rkbgyc',[{'Eq[1s]=\SigmaEq[3g]dx'},{'AddSym'}],norm)

end

