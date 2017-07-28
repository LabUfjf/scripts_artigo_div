function [x,y] = kdeGEN(data,type)

[x,y] = fastKDE(data.evt,data.nPoint,1,type);
range.SG = linspace(min(data.evt),max(data.evt),length(data.pdf.truth.x));
y = interp1(x,y,range.SG,'nearest','extrap');
x=range.SG;

end
