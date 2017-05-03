function [x,y,i] = RegionFix2(x,y)

[ x,y] = discrRegion( x,y );

nmax = 400000;

tail.e=abs([abs(min(x.tail))-abs(min(x.deriv))]);
tail.d=abs([abs(max(x.deriv))-abs(max(x.tail))]);
tail.t= tail.e+tail.d; 
tail.ne=round((tail.e/tail.t)*nmax);
tail.nd=nmax-tail.ne;

deriv.e=abs([abs(min(x.deriv))-abs(min(x.head))]);
deriv.d=abs([abs(max(x.head))-abs(max(x.deriv))]);
deriv.t= deriv.e+deriv.d; 
deriv.ne=round((deriv.e/deriv.t)*nmax);
deriv.nd=nmax-deriv.ne;

x.eq.tail  = [linspace(min(x.tail),min(x.deriv),tail.ne) linspace(max(x.deriv),max(x.tail),tail.nd)];
x.eq.deriv = [linspace(min(x.deriv),min(x.head),deriv.ne) linspace(max(x.head),max(x.deriv),deriv.nd)];

x.eq.head  = linspace(min(x.head),max(x.head),nmax);
[x.eq.all,i] = sort([x.eq.tail x.eq.deriv x.eq.head]);

end