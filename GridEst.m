function [xrange,d] = GridEst(setup,xpdf,ypdf,ireg,type,pts)

TH = linspace(0,1,setup.DIV+1);
if strcmp(type,'deriv')
    h = diff(xpdf); h = h(1);
    REF = diff(ypdf)/h;
    REF = abs(REF/max(abs(REF)));
end
if strcmp(type,'prob')
    REF = abs(ypdf/max(ypdf));
end

ind = find(REF>TH(ireg) & REF<=TH(ireg+1));
x = xpdf(ind);
y = ypdf(ind);
Z=zeros(1,length(xpdf));
Z(ind)=1;
j=find(diff([0 Z 0]));
j(2:2:end)=j(2:2:end)-1;
INT=setdiff(1:length(j),[find(diff(j)<1) find(diff(j)<1)+1]);
I= [j(INT)];
I=I(setdiff(1:length(I),[find(diff(I)<3) find(diff(I)<3)+1]));
xd = diff(xpdf(reshape(I,2,length(I)/2)));
f = xd/sum(xd);

N = ceil(pts*f);
N(find(N==1)) = N(find(N==1))+1;
N(find(N==max(N)))=N((find(N==max(N))))-(sum(N)-pts);
Irange = reshape(I,2,length(I)/2)';
xrange = [];

for nr = 1:size(Irange,1)
    xrange = [xrange linspace(xpdf(Irange(nr,1)),xpdf(Irange(nr,2)),N(nr))];    
    Isec = Irange(nr,1):Irange(nr,2);
    d(nr)=sum(sqrt(diff(xpdf(Isec)).^2+diff(ypdf(Isec)).^2));
%     d(nr)=norm(abs(xpdf(Irange(nr,1))-xpdf(Irange(nr,2))),abs(ypdf(Irange(nr,1))-ypdf(Irange(nr,2)))^2);
end

d =sum(abs(d));


