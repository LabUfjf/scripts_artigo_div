function [sg,bg] = Gamma_Gen(sg,bg,n)

sg.gamma.n.x = 1000000;
bg.gamma.n.x = 1000000;

sg.gamma.pdf.x = linspace(0,10,sg.gamma.n.x);
bg.gamma.pdf.x = linspace(0,10,bg.gamma.n.x);

sg.gamma.A = 5;
bg.gamma.A = 5;

sg.gamma.B = 0.5;
bg.gamma.B = 0.4;

sg.gamma.pdf.y = gampdf(sg.gamma.pdf.x,sg.gamma.A,sg.gamma.B);
bg.gamma.pdf.y = gampdf(bg.gamma.pdf.x,bg.gamma.A,bg.gamma.B);

[sg.gamma.pdf.x,sg.gamma.pdf.y,indsort.sg] = RegionFix2(sg.gamma.pdf.x,sg.gamma.pdf.y);
[bg.gamma.pdf.x,bg.gamma.pdf.y,indsort.bg] = RegionFix2(bg.gamma.pdf.x,bg.gamma.pdf.y);

sg.gamma.pdf.y.eq.tail = [gampdf(sg.gamma.pdf.x.eq.tail,sg.gamma.A,sg.gamma.B)];
bg.gamma.pdf.y.eq.tail = [gampdf(bg.gamma.pdf.x.eq.tail,bg.gamma.A,bg.gamma.B)];

sg.gamma.pdf.y.eq.head = [gampdf(sg.gamma.pdf.x.eq.head,sg.gamma.A,sg.gamma.B)];
bg.gamma.pdf.y.eq.head = [gampdf(bg.gamma.pdf.x.eq.head,bg.gamma.A,bg.gamma.B)];

sg.gamma.pdf.y.eq.deriv = [gampdf(sg.gamma.pdf.x.eq.deriv,sg.gamma.A,sg.gamma.B)];
bg.gamma.pdf.y.eq.deriv = [gampdf(bg.gamma.pdf.x.eq.deriv,bg.gamma.A,bg.gamma.B)];

[sg.gamma.pdf.y.eq.all] = [sg.gamma.pdf.y.eq.tail sg.gamma.pdf.y.eq.deriv sg.gamma.pdf.y.eq.head];
[bg.gamma.pdf.y.eq.all] = [bg.gamma.pdf.y.eq.tail bg.gamma.pdf.y.eq.deriv bg.gamma.pdf.y.eq.head];

sg.gamma.pdf.y.eq.all=sg.gamma.pdf.y.eq.all(indsort.sg);
bg.gamma.pdf.y.eq.all=bg.gamma.pdf.y.eq.all(indsort.bg);



sg.gamma.n.evt = n;
bg.gamma.n.evt = n;

sg.gamma.evt = gamrnd(sg.gamma.A,sg.gamma.B,1,sg.gamma.n.evt);
bg.gamma.evt = gamrnd(bg.gamma.A,bg.gamma.B,1,bg.gamma.n.evt);

[sg.gamma.hist.x,sg.gamma.hist.y] = data_normalized(sg.gamma.evt,calcnbins(sg.gamma.evt,'fd'));
[bg.gamma.hist.x,bg.gamma.hist.y] = data_normalized(bg.gamma.evt,calcnbins(bg.gamma.evt,'fd'));

% sg.gamma.evt.tr = gamrnd(sg.gamma.A,sg.gamma.B,1,sg.gamma.n.evt);
% sg.gamma.evt.tst = gamrnd(sg.gamma.A,sg.gamma.B,1,sg.gamma.n.evt);
% sg.gamma.evt.val = gamrnd(sg.gamma.A,sg.gamma.B,1,sg.gamma.n.evt);
% 
% bg.gamma.evt.tr = gamrnd(bg.gamma.A,bg.gamma.B,1,bg.gamma.n.evt);
% bg.gamma.evt.tst = gamrnd(bg.gamma.A,bg.gamma.B,1,bg.gamma.n.evt);
% bg.gamma.evt.val = gamrnd(bg.gamma.A,bg.gamma.B,1,bg.gamma.n.evt);
% 
% [sg.gamma.hist.x,sg.gamma.hist.y] = data_normalized(sg.gamma.evt.tr,calcnbins(sg.gamma.evt.tr,'fd'));
% [bg.gamma.hist.x,bg.gamma.hist.y] = data_normalized(bg.gamma.evt.tr,calcnbins(bg.gamma.evt.tr,'fd'));





