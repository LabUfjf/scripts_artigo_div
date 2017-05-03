function [x,y,name] = RegionFix(x,y,setup,name)

[ x,y,ind] = discrRegion( x,y );

nmax = max([length(ind.tail) length(ind.head) length(ind.deriv)]);

if strcmp(setup.xgrid,'linspace');
    x.eq.tail  = linspace(min(x.tail),max(x.tail),nmax);
    x.eq.deriv = linspace(min(x.deriv),max(x.deriv),nmax);
    x.eq.head  = linspace(min(x.head),max(x.head),nmax);
    y.eq.tail  = normpdf(x.eq.tail,setup.mu,setup.std);
    y.eq.deriv = normpdf(x.eq.deriv,setup.mu,setup.std);
    y.eq.head  = normpdf(x.eq.head,setup.mu,setup.std);
    name.tag.eq = 'L';
end
if strcmp(setup.xgrid,'uniforme');
    x.eq.tail  = min(x.tail) + (max(x.tail)-min(x.tail)).*rand(nmax,1)';
    x.eq.deriv = min(x.deriv) + (max(x.deriv)-min(x.deriv)).*rand(nmax,1)';
    x.eq.head  = min(x.head) + (max(x.head)-min(x.head)).*rand(nmax,1)';
    y.eq.tail  = normpdf(x.eq.tail,setup.mu,setup.std);
    y.eq.deriv = normpdf(x.eq.deriv,setup.mu,setup.std);
    y.eq.head  = normpdf(x.eq.head,setup.mu,setup.std);
    name.tag.eq = 'U';
end
end