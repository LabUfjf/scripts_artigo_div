function [] = DFSelectDx_check(setup,sg,nest,rn,name,itp,errortype,norm)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FULL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DFLAG = [0 0 0 0 0 0 0 0 0 0 1 0 0 1 0];
DFLAG = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];

norm = 'fit';
[xpdf,xgrid,ypdf,ygrid,ytruth] = Method_ADDNoise(setup,sg,nest,rn,name,itp,norm,errortype);


P = ygrid;
Q = ytruth;
P=P(:,1:end-1)';
Q=Q(:,1:end-1)';
dx = diff(xgrid');

% Pearson Correlation
mP = repmat(mean(P),length(xgrid)-1,1);
mQ = repmat(mean(Q),length(xgrid)-1,1);
EQ{1}{1} = (P-mP).*(Q-mQ);
EQ{1}{2} = sqrt(((P-mP).^2).*((Q-mQ).^2));
EQ{1}{3} = 

cl = 'kr'
for i=1:2
plot(xgrid(:,1:end-1)',EQ{1}{i},[':' cl(i)]); hold on
end

EQ{2} = P+Q;
EQ{3} = (P-Q).^2;
EQ{4} = P.*Q;
EQ{5} = P.^2;
EQ{6} = Q.^2;
EQ{7} = (sqrt(P)-sqrt(Q)).^2;
EQ{8} = log(P./Q);
EQ{9} = log((P+Q)./(2*sqrt(P.*Q)));
EQ{10} = ((P.^2)-(Q.^2)).^2;
EQ{11} = (P.*Q).^(3/2);

for i=1:length(EQ)
subplot(3,4,i); plot(xgrid(:,1:end-1)',EQ{i}); axis tight
% pause
% close
end

end





