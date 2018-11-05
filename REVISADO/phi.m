function [xij,fx]=phi(DADOS)
n=length(DADOS);
for j=1:length(DADOS);
    
    xij = (DADOS(DADOS~=DADOS(j))-DADOS(j))/2;
    [ycdf,xcdf]=ecdf(DADOS);
    [~,ind] = unique(xcdf);
    V = interp1(xcdf(ind),ycdf(ind),xij,'nearest','extrap');
    %                 [~,fx]=KDEfixed((DADOS(DADOS~=DADOS(j))-DADOS(j))',DADOS,h,nPoint,n,nd);
    fx(j)=(1/(n-1))*sum(V);
end

