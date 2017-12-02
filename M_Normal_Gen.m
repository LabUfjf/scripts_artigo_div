function [sg,bg] = M_Normal_Gen(sg,bg,N)

sg.n.x = N.PTS;
bg.n.x = N.PTS;

load(['TEST_MINMAX_PDF[' N.NAME ']'],'Vec');

sg.pdf.truth.x = linspace(mean(Vec.Min.sg),mean(Vec.Max.sg),sg.n.x);
bg.pdf.truth.x = linspace(mean(Vec.Min.bg),mean(Vec.Max.bg),bg.n.x);

sg.g1.mu = 0;
bg.g1.mu = 0;

sg.g1.std = 0.8;
bg.g1.std = 0.25;

sg.pdf.truth.y = [normpdf(sg.pdf.truth.x,sg.g1.mu,sg.g1.std)];
bg.pdf.truth.y = [normpdf(bg.pdf.truth.x,bg.g1.mu,bg.g1.std)];

% EVENTOS Normal Bimodal
sg.n.evt = N.EVT;
bg.n.evt = N.EVT;

[sg.evt] = sg.g1.mu+sg.g1.std*randn(sg.n.evt,1);
[bg.evt] = bg.g1.mu+bg.g1.std*randn(bg.n.evt,1);
% [sg.evt,~] = randfit_old(sg.pdf.truth.x,sg.pdf.truth.y,sg.n.evt);
% [bg.evt,~] = randfit_old(bg.pdf.truth.x,bg.pdf.truth.y,bg.n.evt);

% sg = rmfield(sg,'g1');
% bg = rmfield(bg,'g1');


end