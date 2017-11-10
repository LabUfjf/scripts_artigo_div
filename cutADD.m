function [noise,sinal,x] = cutADD(xfull,yfull,xRoI,noise)

x.dy = [xRoI.dy xfull.dy];
x.py = [xRoI.py xfull.py];
x.eq.dy = [xRoI.eq.dy xfull.eq.dy];
x.eq.py = [xRoI.eq.py xfull.eq.py];

y.dy = [noise.dy yfull.dy];
y.py = [noise.py yfull.py];
y.eq.dy = [noise.eq.dy yfull.eq.dy];
y.eq.py = [noise.eq.py yfull.eq.py];

[~,ind.dy]=unique(x.dy);
[~,ind.py]=unique(x.py);
[~,ind.eq.dy]=unique(x.eq.dy);
[~,ind.eq.py]=unique(x.eq.py);

ind.dy=ind.dy(ind.dy~=0);
ind.py=ind.py(ind.py~=0);
ind.eq.dy=ind.eq.dy(ind.eq.dy~=0);
ind.eq.py=ind.eq.py(ind.eq.py~=0);

x.dy = x.dy(ind.dy);
x.py = x.py(ind.py);
x.eq.dy = x.eq.dy(ind.eq.dy);
x.eq.py = x.eq.py(ind.eq.py);

noise.dy = y.dy(ind.dy);
noise.py = y.py(ind.py);
noise.eq.dy = y.eq.dy(ind.eq.dy);
noise.eq.py = y.eq.py(ind.eq.py);

% plot(x.dy,noise.dy,'.')
% pause

noise.dy = interp1(x.dy,noise.dy,xfull.dy,'nearest');
noise.py = interp1(x.py,noise.py,xfull.py,'nearest');
noise.eq.dy = interp1(x.eq.dy,noise.eq.dy,xfull.eq.dy,'nearest');
noise.eq.py = interp1(x.eq.py,noise.eq.py,xfull.eq.py,'nearest');

sinal = yfull;

end