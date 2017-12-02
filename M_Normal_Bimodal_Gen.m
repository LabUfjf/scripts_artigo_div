function [sg,bg] = M_Normal_Bimodal_Gen(sg,bg,N)

sg.n.x = N.PTS;
bg.n.x = N.PTS;

load(['TEST_MINMAX_PDF[' N.NAME ']'],'Vec');

sg.pdf.truth.x = linspace(mean(Vec.Min.sg),mean(Vec.Max.sg),sg.n.x);
bg.pdf.truth.x = linspace(mean(Vec.Min.bg),mean(Vec.Max.bg),bg.n.x);

sg.g1.mu = 0;
bg.g1.mu = 0;

sg.g1.std = 0.8;
bg.g1.std = 0.25;

sg.g2.mu = -1;
bg.g2.mu = -1;

sg.g2.std = 0.25;
bg.g2.std = 1;

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
% [sg.evt,~] = randfit_old(sg.pdf.truth.x,sg.pdf.truth.y,sg.n.evt);
% [bg.evt,~] = randfit_old(bg.pdf.truth.x,bg.pdf.truth.y,bg.n.evt);

% sg = rmfield(sg,'g1');
% bg = rmfield(bg,'g1');
% 
% sg = rmfield(sg,'g2');
% bg = rmfield(bg,'g2');

end