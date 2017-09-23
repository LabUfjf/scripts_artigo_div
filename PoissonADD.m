function [pdf] = PoissonADD(yh,N)

% [~,xth]=hist(sg.evt,bin);
% xh = linspace(min(xth),max(xth),bin);
% yh = interp1(sg.pdf.truth.x,sg.pdf.truth.y,xh,'nearest','extrap');
yh = yh/(sum(yh));
yh = yh*(N);

i=0;
for m = yh;
    mN=m;
    i=i+1;
  x = linspace(0,mN*20,10000);
  y = exp(x * log(mN) - mN - gammaln(x+1));
  [out,~] = randfit(x,y,1);
%   pdf2(i)=(out);
  pdf(i)=round(out);    
    
end
% xpdf = xh;
pdf = (pdf/sum(pdf))*N;
% pdf2 = (pdf2/sum(pdf2))*N;

end