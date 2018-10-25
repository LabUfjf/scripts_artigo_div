function [x,y] = ASHEST(DATA, method)
M = 10;
switch method
    case 'truth'
        [bin,~,~]=bintruth(DATA,100,'linear');
        [x,y] = ashN(DATA.sg.evt,M,'linear',bin);
    otherwise
        [bin]=calcnbins(reshape(DATA.sg.evt,length(DATA.sg.evt),1),method);
        [x,y] = ashN(DATA.sg.evt,M,'linear',bin);
end
