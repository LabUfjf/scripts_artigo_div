function [sg,bg] = Normal_Bimodal_Gen(sg,bg,n)

sg.normal.n.x = 1000000;
bg.normal.n.x = 1000000;

sg.normal.pdf.x = linspace(-3,3,sg.normal.n.x);
bg.normal.pdf.x = linspace(-3,4,bg.normal.n.x);

sg.normal.g1.mu = 0;
bg.normal.g1.mu = 0;

sg.normal.g1.std = 0.8;
bg.normal.g1.std = 0.25;

sg.normal.g2.mu = -1;
bg.normal.g2.mu = -1;

sg.normal.g2.std = 0.25;
bg.normal.g2.std = 1;

sg.normal.pdf.y = [normpdf(sg.normal.pdf.x,sg.normal.g1.mu,sg.normal.g1.std) + normpdf(sg.normal.pdf.x,sg.normal.g2.mu,sg.normal.g2.std)]/2;
bg.normal.pdf.y = [normpdf(bg.normal.pdf.x,bg.normal.g1.mu,bg.normal.g1.std) + normpdf(bg.normal.pdf.x,bg.normal.g2.mu,bg.normal.g2.std)]/2;

[sg.normal.pdf.x,sg.normal.pdf.y,indsort.sg] = RegionFix2(sg.normal.pdf.x,sg.normal.pdf.y);
[bg.normal.pdf.x,bg.normal.pdf.y,indsort.bg] = RegionFix2(bg.normal.pdf.x,bg.normal.pdf.y);

sg.normal.pdf.y.eq.tail = [normpdf(sg.normal.pdf.x.eq.tail,sg.normal.g1.mu,sg.normal.g1.std) + normpdf(sg.normal.pdf.x.eq.tail,sg.normal.g2.mu,sg.normal.g2.std)]/2;
bg.normal.pdf.y.eq.tail = [normpdf(bg.normal.pdf.x.eq.tail,bg.normal.g1.mu,bg.normal.g1.std) + normpdf(bg.normal.pdf.x.eq.tail,bg.normal.g2.mu,bg.normal.g2.std)]/2;

sg.normal.pdf.y.eq.head = [normpdf(sg.normal.pdf.x.eq.head,sg.normal.g1.mu,sg.normal.g1.std) + normpdf(sg.normal.pdf.x.eq.head,sg.normal.g2.mu,sg.normal.g2.std)]/2;
bg.normal.pdf.y.eq.head = [normpdf(bg.normal.pdf.x.eq.head,bg.normal.g1.mu,bg.normal.g1.std) + normpdf(bg.normal.pdf.x.eq.head,bg.normal.g2.mu,bg.normal.g2.std)]/2;

sg.normal.pdf.y.eq.deriv = [normpdf(sg.normal.pdf.x.eq.deriv,sg.normal.g1.mu,sg.normal.g1.std) + normpdf(sg.normal.pdf.x.eq.deriv,sg.normal.g2.mu,sg.normal.g2.std)]/2;
bg.normal.pdf.y.eq.deriv = [normpdf(bg.normal.pdf.x.eq.deriv,bg.normal.g1.mu,bg.normal.g1.std) + normpdf(bg.normal.pdf.x.eq.deriv,bg.normal.g2.mu,bg.normal.g2.std)]/2;

% sg.normal.pdf.y.eq.all = [normpdf(sg.normal.pdf.x.eq.all,sg.normal.g1.mu,sg.normal.g1.std) + normpdf(sg.normal.pdf.x.eq.all,sg.normal.g2.mu,sg.normal.g2.std)]/2;
% bg.normal.pdf.y.eq.all = [normpdf(bg.normal.pdf.x.eq.all,bg.normal.g1.mu,bg.normal.g1.std) + normpdf(bg.normal.pdf.x.eq.all,bg.normal.g2.mu,bg.normal.g2.std)]/2;

sg.normal.pdf.y.eq.all = [sg.normal.pdf.y.eq.tail sg.normal.pdf.y.eq.deriv sg.normal.pdf.y.eq.head];
bg.normal.pdf.y.eq.all = [bg.normal.pdf.y.eq.tail bg.normal.pdf.y.eq.deriv bg.normal.pdf.y.eq.head];

sg.normal.pdf.y.eq.all=sg.normal.pdf.y.eq.all(indsort.sg);
bg.normal.pdf.y.eq.all=bg.normal.pdf.y.eq.all(indsort.bg);

% EVENTOS Normal Bimodal
sg.normal.n.evt = n;
bg.normal.n.evt = n;

[sg.normal.evt,~] = randfit(sg.normal.pdf.x.all,sg.normal.pdf.y.all,sg.normal.n.evt);
[bg.normal.evt,~] = randfit(bg.normal.pdf.x.all,bg.normal.pdf.y.all,bg.normal.n.evt);

[sg.normal.hist.x,sg.normal.hist.y]=data_normalized(sg.normal.evt,calcnbins(sg.normal.evt,'fd'));
[bg.normal.hist.x,bg.normal.hist.y]=data_normalized(bg.normal.evt,calcnbins(bg.normal.evt,'fd'));


% [sg.normal.evt.tr,sg.normal.pdf] = randfit(sg.normal.x,sg.normal.y,sg.normal.n.evt);
% [sg.normal.evt.tst,sg.normal.pdf] = randfit(sg.normal.x,sg.normal.y,sg.normal.n.evt);
% [sg.normal.evt.val,sg.normal.pdf] = randfit(sg.normal.x,sg.normal.y,sg.normal.n.evt);
% 
% [bg.normal.evt.tr,bg.normal.pdf] = randfit(bg.normal.x,bg.normal.y,bg.normal.n.evt);
% [bg.normal.evt.tst,bg.normal.pdf] = randfit(bg.normal.x,bg.normal.y,bg.normal.n.evt);
% [bg.normal.evt.val,bg.normal.pdf] = randfit(bg.normal.x,bg.normal.y,bg.normal.n.evt);
% 
% [sg.normal.hist.x,sg.normal.hist.y]=data_normalized(sg.normal.evt.tr,calcnbins(sg.normal.evt.tr,'fd'));
% [bg.normal.hist.x,bg.normal.hist.y]=data_normalized(bg.normal.evt.tr,calcnbins(bg.normal.evt.tr,'fd'));

end