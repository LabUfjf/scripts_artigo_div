function [] = DEBUG_Hellinger(P,Q,dx,xgrid,norm)

Hellinger = sqrt(((1/2)*sum(((sqrt(P)-sqrt(Q)).^2).*dx)));

EQ.grid{1} = real(sqrt(P));
EQ.grid{2} = real(sqrt(Q));
EQ.grid{3} = real(((EQ.grid{1}-EQ.grid{2}).^2).*dx);

EQ.sum{1} = real(sqrt((1/2)*sum(EQ.grid{3})));

plotDIST(P,Q,xgrid)
plotGRID(xgrid,EQ.grid,'rkbgc',[{'Eq[1g]=\surdP'},{'Eq[2g]=\surdQ'},{'Eq[3g]=(Eq[1]-Eq[2])²dx'}],norm)
plotSUM(xgrid,EQ.sum,Hellinger,'rkbgc',[{'Eq[1s]=\surd(1/2)\SigmaEq[3g]'},{'Hellinger'}],norm)
