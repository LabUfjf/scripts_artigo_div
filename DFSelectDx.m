function [V, RN, L1, IP, SQ, L2, SH, CO] = DFSelectDx(xgrid,P,Q)

P=P(:,1:end-1)';
Q=Q(:,1:end-1)';
dx = diff(xgrid');

%% Divergencia entre duas funções

%% FAMILIA RAFAEL
% RN.ISB=sum((P-Q).*dx);
% RN.IV=sum(((P-Q).^2).*dx);
% RN.MISE = RN.IV+(RN.ISB).^2;
C = 1- corr(P,Q);
RN.Pearson = C(1,:);
RN.MISE = sum(((P-Q).^2).*dx);
%% FAMILIA LP MINKOWSKI
LP.LInf = max(abs(P-Q));
LP.L2N = sqrt(sum(((P-Q).^2).*dx));

%% L1 FAMILY
L1.Sorensen = sum(abs(P-Q).*dx)./sum(abs(P+Q).*dx);
L1.Gower = sum(abs(P-Q).*dx);

%% INTERSECTION FAMILY

%% INNER PRODUCT FAMILY
IP.Innerproduct = sum(P.*Q.*dx);
IPf1 = ((P.*Q)./(P+Q));
IPf1(isnan(IPf1)|isinf(IPf1))=0;
IP.Harmonic = 2*sum(IPf1.*dx);
IP.Cosine = (sum(P.*Q.*dx)./(sqrt(sum((P.^2).*dx)).*sqrt(sum((Q.^2).*dx))));

%% Squared-Chord Family
SQ.Hellinger = sqrt(((1/2)*sum(((sqrt(P)-sqrt(Q)).^2).*dx)));

%% Squared L2 Family
L2f=(((P-Q).^2)./(P+Q)).*dx;
L2f(isnan(L2f)|isinf(L2f))=0;
L2.Squared = sqrt(sum(L2f));
L2f1 = P+Q; L2f1(isnan(L2f1)|isinf(L2f1))=0;
L2f2 = (P.*Q); L2f2(isnan(L2f2)|isinf(L2f2))=0;
L2f3 = (((P-Q).^2).*((L2f1)))./L2f2; L2f3(isnan(L2f3)|isinf(L2f3))=0;
L2.AddSym = sum(L2f3.*dx);

%% Shannons entropy Family
SHf=(Q.*log((Q./P)));
SHf(isnan(SHf)|isinf(SHf))=0;
SH.Kullback = sum(SHf.*dx);


%% Combinations Family
Cot = ((P+Q)/2).*log((P+Q)./(2*sqrt(P.*Q)));
Cot(isnan(Cot)|isinf(Cot))=0;
CO.Taneja = sum(Cot.*dx);


COf=((P.^2-Q.^2).^2)./(2*(P.*Q).^(3/2));
COf(isnan(COf)|isinf(COf))=0;
CO.Kumar = sum(COf.*dx);


V = ([(cell2mat(struct2cell(RN))') ...
    abs(cell2mat(struct2cell(LP))') ...
    abs(cell2mat(struct2cell(L1))') ...
    abs(cell2mat(struct2cell(IP))') ...
    abs(cell2mat(struct2cell(SQ))') ...
    abs(cell2mat(struct2cell(L2))') ...
    cell2mat(struct2cell(SH))' ...
    abs(cell2mat(struct2cell(CO))')]);

V=real(V);
end




