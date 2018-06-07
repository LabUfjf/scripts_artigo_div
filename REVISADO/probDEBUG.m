function [Qx,Q] = probDEBUG(DATA)

Ql = linspace(min(DATA.sg.pdf.truth.y),max(DATA.sg.pdf.truth.y),500);
[~,ib]=unique(DATA.sg.pdf.truth.y);
% Qx=interp1(DATA.sg.pdf.truth.y(sort(ib)),DATA.sg.pdf.truth.x(sort(ib)),Q,inter,'extrap');
Qx = [];
Q = [];
for i = 1:length(Ql)
[x,p] = polyxpoly(DATA.sg.pdf.truth.y(sort(ib)),DATA.sg.pdf.truth.x(sort(ib)),[Ql(i) Ql(i)],[min(DATA.sg.pdf.truth.x(sort(ib))),max(DATA.sg.pdf.truth.x(sort(ib)))]);
Qx=[Qx p'];
Q=[Q x'];
% pause
end

end