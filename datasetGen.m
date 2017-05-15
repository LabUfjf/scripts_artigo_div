function [sg,bg,M] = datasetGen(N)

% Generate Data
[sg,bg] = Normal_Gen([],[],N.EVT);
[sg,bg] = Normal_Bimodal_Gen(sg,bg,N.EVT);
[sg,bg] = Rayleigh_Gen(sg,bg,N.EVT);
[sg,bg] = LogN_Gen(sg,bg,N.EVT);
[sg,bg] = Gamma_Gen(sg,bg,N.EVT);

% plotPDF2(sg,bg)

M.mix=[sg.gauss.evt bg.gauss.evt; ...
    sg.normal.evt bg.normal.evt; ...
   sg.rayleigh.evt bg.rayleigh.evt; ...
   sg.logn.evt bg.logn.evt; ...
   sg.gamma.evt bg.gamma.evt];

M.sg=[sg.gauss.evt ; ...
    sg.normal.evt ; ...
   sg.rayleigh.evt ; ...
   sg.logn.evt ; ...
   sg.gamma.evt];

M.bg=[bg.gauss.evt; ...
    bg.normal.evt; ...
   bg.rayleigh.evt; ...
   bg.logn.evt; ...
   bg.gamma.evt];

sg.gauss = rmfield(sg.gauss,'evt');
sg.normal = rmfield(sg.normal,'evt');
sg.rayleigh = rmfield(sg.rayleigh,'evt');
sg.logn = rmfield(sg.logn,'evt');
sg.gamma = rmfield(sg.gamma,'evt');

bg.gauss = rmfield(bg.gauss,'evt');
bg.normal = rmfield(bg.normal,'evt');
bg.rayleigh = rmfield(bg.rayleigh,'evt');
bg.logn = rmfield(bg.logn,'evt');
bg.gamma = rmfield(bg.gamma,'evt');

[bg.gauss.RoI.x,bg.gauss.RoI.y] = reg_choice(bg.gauss.pdf.x.all,bg.gauss.pdf.y.all,N.DIV);
[bg.normal.RoI.x,bg.normal.RoI.y] = reg_choice(bg.normal.pdf.x.all,bg.normal.pdf.y.all,N.DIV);
[bg.rayleigh.RoI.x,bg.rayleigh.RoI.y] = reg_choice(bg.rayleigh.pdf.x.all,bg.rayleigh.pdf.y.all,N.DIV);
[bg.logn.RoI.x,bg.logn.RoI.y] = reg_choice(bg.logn.pdf.x.all,bg.logn.pdf.y.all,N.DIV);
[bg.gamma.RoI.x,bg.gamma.RoI.y] = reg_choice(bg.gamma.pdf.x.all,bg.gamma.pdf.y.all,N.DIV);

[sg.gauss.RoI.x,sg.gauss.RoI.y] = reg_choice(sg.gauss.pdf.x.all,sg.gauss.pdf.y.all,N.DIV);
[sg.normal.RoI.x,sg.normal.RoI.y] = reg_choice(sg.normal.pdf.x.all,sg.normal.pdf.y.all,N.DIV);
[sg.rayleigh.RoI.x,sg.rayleigh.RoI.y] = reg_choice(sg.rayleigh.pdf.x.all,sg.rayleigh.pdf.y.all,N.DIV);
[sg.logn.RoI.x,sg.logn.RoI.y] = reg_choice(sg.logn.pdf.x.all,sg.logn.pdf.y.all,N.DIV);
[sg.gamma.RoI.x,sg.gamma.RoI.y] = reg_choice(sg.gamma.pdf.x.all,sg.gamma.pdf.y.all,N.DIV);

end