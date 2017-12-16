function [sg,bg] = M_Gamma_Gen(sg,bg,N,range_minmax)

sg.n.x = N.PTS;
bg.n.x = N.PTS;

sg.A = 5;
bg.A = 5;
sg.B = 0.5;
bg.B = 0.4;

if range_minmax == 1;
    load([pwd '\MINMAX\TEST_MINMAX_PDF[' N.NAME ']'],'Vec');
    sg.pdf.truth.x = linspace(Vec.Min.sg,Vec.Max.sg,sg.n.x);
    bg.pdf.truth.x = linspace(Vec.Min.bg,Vec.Max.bg,bg.n.x);
    [sg.Integral] = PDF_integral(sg,Vec.Min.sg,Vec.Max.sg,'Gamma');
    [bg.Integral] = PDF_integral(bg,Vec.Min.bg,Vec.Max.bg,'Gamma');
else
    sg.pdf.truth.x = linspace(0,50,sg.n.x);
    bg.pdf.truth.x = linspace(0,50,bg.n.x);
end

sg.pdf.truth.y = gampdf(sg.pdf.truth.x,sg.A,sg.B);
bg.pdf.truth.y = gampdf(bg.pdf.truth.x,bg.A,bg.B);

sg.n.evt = N.EVT;
bg.n.evt = N.EVT;

sg.evt = gamrnd(sg.A,sg.B,1,sg.n.evt);
bg.evt = gamrnd(bg.A,bg.B,1,bg.n.evt);



end





