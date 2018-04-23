function [] = DEBUG_Pearson(P,Q,xgrid,norm)


CP = CPearson(P,Q);
mP = repmat(mean(P),length(xgrid)-1,1);
mQ = repmat(mean(Q),length(xgrid)-1,1);


EQ.grid{1} = real(P-mP);
EQ.grid{2} = real(Q-mQ);
EQ.grid{3} = real(EQ.grid{1}.*EQ.grid{2});

EQ.sum{1} = real(sqrt(sum(EQ.grid{1}.^2)));
EQ.sum{2} = real(sqrt(sum(EQ.grid{2}.^2)));
EQ.sum{3} = real(EQ.sum{1}.*EQ.sum{2});
EQ.sum{4} = real((sum(EQ.grid{3}))./(EQ.sum{3}));


plotDIST(P,Q,xgrid)
plotGRID(xgrid,EQ.grid,'rkbgc',[{'Eq[1g]=P-M_P'},{'Eq[2g]=Q-M_Q'},{'Eq[3g]=Eq[1g]Eq[2g]'}],norm)
plotSUM(xgrid,EQ.sum,CP,'rkbgc',[{'Eq[1s]=\surd\Sigma(Eq[1g]²)'},{'Eq[2s]=\surd\Sigma(Eq[2g]²)'},{'Eq[3s]=Eq[1s]Eq[2s]'},{'Eq[4s]=\SigmaEq[3g]/Eq[3s]'},{'Pearson'}],norm)
