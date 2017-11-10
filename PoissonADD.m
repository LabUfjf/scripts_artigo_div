function [pdf] = PoissonADD(yh,yfull,N)
[~,ind]=ismember(yh,yfull);
yfull = yfull/(sum(yfull));
yfull = yfull*(N);
yfull(yfull==0) = min(yfull(yfull>0));


out = random('Poisson',(yfull));
pdf=out;

pdf = pdf(ind);

end