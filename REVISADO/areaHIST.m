function [A] = areaHIST(DATA,inter,bin)

[xh,yh]=data_normalized(DATA.sg.evt,bin);
yhgrid = interp1(xh,yh,DATA.sg.pdf.truth.x,inter,'extrap');
A = area2d(DATA.sg.pdf.truth.x,abs(yhgrid-DATA.sg.pdf.truth.y));

