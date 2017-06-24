function [sg,bg] = Normal_Gen(sg,bg,n)

sg.gauss.n.x = 1000000;
bg.gauss.n.x = 1000000;



% xrange = linspace(-20*sg.gauss.g1.std,20*sg.gauss.g1.std,1000000);
% sg.gauss.pdf.y = normpdf(xrange,sg.gauss.g1.mu,sg.gauss.g1.std);
% h = diff(xrange); h = h(1);
% dy = abs(diff(sg.gauss.pdf.y)/h);
% find(dy<0.0000000001)
% plot(xrange,sg.gauss.pdf.y);


sg.gauss.pdf.x = linspace(-10,10,sg.gauss.n.x);
bg.gauss.pdf.x = linspace(-10,10,bg.gauss.n.x);

sg.gauss.g1.mu = 0;
bg.gauss.g1.mu = 0;

sg.gauss.g1.std = 0.8;
bg.gauss.g1.std = 0.25;

sg.gauss.pdf.y = [normpdf(sg.gauss.pdf.x,sg.gauss.g1.mu,sg.gauss.g1.std)];
bg.gauss.pdf.y = [normpdf(bg.gauss.pdf.x,bg.gauss.g1.mu,bg.gauss.g1.std)];

[sg.gauss.pdf.x,sg.gauss.pdf.y,indsort.sg] = RegionFix2(sg.gauss.pdf.x,sg.gauss.pdf.y);
[bg.gauss.pdf.x,bg.gauss.pdf.y,indsort.bg] = RegionFix2(bg.gauss.pdf.x,bg.gauss.pdf.y);

sg.gauss.pdf.y.eq.tail = [normpdf(sg.gauss.pdf.x.eq.tail,sg.gauss.g1.mu,sg.gauss.g1.std)];
bg.gauss.pdf.y.eq.tail = [normpdf(bg.gauss.pdf.x.eq.tail,bg.gauss.g1.mu,bg.gauss.g1.std)];

sg.gauss.pdf.y.eq.head = [normpdf(sg.gauss.pdf.x.eq.head,sg.gauss.g1.mu,sg.gauss.g1.std)];
bg.gauss.pdf.y.eq.head = [normpdf(bg.gauss.pdf.x.eq.head,bg.gauss.g1.mu,bg.gauss.g1.std)];

sg.gauss.pdf.y.eq.deriv = [normpdf(sg.gauss.pdf.x.eq.deriv,sg.gauss.g1.mu,sg.gauss.g1.std)];
bg.gauss.pdf.y.eq.deriv = [normpdf(bg.gauss.pdf.x.eq.deriv,bg.gauss.g1.mu,bg.gauss.g1.std)];

[sg.gauss.pdf.y.eq.all] = [sg.gauss.pdf.y.eq.tail sg.gauss.pdf.y.eq.deriv sg.gauss.pdf.y.eq.head];
[bg.gauss.pdf.y.eq.all] = [bg.gauss.pdf.y.eq.tail bg.gauss.pdf.y.eq.deriv bg.gauss.pdf.y.eq.head];

sg.gauss.pdf.y.eq.all=sg.gauss.pdf.y.eq.all(indsort.sg);
bg.gauss.pdf.y.eq.all=bg.gauss.pdf.y.eq.all(indsort.bg);

% EVENTOS Normal Bimodal
sg.gauss.n.evt = n;
bg.gauss.n.evt = n;

[sg.gauss.evt,~] = randfit(sg.gauss.pdf.x.all,sg.gauss.pdf.y.all,sg.gauss.n.evt);
[bg.gauss.evt,~] = randfit(bg.gauss.pdf.x.all,bg.gauss.pdf.y.all,bg.gauss.n.evt);

[sg.gauss.hist.x,sg.gauss.hist.y]=data_normalized(sg.gauss.evt,calcnbins(sg.gauss.evt,'fd'));
[bg.gauss.hist.x,bg.gauss.hist.y]=data_normalized(bg.gauss.evt,calcnbins(bg.gauss.evt,'fd'));

cdf
% [sg.gauss.evt.tr,sg.gauss.pdf] = randfit(sg.gauss.x,sg.gauss.y,sg.gauss.n.evt);
% [sg.gauss.evt.tst,sg.gauss.pdf] = randfit(sg.gauss.x,sg.gauss.y,sg.gauss.n.evt);
% [sg.gauss.evt.val,sg.gauss.pdf] = randfit(sg.gauss.x,sg.gauss.y,sg.gauss.n.evt);
% 
% [bg.gauss.evt.tr,bg.gauss.pdf] = randfit(bg.gauss.x,bg.gauss.y,bg.gauss.n.evt);
% [bg.gauss.evt.tst,bg.gauss.pdf] = randfit(bg.gauss.x,bg.gauss.y,bg.gauss.n.evt);
% [bg.gauss.evt.val,bg.gauss.pdf] = randfit(bg.gauss.x,bg.gauss.y,bg.gauss.n.evt);
% 
% [sg.gauss.hist.x,sg.gauss.hist.y]=data_normalized(sg.gauss.evt.tr,calcnbins(sg.gauss.evt.tr,'fd'));
% [bg.gauss.hist.x,bg.gauss.hist.y]=data_normalized(bg.gauss.evt.tr,calcnbins(bg.gauss.evt.tr,'fd'));

end