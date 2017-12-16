function [sg,bg] = M_LogN_Gen(sg,bg,N,range_minmax)

sg.n.x = N.PTS;
bg.n.x = N.PTS;

sg.mu = log(2);
bg.mu = log(1);
sg.std = 1.25;
bg.std = 1;

if range_minmax == 1;
    load([pwd '\MINMAX\TEST_MINMAX_PDF[' N.NAME ']'],'Vec');
    sg.pdf.truth.x = linspace(Vec.Min.sg,Vec.Max.sg,sg.n.x);
    bg.pdf.truth.x = linspace(Vec.Min.bg,Vec.Max.bg,bg.n.x);
    [sg.Integral] = PDF_integral(sg,Vec.Min.sg,Vec.Max.sg,'Logn');
    [bg.Integral] = PDF_integral(bg,Vec.Min.bg,Vec.Max.bg,'Logn');
else
    sg.pdf.truth.x = linspace(0,300,sg.n.x);
    bg.pdf.truth.x = linspace(0,300,bg.n.x);
end

sg.pdf.truth.y = lognpdf(sg.pdf.truth.x,sg.mu,sg.std);
bg.pdf.truth.y = lognpdf(bg.pdf.truth.x,bg.mu,bg.std);

sg.n.evt = N.EVT;
bg.n.evt = N.EVT;

sg.evt = random('logn',sg.mu,sg.std,1,sg.n.evt);
bg.evt = random('logn',bg.mu,bg.std,1,bg.n.evt);



end



