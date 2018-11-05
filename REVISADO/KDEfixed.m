function [X,ff] = KDEfixed(x,H,nPoint)
[nd,n,x]= format_data(x);
H = ones(1,length(x))*H;
X=linspace(min(x),max(x),nPoint);

if nd==1;
    for j=1:nPoint(1)
        Kf(j,:)=H.^(-1/2).*Kn(H.^(-1/2).*(repmat(X(:,j),1,length(x))-x));
    end
    
else
    
    for j=1:nPoint(1)
        for i=1:n(1)
            Kf(i,j,:)=H.^(-1/2)*Kn(H.^(-1/2)*(X(:,j)-x(:,i)));
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
        KNDf{i}=(1/(n(i)))*sum(Kf');
    end
else
    for i = 1:nd;
        KNDf{i}=(1/(n(i)))*sum(Kf(:,:,i));
    end
end


if nd == 1
    ff=zeros(1,nPoint(1));
    for i=1:nPoint(1)
        ff(i)=KNDf{1}(i);
    end
end

if nd == 2
    ff=zeros(nPoint(1),nPoint(1));
    for i=1:nPoint(1)
        for j=1:nPoint(1)
            ff(i,j)=KNDf{1}(i)*KNDf{2}(j);
        end
    end
end

if nd==3
    ff=zeros(nPoint(1),nPoint(1),nPoint(1));
    for i=1:nPoint(1)
        for j=1:nPoint(1)
            for k=1:nPoint(1)
                ff(i,j,k)=KNDf{1}(i)*KNDf{2}(j)*KNDf{3}(k);
            end
        end
    end    
end

end