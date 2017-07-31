function [sg,bg] = DIVFIX(sg,bg)

sg = rmfield(sg,'pdf');
sg = rmfield(sg,'evt');
sg = rmfield(sg,'nPoint');
sg = rmfield(sg,'Div');

bg = rmfield(bg,'pdf');
bg = rmfield(bg,'evt');
bg = rmfield(bg,'nPoint');






end