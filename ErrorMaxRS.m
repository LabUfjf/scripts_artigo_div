function [M] = ErrorMaxRS(xest,xpdf,ypdf)

h=diff(xest);
d1 = diff(ypdf)/h(1);
d2 = diff(d1)/h(1);

M2=   max(abs(d2));
b = max(xpdf);
a = min(xpdf);
n = length(xest);
M = (M2*((b-a)^3))/(24*n^2);
% M = M*length(yest);
end