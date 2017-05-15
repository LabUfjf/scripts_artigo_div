
xrange = linspace(-50*sg.gauss.g1.std,50*sg.gauss.g1.std,1000000);

% yrange= normpdf(xrange,sg.gauss.g1.mu,sg.gauss.g1.std);
% yrange = [normpdf(xrange,sg.normal.g1.mu,sg.normal.g1.std) + normpdf(xrange,sg.normal.g2.mu,sg.normal.g2.std)]/2;
yrange  = raylpdf(xrange,sg.rayleigh.b);
% yrange = lognpdf(xrange,sg.logn.mu,sg.logn.std);
% yrange  = gampdf(xrange,sg.gamma.A,sg.gamma.B);

h = diff(xrange); h = h(1);

dy = abs(diff(yrange)/h);

dyn = abs(diff(yrange)/h)/max(abs(diff(yrange)/h));
py = yrange/max(yrange);

figure
plot(dy); hold on
plot(dyn);
plot(xrange,py); hold on
plot(xrange(ind.py),py(ind.py),'.')

TH = 1e-5;
ind.dy = find(dy<TH);
ind.dyn = find(dyn<TH);
ind.py = find(py<TH);

R.py = [xrange(1) -abs(xrange(find(diff(ind.py)>2)))]; V.py = [R.py fliplr(abs(R.py))];
R.dyn = [xrange(1) -abs(xrange(find(diff(ind.dyn)>2)))]; V.dyn = [R.dyn fliplr(abs(R.dyn))];
R.dy = [xrange(1) -abs(xrange(find(diff(ind.dy)>2)))]; V.dy = [R.dy fliplr(abs(R.dy))];
/;
Range.py = reshape(V.py,2,length(V.py)/2)';
Range.dyn = reshape(V.dyn,2,length(V.dyn)/2)';
Range.dy = reshape(V.dy,2,length(V.dy)/2)';

le.py=Range.py(1,2);
ld.py=Range.py(end,1);

le.dyn=Range.dyn(1,2);
ld.dyn=Range.dyn(end,1);

le.dy=Range.dy(1,2);
ld.dy=Range.dy(end,1);

figure
plot(xrange,yrange,'-k','DisplayName','PDF'); hold on
plot(le.dy,0,'*r',ld.dy,0,'*r','DisplayName','Diff')
plot(le.dyn,0,'*g',ld.dyn,0,'*g','DisplayName','Normalized Diff')
plot(le.py,0,'ob',ld.py,0,'ob','DisplayName','Probability')

legend show


