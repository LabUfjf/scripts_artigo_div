function [A] = areaPF(DATA,inter,bin)

[xh,yh]=data_normalized(DATA.sg.evt,bin);
yhgrid = interp1(xh,yh,DATA.sg.pdf.truth.x,inter,0);
A = area2d(DATA.sg.pdf.truth.x,abs(yhgrid-DATA.sg.pdf.truth.y));

