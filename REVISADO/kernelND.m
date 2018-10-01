function [f,Xlimit] = kernelND(x,nPoint,lambda,optN,type)
% disp(['[KDE][PDF][..]']); %display de controle
%==========================================================================
% KERNEL UniDimensional UFJF
%==========================================================================
% Entradas: x: dados de Kernel N-Dimensional
%           nPoint: número de pontos do kernel
%           lambda: fator de suavização
%           optN: Binagem Ótima do Histograma via L1 Loss
%           type: (tipo de banda do KDE)
%                 - 'variable' : Kernel de Banda variável
%                 - 'fix': Kernel de Banda Fixa
%                 - 'both': Calcular os dois tipos de banda
%=========================================================
% Saídas:   Xlimit: range X do Kernel
%           f: probabilidades do Kernel
%==========================================================================
%==========================================================================
fp = 0;                                 % habilita plots finais
x = x(:);
x={x'};                                 % comentar para kernel N-Dimensional, por isso não precisa ser cell
nd=length(x);                           % número de dimensões

%-------------------------------------------------------------------------%
%% PreAllocation
n=cell(1,nd); 
h=cell(1,nd);
yp=cell(1,nd);
xp=cell(1,nd);
ah=cell(1,nd);
fp_pdf=cell(1,nd);
fpi=cell(1,nd);
X=cell(1,nd);
H=zeros(nd,nd);
KNDv=cell(1,nd);
KNDf=cell(1,nd);
%-------------------------------------------------------------------------%

for d=1:nd;                             % loop para preencher variáveis de cada dimensão
    n{d}=length(x{d});                  % eventos em cada dimensão
    [~,stdv] = zoom_pdf2d_diff([x{d}; x{d}],'proj');
    h{d} =((4/(nd+2))^(1/(nd+4)))*stdv.v1.v1*n{d}^(-1/(nd+4)); % cálculo do h("rule-of-thumb") ótimo pelo AMISE    
    [yp{d},xp{d}]=hist(x{d},optN{d});   %extraindo x e y do histograma "ótimo"
    ah{d} = area2d(xp{d},yp{d});        %cálculo da área do histograma
    fp_pdf{d}=yp{d}/ah{d};              %normalização do histograma pela área(substituir linhas anteriores pelo data_normalized)
    fpi{d}=interp1(xp{d},fp_pdf{d},x{d},'nearest','extrap');                %cálculo da probabilidade de cada evento
    [~,X{d}] = space_stat(x{d},nPoint(d));
end
[hi] = hihj(h,lambda,fpi,nd,n);         % cálculo da banda variável
%==========================================================================
% Transformando parâmetros em matriz
%==========================================================================
for d=1:nd;
    H(d,d) =h{d}^2;
end

Hi=cell(1,n{d});
for i=1:n{d}
    for d=1:nd;
        Hi{i}(d,d) =hi{d}(i)^2;
    end
end

Xlimit=X;
x=cell2mat(x);
X=cell2mat(X');
n = cell2mat(n);

Kv=zeros(nPoint(1),length(x));
Kf=zeros(nPoint(1),length(x));
%==========================================================================
% Fazendo os Cálculos do KERNEL ND de banda Fixa e Variável
%==========================================================================
% h=waitbar(0','[KDEND]WORKANDO...');
if nd==1;
    Hi=cell2mat(Hi);
    for j=1:nPoint(1)
        Kv(j,:)=Hi.^(-1/2).*Kn(Hi.^(-1/2).*(repmat(X(:,j),1,length(x))-x));
        Kf(j,:)=H.^(-1/2).*Kn(H.^(-1/2).*(repmat(X(:,j),1,length(x))-x));
%         waitbar(j/nPoint(1))
    end
    
else
    
    for j=1:nPoint(1)
        for i=1:n(1)
            Kv(i,j,:)=Hi{i}^(-1/2)*Kn(Hi{i}^(-1/2)*(X(:,j)-x(:,i)));
            Kf(i,j,:)=H^(-1/2)*Kn(H^(-1/2)*(X(:,j)-x(:,i)));
        end
%         waitbar(j/nPoint(1))
    end
    
end

%==========================================================================
% Cálculos finais das Probabilidades Multiplicando o Kernel de cada
% dimensão (feito até 3 dimensões por causa do estudo de viabilidade dimensional)
%==========================================================================
% close(h)
if nd ==1
    for i = 1:nd;
        KNDv{i}=(1/(n(d)))*sum(Kv');
        KNDf{i}=(1/(n(d)))*sum(Kf');
    end
else
    for i = 1:nd;
        KNDv{i}=(1/(n(d)))*sum(Kv(:,:,i));
        KNDf{i}=(1/(n(d)))*sum(Kf(:,:,i));
    end
end


if nd == 1
    fv=zeros(1,nPoint(1));
    ff=zeros(1,nPoint(1));
    for i=1:nPoint(1)
        fv(i)=KNDv{1}(i);
        ff(i)=KNDf{1}(i);
    end
end

if nd == 2
    fv=zeros(nPoint(1),nPoint(1));
    ff=zeros(nPoint(1),nPoint(1));
    for i=1:nPoint(1)
        for j=1:nPoint(1)
            fv(i,j)=KNDv{1}(i)*KNDv{2}(j);
            ff(i,j)=KNDf{1}(i)*KNDf{2}(j);
        end
    end
end

if nd==3
    fv=zeros(nPoint(1),nPoint(1),nPoint(1));
    ff=zeros(nPoint(1),nPoint(1),nPoint(1));
    for i=1:nPoint(1)
        for j=1:nPoint(1)
            for k=1:nPoint(1)
                fv(i,j,k)=KNDv{1}(i)*KNDv{2}(j)*KNDv{3}(k);
                ff(i,j,k)=KNDf{1}(i)*KNDf{2}(j)*KNDf{3}(k);
            end
        end
    end
    
end

%==========================================================================
% Plots finais
%==========================================================================
if nd==1
    switch type
        case 'variable'
            if fp==1; plot(Xlimit{1},fv); end
            f = fv;
        case 'fix'
            if fp==1; plot(Xlimit{1},ff); end
            f = ff;
        case 'both'
            f = fv;
            if fp==1;
                plot(Xlimit{1},fv)
                subplot(1,2,1); plot(Xlimit{1},ff)
                subplot(1,2,2); plot(Xlimit{1},fv)
            end
        otherwise
            disp('Kernel Bandwidth not selected')
    end
end
if nd==2
    switch type
        case 'variable'
            if fp==1;  surf(Xlimit{1},Xlimit{2},fv); end
            f = fv;
        case 'fix'
            if fp==1; surf(Xlimit{1},Xlimit{2},ff); end
            f = ff;
        case 'both'
            f = fv;
            if fp==1;
                subplot(1,2,1); surf(Xlimit{1},Xlimit{2},ff)
                subplot(1,2,2); surf(Xlimit{1},Xlimit{2},fv)
            end
        otherwise
            disp('Kernel Bandwidth not selected')
    end
end
if nd>=3
    switch type
        case 'variable'
            f = fv;
        case 'fix'
            f = ff;
        case 'both'
            f = fv;
        otherwise
            disp('Kernel Bandwidth not selected')
    end
end
% disp(['[KDE][PDF][OK]']); %display de controle