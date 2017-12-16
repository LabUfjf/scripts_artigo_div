function [sg,bg] = M_Normal_Gen(sg,bg,N,range_minmax)

sg.n.x = N.PTS;
bg.n.x = N.PTS;

sg.g1.mu = 0;
bg.g1.mu = 0;
sg.g1.std = 0.8;
bg.g1.std = 0.25;

if range_minmax == 1;
    load([pwd '\MINMAX\TEST_MINMAX_PDF[' N.NAME ']'],'Vec');
    sg.pdf.truth.x = linspace(Vec.Min.sg,Vec.Max.sg,sg.n.x);
    bg.pdf.truth.x = linspace(Vec.Min.bg,Vec.Max.bg,bg.n.x);
    [sg.Integral] = PDF_integral(sg,Vec.Min.sg,Vec.Max.sg,'Gaussian');
    [bg.Integral] = PDF_integral(bg,Vec.Min.bg,Vec.Max.bg,'Gaussian');    
else
    sg.pdf.truth.x = linspace(-10,10,sg.n.x);
    bg.pdf.truth.x = linspace(-10,10,bg.n.x);
end

sg.pdf.truth.y = [normpdf(sg.pdf.truth.x,sg.g1.mu,sg.g1.std)];
bg.pdf.truth.y = [normpdf(bg.pdf.truth.x,bg.g1.mu,bg.g1.std)];

% EVENTOS Normal Bimodal
sg.n.evt = N.EVT;
bg.n.evt = N.EVT;

[sg.evt] = sg.g1.mu+sg.g1.std*randn(sg.n.evt,1);
[bg.evt] = bg.g1.mu+bg.g1.std*randn(bg.n.evt,1);



end