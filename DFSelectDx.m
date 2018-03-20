function [V] = DFSelectDx(setup,sg,nest,rn,name,itp,errortype)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FULL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

bias = 0;

DFLAG = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];
% DFLAG = [0 0 0 0 0 0 0 0 0 0 1 0 0 1 0];
if DFLAG(1)+DFLAG(2)+DFLAG(3)+DFLAG(4)+DFLAG(5)~=0
[~,xgrid,~,ygrid,ytruth] = Method_ADDNoise(setup,sg,nest,rn,name,itp,'full',errortype);
P = ygrid;
Q = ytruth;
P=P(:,1:end-1)'+bias;
Q=Q(:,1:end-1)'+bias;
dx = diff(xgrid');
end

%% Divergencia entre duas funções
V = [];
%% FAMILIA CORRELATION
if DFLAG(1)==1
    C = corr(P,Q,'Type','Pearson')'; %X
    V = [V; C(1,:)];
end

%% L1 FAMILY
if DFLAG(2)==1
    V = [V; sum(abs(P-Q).*dx)./sum(abs(P+Q).*dx)];%X
end

%% INNER PRODUCT FAMILY
if DFLAG(3)==1
    V = [V; sum(P.*Q.*dx)];%X
end

if DFLAG(4)==1
    IPf1 = ((P.*Q)./(P+Q));
    IPf1(isnan(IPf1)|isinf(IPf1))=0;
    V = [V; 2*sum(IPf1.*dx)];%X
end

if DFLAG(5)==1
    V = [V; (sum(P.*Q.*dx)./(sqrt(sum((P.^2).*dx)).*sqrt(sum((Q.^2).*dx))))];%X
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear P Q dx xgrid ygrid ytruth
[~,xgrid,~,ygrid,ytruth] = Method_ADDNoise(setup,sg,nest,rn,name,itp,'fit',errortype);
clear setup sg
Pfit = ygrid;
Qfit = ytruth;

Pfit=Pfit(:,1:end-1)'+bias;
Qfit=Qfit(:,1:end-1)'+bias;
dxfit = diff(xgrid');



%% FAMILIA LP MINKOWSKI
if DFLAG(6)==1
    V = [V; max(abs(Pfit-Qfit))];
end

if DFLAG(7)==1
    V = [V; sqrt(sum(((Pfit-Qfit).^2).*dxfit))];
end

%% L1 FAMILY
if DFLAG(8)==1
    V = [V; sum(abs(Pfit-Qfit).*dxfit)];
end

%% Squared-Chord Family
if DFLAG(9)==1
    V = [V; sqrt(((1/2)*sum(((sqrt(Pfit)-sqrt(Qfit)).^2).*dxfit)))];
end

%% Squared L2 Family
if DFLAG(10)==1
    V = [V; sum(((Pfit-Qfit).^2).*dxfit)];
end


if DFLAG(11)==1
    L2f=(((Pfit-Qfit).^2)./(Pfit+Qfit)).*dxfit;
    L2f(isnan(L2f)|isinf(L2f))=0;
    V = [V; sqrt(sum(L2f))];
end

if DFLAG(12)==1
    L2f3 = (((Pfit-Qfit).^2).*((Pfit+Qfit)))./Pfit.*Qfit;
    L2f3(isnan(L2f3)|isinf(L2f3))=0;
    V = [V; sum(L2f3.*dxfit)]; %X
end

%% Shannons entropy Family

if DFLAG(13)==1
    SHf=(Qfit.*log((Qfit./Pfit)));
    SHf(isnan(SHf)|isinf(SHf))=0;
    V = [V; sum(SHf.*dxfit)];
end

%% Combinations Family

if DFLAG(14)==1
    Cot = ((Pfit+Qfit)/2).*log((Pfit+Qfit)./(2*sqrt(Pfit.*Qfit)));
    Cot(isnan(Cot)|isinf(Cot))=0;
    V = [V; sum(Cot.*dxfit)]; %X
end


if DFLAG(15)==1
    COf=((Pfit.^2-Qfit.^2).^2)./(2*(Pfit.*Qfit).^(3/2));
    COf(isnan(COf)|isinf(COf))=0;
    V = [V; sum(COf.*dxfit)]; %X
end

V=real(V);
end




