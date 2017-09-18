function [sg,bg] = M_Rayleigh_Gen(sg,bg,N)

sg.n.x = N.PTS;
bg.n.x = N.PTS;

sg.pdf.truth.x = linspace(0,13,sg.n.x);
bg.pdf.truth.x = linspace(0,20,bg.n.x);

sg.b = 2;
bg.b = 4;

sg.pdf.truth.y = raylpdf(sg.pdf.truth.x,sg.b);
bg.pdf.truth.y = raylpdf(bg.pdf.truth.x,bg.b);

sg.n.evt = N.EVT;
bg.n.evt = N.EVT;

sg.evt = random('Rayleigh',sg.b,1,sg.n.evt);
bg.evt = random('Rayleigh',bg.b,1,bg.n.evt);

% sg = rmfield(sg,'b');
% bg = rmfield(bg,'b');






