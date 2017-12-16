function [sg,bg] = M_Uniforme_Gen(sg,bg,N,range_minmax)
sg.n.x = N.PTS;
bg.n.x = N.PTS;

sg.g1.i = -2;
bg.g1.i = -1;
sg.g1.s = 2;
bg.g1.s = 3;

if range_minmax == 1;
    load([pwd '\MINMAX\TEST_MINMAX_PDF[' N.NAME ']'],'Vec');
    sg.pdf.truth.x = linspace(Vec.Min.sg,Vec.Max.sg,sg.n.x);
    bg.pdf.truth.x = linspace(Vec.Min.bg,Vec.Max.bg,bg.n.x);
    [sg.Integral] = PDF_integral(sg,Vec.Min.sg,Vec.Max.sg,'Uniform');
    [bg.Integral] = PDF_integral(bg,Vec.Min.bg,Vec.Max.bg,'Uniform');
else
    sg.pdf.truth.x = linspace(-5,5,sg.n.x);
    bg.pdf.truth.x = linspace(-5,5,bg.n.x);
end

sg.pdf.truth.y = pdf(makedist('Uniform','lower',sg.g1.i,'upper',sg.g1.s),sg.pdf.truth.x);
bg.pdf.truth.y = pdf(makedist('Uniform','lower',bg.g1.i,'upper',bg.g1.s),bg.pdf.truth.x);

% EVENTOS Normal Bimodal
sg.n.evt = N.EVT;
bg.n.evt = N.EVT;

[sg.evt] = (sg.g1.s-sg.g1.i).*rand(sg.n.evt,1) + sg.g1.i;
[bg.evt] = (bg.g1.s-bg.g1.i).*rand(bg.n.evt,1) + bg.g1.i;


end