function [V, RN, L1, IP, SQ, L2, SH, CO] = DFSelectDx_old(xgrid,P,Q)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FULL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

P=P(:,1:end-1)';
Q=Q(:,1:end-1)';
dx = diff(xgrid');


%% Divergencia entre duas funções

%% FAMILIA CORRELATION
C = corr(P,Q,'Type','Pearson')'; %X
RN.Pearson = C(1,:);
%% L1 FAMILY
L1.Sorensen = sum(abs(P-Q).*dx)./sum(abs(P+Q).*dx);%X
%% INNER PRODUCT FAMILY
IP.Innerproduct = sum(P.*Q.*dx);%X
IPf1 = ((P.*Q)./(P+Q));
IPf1(isnan(IPf1)|isinf(IPf1))=0;
IP.Harmonic = 2*sum(IPf1.*dx);%X
IP.Cosine = (sum(P.*Q.*dx)./(sqrt(sum((P.^2).*dx)).*sqrt(sum((Q.^2).*dx))));%X

%% FAMILIA LP MINKOWSKI
LP.LInf = max(abs(P-Q));
LP.L2N = sqrt(sum(((P-Q).^2).*dx));

%% L1 FAMILY
L1.Gower = sum(abs(P-Q).*dx);

%% Squared-Chord Family
SQ.Hellinger = sqrt(((1/2)*sum(((sqrt(P)-sqrt(Q)).^2).*dx)));

%% Squared L2 Family
L2.MISE = sum(((P-Q).^2).*dx);

L2f=(((P-Q).^2)./(P+Q)).*dx;
L2f(isnan(L2f)|isinf(L2f))=0;
L2.Squared = sqrt(sum(L2f));

L2f3 = (((P-Q).^2).*((P+Q)))./P.*Q;
L2f3(isnan(L2f3)|isinf(L2f3))=0;
L2.AddSym = sum(L2f3.*dx); %X

%% Shannons entropy Family
SHf=(Q.*log((Q./P)));
SHf(isnan(SHf)|isinf(SHf))=0;
SH.Kullback = sum(SHf.*dx);


%% Combinations Family
Cot = ((P+Q)/2).*log((P+Q)./(2*sqrt(P.*Q)));
Cot(isnan(Cot)|isinf(Cot))=0;
CO.Taneja = sum(Cot.*dx); %X


COf=((P.^2-Q.^2).^2)./(2*(P.*Q).^(3/2));
COf(isnan(COf)|isinf(COf))=0;
CO.Kumar = sum(COf.*dx); %X


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




