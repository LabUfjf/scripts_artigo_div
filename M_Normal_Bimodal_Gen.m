function [sg,bg] = M_Normal_Bimodal_Gen(sg,bg,N,range_minmax)

sg.n.x = N.PTS;
bg.n.x = N.PTS;

sg.g1.mu = 0;
bg.g1.mu = 0;
sg.g1.std = 0.8;
bg.g1.std = 0.25;
sg.g2.mu = -1;
bg.g2.mu = -1;
sg.g2.std = 0.25;
bg.g2.std = 1;

if range_minmax == 1;
    load([pwd '\MINMAX\TEST_MINMAX_PDF[' N.NAME ']'],'Vec');
    sg.pdf.truth.x = linspace(Vec.Min.sg,Vec.Max.sg,sg.n.x);
    bg.pdf.truth.x = linspace(Vec.Min.bg,Vec.Max.bg,bg.n.x);
    [sg.Integral] = PDF_integral(sg,Vec.Min.sg,Vec.Max.sg,'Bimodal');
    [bg.Integral] = PDF_integral(bg,Vec.Min.bg,Vec.Max.bg,'Bimodal');
else
    sg.pdf.truth.x = linspace(-10,10,sg.n.x);
    bg.pdf.truth.x = linspace(-10,10,bg.n.x);
end

sg.pdf.truth.y = [normpdf(sg.pdf.truth.x,sg.g1.mu,sg.g1.std) + normpdf(sg.pdf.truth.x,sg.g2.mu,sg.g2.std)]/2;
bg.pdf.truth.y = [normpdf(bg.pdf.truth.x,bg.g1.mu,bg.g1.std) + normpdf(bg.pdf.truth.x,bg.g2.mu,bg.g2.std)]/2;

% EVENTOS Normal Bimodal
sg.n.evt = N.EVT;
bg.n.evt = N.EVT;

A.sg=sg.g1.mu+sg.g1.std*randn(sg.n.evt,1);
A.bg=bg.g1.mu+bg.g1.std*randn(bg.n.evt,1);

B.sg=sg.g2.mu+sg.g2.std*randn(sg.n.evt,1);
B.bg=bg.g2.mu+bg.g2.std*randn(bg.n.evt,1);

C.sg=[A.sg; B.sg];
C.bg=[A.bg; B.bg];

sg.evt = C.sg(randi(length(C.sg),sg.n.evt,1));
bg.evt = C.bg(randi(length(C.bg),bg.n.evt,1));



end