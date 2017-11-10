function [pdf] = PoissonADD_old(yh,yfull,N)
format long
[~,ind]=ismember(yh,yfull);
yfull = yfull/(sum(yfull));
yfull = yfull*(N);


yfull(yfull==0) = min(yfull(yfull>0));

M = max(yfull);
ngrid = 20000;
X=repmat(linspace(0,2*M,ngrid),length(yfull),1)';
Y = exp(X.*repmat(log(yfull),ngrid,1) - repmat(yfull,ngrid,1) - gammaln(X+1)); 

for i = 1:length(yfull);
    [out,~] = randfit(X(:,i),Y(:,i));
    pdf(i)=out; 
end

pdf = (pdf/sum(pdf))*N;
pdf = pdf(ind);

end