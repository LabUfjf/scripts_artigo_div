function [xlimit,A] = cdfdata(sg,name,TH,ngrid)
[cdf,x]=ecdf(sg.evt);
% plot(x,cdf)
% pause
[~,ind] = unique(x);
TH = TH/2;
xlimit(1) = interp1(cdf(ind),x(ind),TH,'linear','extrap');
xlimit(2) = interp1(cdf(ind),x(ind),1-TH,'linear','extrap');

xest=linspace(xlimit(1),xlimit(2),ngrid);
yest = GridNew(sg,xest,name);
A=rsum(xest,yest,'mid',sg,name,0);
end
