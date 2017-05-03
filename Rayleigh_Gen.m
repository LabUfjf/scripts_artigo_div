function [sg,bg] = Rayleigh_Gen(sg,bg,n)

sg.rayleigh.n.x = 1000000;
bg.rayleigh.n.x = 1000000;

sg.rayleigh.pdf.x = linspace(0,13,sg.rayleigh.n.x);
bg.rayleigh.pdf.x = linspace(0,20,bg.rayleigh.n.x);

sg.rayleigh.b = 2;
bg.rayleigh.b = 4;

sg.rayleigh.pdf.y = raylpdf(sg.rayleigh.pdf.x,sg.rayleigh.b);
bg.rayleigh.pdf.y = raylpdf(bg.rayleigh.pdf.x,bg.rayleigh.b);

[sg.rayleigh.pdf.x,sg.rayleigh.pdf.y,indsort.sg] = RegionFix2(sg.rayleigh.pdf.x,sg.rayleigh.pdf.y);
[bg.rayleigh.pdf.x,bg.rayleigh.pdf.y,indsort.bg] = RegionFix2(bg.rayleigh.pdf.x,bg.rayleigh.pdf.y);

sg.rayleigh.pdf.y.eq.tail = [raylpdf(sg.rayleigh.pdf.x.eq.tail,sg.rayleigh.b)];
bg.rayleigh.pdf.y.eq.tail = [raylpdf(bg.rayleigh.pdf.x.eq.tail,bg.rayleigh.b)];

sg.rayleigh.pdf.y.eq.head = [raylpdf(sg.rayleigh.pdf.x.eq.head,sg.rayleigh.b)];
bg.rayleigh.pdf.y.eq.head = [raylpdf(bg.rayleigh.pdf.x.eq.head,bg.rayleigh.b)];

sg.rayleigh.pdf.y.eq.deriv = [raylpdf(sg.rayleigh.pdf.x.eq.deriv,sg.rayleigh.b)];
bg.rayleigh.pdf.y.eq.deriv = [raylpdf(bg.rayleigh.pdf.x.eq.deriv,bg.rayleigh.b)];

[sg.rayleigh.pdf.y.eq.all] = [sg.rayleigh.pdf.y.eq.tail sg.rayleigh.pdf.y.eq.deriv sg.rayleigh.pdf.y.eq.head];
[bg.rayleigh.pdf.y.eq.all] = [bg.rayleigh.pdf.y.eq.tail bg.rayleigh.pdf.y.eq.deriv bg.rayleigh.pdf.y.eq.head];

sg.rayleigh.pdf.y.eq.all=sg.rayleigh.pdf.y.eq.all(indsort.sg);
bg.rayleigh.pdf.y.eq.all=bg.rayleigh.pdf.y.eq.all(indsort.bg);

sg.rayleigh.n.evt = n;
bg.rayleigh.n.evt = n;

sg.rayleigh.evt = random('Rayleigh',sg.rayleigh.b,1,sg.rayleigh.n.evt);
bg.rayleigh.evt = random('Rayleigh',bg.rayleigh.b,1,bg.rayleigh.n.evt);

[sg.rayleigh.hist.x,sg.rayleigh.hist.y] = data_normalized(sg.rayleigh.evt,calcnbins(sg.rayleigh.evt,'fd'));
[bg.rayleigh.hist.x,bg.rayleigh.hist.y] = data_normalized(bg.rayleigh.evt,calcnbins(bg.rayleigh.evt,'fd'));

% sg.rayleigh.evt.tr = random('Rayleigh',sg.rayleigh.b,1,sg.rayleigh.n.evt);
% sg.rayleigh.evt.tst = random('Rayleigh',sg.rayleigh.b,1,sg.rayleigh.n.evt);
% sg.rayleigh.evt.val = random('Rayleigh',sg.rayleigh.b,1,sg.rayleigh.n.evt);
% 
% bg.rayleigh.evt.tr = random('Rayleigh',bg.rayleigh.b,1,bg.rayleigh.n.evt);
% bg.rayleigh.evt.tst = random('Rayleigh',bg.rayleigh.b,1,bg.rayleigh.n.evt);
% bg.rayleigh.evt.val = random('Rayleigh',bg.rayleigh.b,1,bg.rayleigh.n.evt);
% 
% [sg.rayleigh.hist.x,sg.rayleigh.hist.y] = data_normalized(sg.rayleigh.evt.tr,calcnbins(sg.rayleigh.evt.tr,'fd'));
% [bg.rayleigh.hist.x,bg.rayleigh.hist.y] = data_normalized(bg.rayleigh.evt.tr,calcnbins(bg.rayleigh.evt.tr,'fd'));





