function [V, RN, L1, IP, SQ, L2, SH, CO] = DFSelectDx(xgrid,P,Q)
N = length(P);
dx = diff(xgrid);
dx = dx(1);
% nv = 1;
% sd = 0.0001;
% [xpdf,ypdf]=getAnalytical(sg,bg,nv);
% [~,ynoise,noise]= ADDNOISE(xpdf,ypdf,sd);
% [~,ynoisefit]= ADDNOISEFIT(xpdf,ypdf,noise);
% P=ynoisefit.sg.all;
% Q=ypdf.sg.eq.all;
% plot(P,'r');hold on; plot(Q,'b')
% format long
% P =y.tr;
% Q =y.tst;
%% Divergencia entre duas funções

% bias = (sum((mean(yrec)-ytrue).*(mean(yrec)-ytrue))); % Un-normalized for length
% variance =  sum(var(yrec)); %Un-normalized for length
% total = bias+variance;


%% FAMILIA RAFAEL
% RN.ISB=(mean(P)-mean(Q))/length(P);
% RN.IV=var(Q)/length(P);

RN.ISB=(sum(P-Q))*dx;
% DRN.ISB=(sum(P-Q))*(1/N);
% figure
% subplot(1,2,1);bar(P-Q);subplot(1,2,2);bar(sum(P-Q))
% pause
% close
% fxi=(P);
% u=sum(xgrid.*fxi*dx);
% RN.IV = sum((xgrid.^2).*fxi*dx)-u^2;
RN.IV=(sum((P-Q).^2))*(dx);
% % C = cov(P,Q);
% RN.IV=C(1,2);
% RN.ISE=((sum((P-Q).^2)))/length(P);
RN.MISE = RN.IV+(RN.ISB)^2;
% RN.MISE = mean(sum(fxi.^2)*dx);
% RN.MISE2 = immse(P,Q);
%% FAMILIA LP MINKOWSKI
% LPBias = sum(P-Q);
% LPL1 = sum(abs(P-Q));
% LPL2 = sqrt(sum((P-Q).^2));
LP.LInf = max(abs(P-Q));
LP.L2N = (sqrt(sum((P-Q).^2)))*dx;
% LP.L2N = (sqrt(sum((P-Q).^2)/length(P)));

%% L1 FAMILY

L1.Sorensen = (sum(abs(P-Q))/sum(abs(P+Q)))*dx;
L1.Gower = sum(abs(P-Q))*dx;
% L1.Gower = (sum(abs(P-Q)))/length(P);
% L1Soergel = sum(abs(P-Q))/sum(max(P,Q));
% L1Kulczynski = sum(abs(P-Q))/sum(min(P,Q));
% L1Canberra = sum(abs(P-Q)./(P+Q));
% L1Lorentzian = sum(log(1+abs(P-Q)));

%% INTERSECTION FAMILY

% INIntersection = sum(abs(P-Q))/2;
% INWave = sum(abs(P-Q)./max(P,Q));
% INMotyka = sum(max(P,Q))/sum(abs(P+Q));
% INKulczynski = sum(min(P,Q))/sum(abs(P-Q));
% INRuzicka = sum(min(P,Q))/sum(max(P,Q));
% INTanimoto = sum(max(P,Q)-min(P,Q))/sum(max(P,Q));
% INAC = common_area3(P,Q);

%% INNER PRODUCT FAMILY
IP.Innerproduct = sum(P.*Q)*dx;

IPf1 = ((P.*Q)./(P+Q))*dx;
IP.Harmonic = 2*sum(IPf1(~isnan(IPf1)&~isinf(IPf1)))*dx;
IP.Cosine = 1-(((sum(P.*Q)/(sqrt(sum(P.^2))*sqrt(sum(Q.^2))))))*dx;
% IPKumar = sum(P.*Q)/(sum(P.^2)+sum(Q.^2)-sum(P.*Q));
% IPJaccard = sum((P-Q).^2)/(sum(P.^2)+sum(Q.^2)-sum(P.*Q));
% IPDice = sum((P-Q).^2)/(sum(P.^2)+sum(Q.^2));

