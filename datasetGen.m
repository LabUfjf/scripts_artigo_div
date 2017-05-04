function [sg,bg,M] = datasetGen(n) 

% Generate Data
[sg,bg] = Normal_Gen([],[],n);
[sg,bg] = Normal_Bimodal_Gen(sg,bg,n);
[sg,bg] = Rayleigh_Gen(sg,bg,n);
[sg,bg] = LogN_Gen(sg,bg,n);
[sg,bg] = Gamma_Gen(sg,bg,n);

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

sg.gauss.evt = [];
bg.gauss.evt = [];
sg.normal.evt = [];
bg.normal.evt = [];
sg.rayleigh.evt = [];
bg.rayleigh.evt = [];
sg.logn.evt = [];
bg.logn.evt = [];
sg.gamma.evt = []; 
bg.gamma.evt = [];

end