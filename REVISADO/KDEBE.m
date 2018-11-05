function [X,fv] = KDEBE(x,X,hk,nPoint,n,nd)
%==========================================================================
% Fazendo os Cálculos do KERNEL ND de banda Fixa e Variável
%==========================================================================
[~,Hk] = h_adjust([],hk,nd);
% h=waitbar(0','[KDEND]WORKANDO...');
if nd==1;
    Hk=cell2mat(Hk);
    for j=1:nPoint(1)
        Kv(j,:)=Hk(j)^(-1/2)*Kn(Hk(j)^(-1/2)*(repmat(X(j),1,length(x))-x));
    end
else
    for j=1:nPoint(1)
        for i=1:n(1)
            Kv(i,j,:)=Hk{j}^(-1/2)*Kn(Hk{j}^(-1/2)*(X(:,j)-x(:,i)));
        end
    end
end

%==========================================================================
% Cálculos finais das Probabilidades Multiplicando o Kernel de cada
% dimensão (feito até 3 dimensões por causa do estudo de viabilidade dimensional)
%==========================================================================
% close(h)
if nd ==1
    for i = 1:nd;
        KNDv{i}=(1/(n(i)))*sum(Kv');
    end
else
    for i = 1:nd;
        KNDv{i}=(1/(n(i)))*sum(Kv(:,:,i));
    end
end


if nd == 1
    fv=zeros(1,nPoint(1));
    for i=1:nPoint(1)
        fv(i)=KNDv{1}(i);
    end
end

if nd == 2
    fv=zeros(nPoint(1),nPoint(1));
    for i=1:nPoint(1)
        for j=1:nPoint(1)
            fv(i,j)=KNDv{1}(i)*KNDv{2}(j);
        end
    end
end

if nd==3
    fv=zeros(nPoint(1),nPoint(1),nPoint(1));
    for i=1:nPoint(1)
        for j=1:nPoint(1)
            for k=1:nPoint(1)
                fv(i,j,k)=KNDv{1}(i)*KNDv{2}(j)*KNDv{3}(k);
            end
        end
    end
    
end