%% Squared-Chord Family
% SQFidelity = sum(sqrt(P.*Q));
% SQBhatta = -1*log(sum(sqrt(P.*Q)));
SQ.Hellinger = sqrt(((1/2)*sum((sqrt(P)-sqrt(Q)).^2))*dx);
% SQ.Hellinger = sqrt((2*sum((sqrt(P)-sqrt(Q)).^2))/length(P));
% SQMatusita = sqrt(2-sum(sqrt(P.*Q)));
% SQSquared = sum((sqrt(P)-sqrt(Q)).^2);

%% Squared L2 Family
% L2Euclidean = (sum((P-Q).^2));
% L2Pearson = sum(((P-Q).^2)./Q);
% L2Neyman = sum(((P-Q).^2)./P);
L2f=(((P-Q).^2)./(P+Q))*dx;
L2.Squared = sqrt(sum(L2f(~isnan(L2f)&~isinf(L2f)))*dx);
% L2.Squared = sum(L2f(~isnan(L2f)&~isinf(L2f)))/length(P);
% L2ProbSym = 2*sum(((P-Q).^2)./(P+Q));
% L2Divergence = 2*sum(((P-Q).^2)./((P+Q).^2));
% L2Clark = sqrt(sum((((abs(P-Q))./(P+Q)).^2)));
L2f1 = P+Q;
L2f2 = (P.*Q);
L2f3 = (((P-Q).^2).*((L2f1(~isnan(L2f1)&~isinf(L2f1)))))./(L2f2(~isnan(L2f2)&~isinf(L2f2)));
L2.AddSym = sum(L2f3(~isnan(L2f3)&~isinf(L2f3)))*dx;
% L2.AddSym = sum((((P-Q).^2).*(P+Q))./(P.*Q));

% L2.AddSym = sum((((P-Q).^2).*((P+Q).^2))/(P.*Q));
%% Shannons entropy Family
SHf=(Q.*log((Q./P)));
SH.Kullback = sum(SHf(~isnan(SHf)&~isinf(SHf)))*dx;
% SH.Kullback = sum(SHf(~isnan(SHf)&~isinf(SHf)))/length(P);
% SHJeffreys = sum((P-Q).*log(P./Q));
% SHKdiv = sum((P).*log(2*P./(P+Q)));
% SHTopsoe = sum((P).*log(2*P./(P+Q))+(Q).*log(2*Q./(P+Q)));
% SHJensenSh = 0.5*(sum((P).*log(2*P./(P+Q)))+sum((Q).*log(2*Q./(P+Q))));
% SHJensenDif = sum(((P.*log(P)+Q.*log(Q))/2)-((P+Q)/2).*log((P+Q)/2));

%% Combinations Family

% COTaneja = sum(((P+Q)/2).*log((P+Q)./(2*sqrt(P.*Q))));
COf=((P.^2-Q.^2).^2)./(2*(P.*Q).^(3/2));
% plot(COf)
CO.Kumar = sum(COf(~isnan(COf)&~isinf(COf)))*dx;
% CO.Kumar = sum(COf(~isnan(COf)&~isinf(COf)))/length(P);

% COAvg = sum(abs(P-Q)+max(abs(P-Q)))/2;

V = ([(cell2mat(struct2cell(RN))') ...
    abs(cell2mat(struct2cell(LP))') ...
    abs(cell2mat(struct2cell(L1))') ...
    abs(cell2mat(struct2cell(IP))') ...
    abs(cell2mat(struct2cell(SQ))') ...
    abs(cell2mat(struct2cell(L2))') ...
    cell2mat(struct2cell(SH))' ...
    abs(cell2mat(struct2cell(CO))')]);

V=abs(V);
end




