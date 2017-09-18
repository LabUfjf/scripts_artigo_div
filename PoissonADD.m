function [xpdf,pdf,pdf2,xh,yh] = PoissonADD(sg,N,bin)


i=0;
[~,xth]=hist(sg.evt,bin);
xh = linspace(min(xth),max(xth),bin);
yh = interp1(sg.pdf.truth.x,sg.pdf.truth.y,xh,'nearest','extrap');
yh = yh/(sum(yh));
yh = yh*(N);
% yh = round(yh);

for m = yh;
    mN=m;
    i=i+1;
  x = linspace(0,mN*10,5000);
%  pdf(i) = poissrnd(mN,1,1);
  y = exp(x * log(mN) - mN - gammaln(x+1));
%   plot(x,y,'.'); hold on
%   pause
  [out,~] = randfit(x,y,1);
  pdf2(i)=round(out);    
    pdf(i)=(out); 
end
% figure
% plot(pdf,'r')
pdf = (pdf/sum(pdf))*N;
% hold on
% plot(pdf,'k')
% pause
xpdf = xh;
end