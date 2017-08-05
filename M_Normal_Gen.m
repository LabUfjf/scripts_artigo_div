function [sg,bg] = M_Normal_Gen(sg,bg,N)

sg.n.x = N.PTS;
bg.n.x = N.PTS;

sg.pdf.truth.x = linspace(-10,10,sg.n.x);
bg.pdf.truth.x = linspace(-10,10,bg.n.x);

sg.g1.mu = 0;
bg.g1.mu = 0;

sg.g1.std = 0.8;
bg.g1.std = 0.25;

sg.pdf.truth.y = [normpdf(sg.pdf.truth.x,sg.g1.mu,sg.g1.std)];
bg.pdf.truth.y = [normpdf(bg.pdf.truth.x,bg.g1.mu,bg.g1.std)];

% EVENTOS Normal Bimodal
sg.n.evt = N.EVT;
bg.n.evt = N.EVT;

[sg.evt,~] = randfit(sg.pdf.truth.x,sg.pdf.truth.y,sg.n.evt);
[bg.evt,~] = randfit(bg.pdf.truth.x,bg.pdf.truth.y,bg.n.evt);

% sg = rmfield(sg,'g1');
% bg = rmfield(bg,'g1');


end