function [x,y] = BINEST(DATA, method)

switch method
    case 'truth'
        [bin,~,~]=bintruth(DATA,100,'linear');
        [x,y]= data_normalized(DATA.sg.evt,bin);
    otherwise
        [bin]=calcnbins(reshape(DATA.sg.evt,length(DATA.sg.evt),1),method);
        [x,y]= data_normalized(DATA.sg.evt,bin);
end
