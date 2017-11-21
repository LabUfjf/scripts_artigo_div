function [sg,bg] = datasetGenSingle(setup,name)

% Generate Data
switch name
     case 'Uniforme'
        [sg,bg] = M_Uniforme_Gen([],[],setup);
    case 'Gauss'
        [sg,bg] = M_Normal_Gen([],[],setup);
    case 'Bimodal'
        [sg,bg] = M_Normal_Bimodal_Gen([],[],setup);
    case 'Rayleigh'
        [sg,bg] = M_Rayleigh_Gen([],[],setup);
    case 'Logn'
        [sg,bg] = M_LogN_Gen([],[],setup);
    case 'Gamma'
        [sg,bg] = M_Gamma_Gen([],[],setup);
end

[bg.RoI.x,bg.RoI.y] = reg_choice(bg.pdf.truth.x,bg.pdf.truth.y,setup.DIV,sg.n.x);
[sg.RoI.x,sg.RoI.y] = reg_choice(sg.pdf.truth.x,sg.pdf.truth.y,setup.DIV,sg.n.x);

sg = rmfield(sg,'n');
bg = rmfield(bg,'n');
end