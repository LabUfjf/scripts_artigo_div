function [V, RN, L1, IP, SQ, L2, SH, CO] = DFSelectDx(xgrid,P,Q)
P=P(1:end-1);
Q=Q(1:end-1);
dx = diff(xgrid);

%% Divergencia entre duas funções

%% FAMILIA RAFAEL
RN.ISB=sum((P-Q).*dx);
RN.IV=sum(((P-Q).^2).*dx);
RN.MISE = RN.IV+(RN.ISB)^2;

%% FAMILIA LP MINKOWSKI
LP.LInf = max(abs(P-Q));
LP.L2N = sqrt(sum(((P-Q).^2).*dx));

%% L1 FAMILY
L1.Sorensen = sum(abs(P-Q).*dx)/sum(abs(P+Q).*dx);
L1.Gower = sum(abs(P-Q).*dx);

%% INTERSECTION FAMILY

%% INNER PRODUCT FAMILY
IP.Innerproduct = sum(P.*Q.*dx);
IPf1 = ((P.*Q)./(P+Q)).*dx;
IP.Harmonic = 2*sum(IPf1(~isnan(IPf1)&~isinf(IPf1)));
IP.Cosine = (sum(P.*Q.*dx)/(sqrt(sum((P.^2).*dx))*sqrt(sum((Q.^2).*dx))));

%% Squared-Chord Family
SQ.Hellinger = sqrt(((1/2)*sum(((sqrt(P)-sqrt(Q)).^2).*dx)));

%% Squared L2 Family
L2f=(((P-Q).^2)./(P+Q)).*dx;
L2.Squared = sqrt(sum(L2f(~isnan(L2f)&~isinf(L2f))));
L2f1 = P+Q;
L2f2 = (P.*Q);
L2f3 = (((P-Q).^2).*((L2f1(~isnan(L2f1)&~isinf(L2f1)))))./(L2f2(~isnan(L2f2)&~isinf(L2f2)));
L2.AddSym = sum(L2f3(~isnan(L2f3)&~isinf(L2f3)).*dx((~isnan(L2f3)&~isinf(L2f3))));

%% Shannons entropy Family
SHf=(Q.*log((Q./P)));
SH.Kullback = sum(SHf(~isnan(SHf)&~isinf(SHf)).*dx(~isnan(SHf)&~isinf(SHf)));


%% Combinations Family
COf=((P.^2-Q.^2).^2)./(2*(P.*Q).^(3/2));
CO.Kumar = sum(COf(~isnan(COf)&~isinf(COf)).*dx(~isnan(COf)&~isinf(COf)));


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




