function [pdf] = PoissonADD(yh,yfull,N)
[~,ind]= ismember(yh,yfull);
yfull = yfull/(sum(yfull));
yfull = yfull*(N);
yfull(yfull==0) = min(yfull(yfull>0));

outPDF = random('Poisson',(yfull));
out = outPDF(ind);

pdf=out;



end