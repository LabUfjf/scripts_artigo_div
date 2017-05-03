function [sg,bg,M] = dataGen(n) 

% Generate Data
[sg,bg] = Normal_Gen([],[],n);
[sg,bg] = Normal_Bimodal_Gen(sg,bg,n);
[sg,bg] = Rayleigh_Gen(sg,bg,n);
[sg,bg] = LogN_Gen(sg,bg,n);
[sg,bg] = Gamma_Gen(sg,bg,n);

plotPDF(sg,bg)

M=[sg.gauss.evt bg.gauss.evt; ...
    sg.normal.evt bg.normal.evt; ...
   sg.rayleigh.evt bg.rayleigh.evt; ...
   sg.logn.evt bg.logn.evt; ...
   sg.gamma.evt bg.gamma.evt];

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