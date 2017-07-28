function [x,y] = ashGEN(data,M)

[x,y] = ashN(data.evt,M,data.nPoint);
range.SG = linspace(min(data.evt),max(data.evt),length(data.pdf.truth.x));
y = interp1(x,y,range.SG,'nearest','extrap');
x=range.SG;

end