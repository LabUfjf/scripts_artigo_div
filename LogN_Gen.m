function [sg,bg] = LogN_Gen(sg,bg,n)

sg.logn.n.x = 1000000;
bg.logn.n.x = 1000000;

sg.logn.pdf.x = linspace(0,30,sg.logn.n.x);
bg.logn.pdf.x = linspace(0,30,bg.logn.n.x);

sg.logn.mu = log(2);
bg.logn.mu = log(1);

sg.logn.std = 1.25;
bg.logn.std = 1;

sg.logn.pdf.y = lognpdf(sg.logn.pdf.x,sg.logn.mu,sg.logn.std);
bg.logn.pdf.y = lognpdf(bg.logn.pdf.x,bg.logn.mu,bg.logn.std);

[sg.logn.pdf.x,sg.logn.pdf.y,indsort.sg] = RegionFix2(sg.logn.pdf.x,sg.logn.pdf.y);
[bg.logn.pdf.x,bg.logn.pdf.y,indsort.bg] = RegionFix2(bg.logn.pdf.x,bg.logn.pdf.y);

sg.logn.pdf.y.eq.tail = [lognpdf(sg.logn.pdf.x.eq.tail,sg.logn.mu,sg.logn.std)];
bg.logn.pdf.y.eq.tail = [lognpdf(bg.logn.pdf.x.eq.tail,bg.logn.mu,bg.logn.std)];

sg.logn.pdf.y.eq.head = [lognpdf(sg.logn.pdf.x.eq.head,sg.logn.mu,sg.logn.std)];
bg.logn.pdf.y.eq.head = [lognpdf(bg.logn.pdf.x.eq.head,bg.logn.mu,bg.logn.std)];

sg.logn.pdf.y.eq.deriv = [lognpdf(sg.logn.pdf.x.eq.deriv,sg.logn.mu,sg.logn.std)];
bg.logn.pdf.y.eq.deriv = [lognpdf(bg.logn.pdf.x.eq.deriv,bg.logn.mu,bg.logn.std)];

[sg.logn.pdf.y.eq.all] = [sg.logn.pdf.y.eq.tail sg.logn.pdf.y.eq.deriv sg.logn.pdf.y.eq.head];
[bg.logn.pdf.y.eq.all] = [bg.logn.pdf.y.eq.tail bg.logn.pdf.y.eq.deriv bg.logn.pdf.y.eq.head];

sg.logn.pdf.y.eq.all=sg.logn.pdf.y.eq.all(indsort.sg);
bg.logn.pdf.y.eq.all=bg.logn.pdf.y.eq.all(indsort.bg);






sg.logn.n.evt = n;
bg.logn.n.evt = n;

sg.logn.evt = random('logn',sg.logn.mu,sg.logn.std,1,sg.logn.n.evt);
bg.logn.evt = random('logn',bg.logn.mu,bg.logn.std,1,bg.logn.n.evt);

[sg.logn.hist.x,sg.logn.hist.y] = data_normalized(sg.logn.evt,calcnbins(sg.logn.evt,'fd'));
[bg.logn.hist.x,bg.logn.hist.y] = data_normalized(bg.logn.evt,calcnbins(bg.logn.evt,'fd'));


% sg.logn.evt.tr = random('logn',sg.logn.mu,sg.logn.std,1,sg.logn.n.evt);
% sg.logn.evt.tst = random('logn',sg.logn.mu,sg.logn.std,1,sg.logn.n.evt);
% sg.logn.evt.val = random('logn',sg.logn.mu,sg.logn.std,1,sg.logn.n.evt);
% 
% bg.logn.evt.tr = random('logn',bg.logn.mu,bg.logn.std,1,bg.logn.n.evt);
% bg.logn.evt.tst = random('logn',bg.logn.mu,bg.logn.std,1,bg.logn.n.evt);
% bg.logn.evt.val = random('logn',bg.logn.mu,bg.logn.std,1,bg.logn.n.evt);
% 
% [sg.logn.hist.x,sg.logn.hist.y] = data_normalized(sg.logn.evt.tr,calcnbins(sg.logn.evt.tr,'fd'));
% [bg.logn.hist.x,bg.logn.hist.y] = data_normalized(bg.logn.evt.tr,calcnbins(bg.logn.evt.tr,'fd'));




