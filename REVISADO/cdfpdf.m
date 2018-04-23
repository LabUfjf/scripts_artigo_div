function [xlimit,A] = cdfpdf(sg,name,TH,ngrid)

Mi = min(sg.pdf.truth.x);
Ma= max(sg.pdf.truth.x);
xest=linspace(Mi,Ma,ngrid);
[ycdf,ind] = make_cdf(sg,xest,name);

TH = TH/2;
xlimit(1) = interp1(ycdf(ind),xest(ind),TH,'linear','extrap');
xlimit(2) = interp1(ycdf(ind),xest(ind),1-TH,'linear','extrap');

xest=linspace(xlimit(1),xlimit(2),ngrid);
yest = GridNew(sg,xest,name);
A=rsum(xest,yest,'mid',sg,name,0);

end