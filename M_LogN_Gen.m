function [sg,bg] = M_LogN_Gen(sg,bg,N)

sg.n.x = N.PTS;
bg.n.x = N.PTS;

sg.pdf.truth.x = linspace(0,50,sg.n.x);
bg.pdf.truth.x = linspace(0,50,bg.n.x);

sg.mu = log(2);
bg.mu = log(1);

sg.std = 1.25;
bg.std = 1;

sg.pdf.truth.y = lognpdf(sg.pdf.truth.x,sg.mu,sg.std);
bg.pdf.truth.y = lognpdf(bg.pdf.truth.x,bg.mu,bg.std);

sg.n.evt = N.EVT;
bg.n.evt = N.EVT;

sg.evt = random('logn',sg.mu,sg.std,1,sg.n.evt);
bg.evt = random('logn',bg.mu,bg.std,1,bg.n.evt);

sg = rmfield(sg,'mu');
bg = rmfield(bg,'mu');

sg = rmfield(sg,'std');
bg = rmfield(bg,'std');





