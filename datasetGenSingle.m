function [sg,bg] = datasetGenSingle(N,name)

% Generate Data
switch name
    case 'Gauss'
        [sg,bg] = M_Normal_Gen([],[],N);
    case 'Bimodal'
        [sg,bg] = M_Normal_Bimodal_Gen([],[],N);
    case 'Rayleigh'
        [sg,bg] = M_Rayleigh_Gen([],[],N);
    case 'Logn'
        [sg,bg] = M_LogN_Gen([],[],N);
    case 'Gamma'
        [sg,bg] = M_Gamma_Gen([],[],N);
end

[bg.RoI.x,bg.RoI.y] = reg_choice(bg.pdf.truth.x,bg.pdf.truth.y,N.DIV,sg.n.x);
[sg.RoI.x,sg.RoI.y] = reg_choice(sg.pdf.truth.x,sg.pdf.truth.y,N.DIV,sg.n.x);

sg = rmfield(sg,'n');
bg = rmfield(bg,'n');
end