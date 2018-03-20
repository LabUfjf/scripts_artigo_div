function [V, RN, L1, IP, SQ, L2, SH, CO] = DFSelectDx_old2(setup,sg,nest,rn,name,itp,errortype)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FULL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DFLAG = [0 0 0 0 0 0 0 0 0 0 1 0 0 1 0];
DFLAG = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];

[xpdf,xgrid,ypdf,ygrid,ytruth] = Method_ADDNoise(setup,sg,nest,rn,name,itp,'full',errortype);


P = ygrid;
Q = ytruth;
P=P(:,1:end-1)';
Q=Q(:,1:end-1)';
dx = diff(xgrid');


%% Divergencia entre duas funções

%% FAMILIA CORRELATION
if DFLAG(1)==1
    C = corr(P,Q,'Type','Pearson')'; %X
    RN.Pearson = C(1,:);
else
    RN.Pearson = NaN*ones(1,size(xgrid,1));
end

%% L1 FAMILY
if DFLAG(2)==1
    L1.Sorensen = sum(abs(P-Q).*dx)./sum(abs(P+Q).*dx);%X
else
    L1.Sorensen = NaN*ones(1,size(xgrid,1));
end

%% INNER PRODUCT FAMILY
if DFLAG(3)==1
    IP.Innerproduct = sum(P.*Q.*dx);%X
else
    IP.Innerproduct = NaN*ones(1,size(xgrid,1));
end


if DFLAG(4)==1
    IPf1 = ((P.*Q)./(P+Q));
    IPf1(isnan(IPf1)|isinf(IPf1))=0;
    IP.Harmonic = 2*sum(IPf1.*dx);%X
else
    IP.Harmonic = NaN*ones(1,size(xgrid,1));
end

if DFLAG(5)==1
    IP.Cosine = (sum(P.*Q.*dx)./(sqrt(sum((P.^2).*dx)).*sqrt(sum((Q.^2).*dx))));%X
else
    IP.Cosine = NaN*ones(1,size(xgrid,1));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear P Q dx xgrid ygrid ytruth
[~,xgrid,~,ygrid,ytruth] = Method_ADDNoise(setup,sg,nest,rn,name,itp,'fit',errortype);
clear setup sg
Pfit = ygrid;
Qfit = ytruth;

Pfit=Pfit(:,1:end-1)';
Qfit=Qfit(:,1:end-1)';
dxfit = diff(xgrid');

%% FAMILIA LP MINKOWSKI
if DFLAG(6)==1
    LP.LInf = max(abs(Pfit-Qfit));
else
    LP.LInf = NaN*ones(1,size(xgrid,1));
end

if DFLAG(7)==1
    LP.L2N = sqrt(sum(((Pfit-Qfit).^2).*dxfit));
else
    LP.L2N = NaN*ones(1,size(xgrid,1));
end

%% L1 FAMILY
if DFLAG(8)==1
    L1.Gower = sum(abs(Pfit-Qfit).*dxfit);
else
    L1.Gower = NaN*ones(1,size(xgrid,1));
end

%% Squared-Chord Family
if DFLAG(9)==1
    SQ.Hellinger = sqrt(((1/2)*sum(((sqrt(Pfit)-sqrt(Qfit)).^2).*dxfit)));
else
    SQ.Hellinger = NaN*ones(1,size(xgrid,1));
end

%% Squared L2 Family
if DFLAG(10)==1
    L2.MISE = sum(((Pfit-Qfit).^2).*dxfit);
else
    L2.MISE = NaN*ones(1,size(xgrid,1));
end


if DFLAG(11)==1
    L2f=(((Pfit-Qfit).^2)./(Pfit+Qfit)).*dxfit;
    L2f(isnan(L2f)|isinf(L2f))=0;
    L2.Squared = sqrt(sum(L2f));
else
    L2.Squared = NaN*ones(1,size(xgrid,1));
end

if DFLAG(12)==1
    L2f3 = (((Pfit-Qfit).^2).*((Pfit+Qfit)))./Pfit.*Qfit;
    L2f3(isnan(L2f3)|isinf(L2f3))=0;
    L2.AddSym = sum(L2f3.*dxfit); %X
else
    L2.AddSym = NaN*ones(1,size(xgrid,1));
end

%% Shannons entropy Family

if DFLAG(13)==1
    SHf=(Qfit.*log((Qfit./Pfit)));
    SHf(isnan(SHf)|isinf(SHf))=0;
    SH.Kullback = sum(SHf.*dxfit);
else
    SH.Kullback = NaN*ones(1,size(xgrid,1));
end

%% Combinations Family

if DFLAG(14)==1
    Cot = ((Pfit+Qfit)/2).*log((Pfit+Qfit)./(2*sqrt(Pfit.*Qfit)));
    Cot(isnan(Cot)|isinf(Cot))=0;
    CO.Taneja = sum(Cot.*dxfit); %X
else
    CO.Taneja = NaN*ones(1,size(xgrid,1));
end


if DFLAG(15)==1
    COf=((Pfit.^2-Qfit.^2).^2)./(2*(Pfit.*Qfit).^(3/2));
    COf(isnan(COf)|isinf(COf))=0;
    CO.Kumar = sum(COf.*dxfit); %X
else
    CO.Kumar = NaN*ones(1,size(xgrid,1));
end

V = ([(cell2mat(struct2cell(RN))') ...
    (cell2mat(struct2cell(LP))') ...
    (cell2mat(struct2cell(L1))') ...
    (cell2mat(struct2cell(IP))') ...
    (cell2mat(struct2cell(SQ))') ...
    (cell2mat(struct2cell(L2))') ...
    cell2mat(struct2cell(SH))' ...
    (cell2mat(struct2cell(CO))')]);

V=real(V);
end




