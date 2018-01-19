function [sg,bg] = datasetGenSingle(setup,name,type)
range_minmax = 1;
% Generate Data
switch name
    case 'Uniform'
        [sg,bg] = M_Uniforme_Gen([],[],setup,range_minmax);        
    case 'Gaussian'
        [sg,bg] = M_Normal_Gen([],[],setup,range_minmax);
    case 'Bimodal'
        [sg,bg] = M_Normal_Bimodal_Gen([],[],setup,range_minmax);
    case 'Rayleigh'
        [sg,bg] = M_Rayleigh_Gen([],[],setup,range_minmax);
    case 'Logn'
        [sg,bg] = M_LogN_Gen([],[],setup,range_minmax);
    case 'Gamma'
        [sg,bg] = M_Gamma_Gen([],[],setup,range_minmax);
end

if ~strcmp(type,'bypass')
    [bg.RoI.x,bg.RoI.y,bg.RoI.Xaxis,bg.RoI.ind] = reg_choice(bg.pdf.truth.x,bg.pdf.truth.y,setup.DIV,type);
    [sg.RoI.x,sg.RoI.y,sg.RoI.Xaxis,sg.RoI.ind] = reg_choice(sg.pdf.truth.x,sg.pdf.truth.y,setup.DIV,type);
end
% sg = rmfield(sg,'n');
% bg = rmfield(bg,'n');

end