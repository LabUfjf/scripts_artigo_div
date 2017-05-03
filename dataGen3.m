function [sg,M] = dataGen3(n) 

% Generate Data
[sg] = Normal_Gen2([],n);

M=[sg.gauss.evt];

end