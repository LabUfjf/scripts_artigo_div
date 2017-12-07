function [sg,bg] = M_Uniforme_Gen(sg,bg,N)

sg.n.x = N.PTS;
bg.n.x = N.PTS;

% load(['TEST_MINMAX_PDF[' N.NAME ']'],'Vec');
% sg.pdf.truth.x = linspace(mean(Vec.Min.sg),mean(Vec.Max.sg),sg.n.x);
% bg.pdf.truth.x = linspace(mean(Vec.Min.bg),mean(Vec.Max.bg),bg.n.x);

% load(['TEST_MINMAX_PDF[' N.NAME ']'],'Vec');
sg.pdf.truth.x = linspace(-5,5,sg.n.x);
bg.pdf.truth.x = linspace(-5,5,bg.n.x);

sg.g1.i = -2;
bg.g1.i = -1;

sg.g1.s = 2;
bg.g1.s = 3;


sg.pdf.truth.y = pdf(makedist('Uniform','lower',sg.g1.i,'upper',sg.g1.s),sg.pdf.truth.x);
bg.pdf.truth.y = pdf(makedist('Uniform','lower',bg.g1.i,'upper',bg.g1.s),bg.pdf.truth.x);

% EVENTOS Normal Bimodal
sg.n.evt = N.EVT;
bg.n.evt = N.EVT;

[sg.evt] = (sg.g1.s-sg.g1.i).*rand(sg.n.evt,1) + sg.g1.i;
[bg.evt] = (bg.g1.s-bg.g1.i).*rand(bg.n.evt,1) + bg.g1.i;
% [sg.evt,~] = randfit_old(sg.pdf.truth.x,sg.pdf.truth.y,sg.n.evt);
% [bg.evt,~] = randfit_old(bg.pdf.truth.x,bg.pdf.truth.y,bg.n.evt);

% sg = rmfield(sg,'g1');
% bg = rmfield(bg,'g1');


end