function [sg,bg] = M_Rayleigh_Gen(sg,bg,N,range_minmax)

sg.n.x = N.PTS;
bg.n.x = N.PTS;

sg.b = 2;
bg.b = 4;

if range_minmax == 1;
    load([pwd '\MINMAX\TEST_MINMAX_PDF[' N.NAME ']'],'Vec');
    sg.pdf.truth.x = linspace(Vec.Min.sg,Vec.Max.sg,sg.n.x);
    bg.pdf.truth.x = linspace(Vec.Min.bg,Vec.Max.bg,bg.n.x);
    [sg.Integral] = PDF_integral(sg,Vec.Min.sg,Vec.Max.sg,'Rayleigh');
    [bg.Integral] = PDF_integral(bg,Vec.Min.bg,Vec.Max.bg,'Rayleigh');
else
    sg.pdf.truth.x = linspace(0,50,sg.n.x);
    bg.pdf.truth.x = linspace(0,50,bg.n.x);
end



sg.pdf.truth.y = raylpdf(sg.pdf.truth.x,sg.b);
bg.pdf.truth.y = raylpdf(bg.pdf.truth.x,bg.b);

sg.n.evt = N.EVT;
bg.n.evt = N.EVT;

sg.evt = random('Rayleigh',sg.b,1,sg.n.evt);
bg.evt = random('Rayleigh',bg.b,1,bg.n.evt);



end





