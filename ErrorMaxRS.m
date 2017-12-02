function [M] = ErrorMaxRS(xest,xpdf,ypdf)

h=diff(xpdf);
d1 = diff(ypdf)/h(1);
d2 = diff(d1)/h(1);
M1=   max(abs(d1));
M2=   max(abs(d2));
b = max(xest);
a = min(xest);
n = length(xest);
% M = (M2*((b-a)^3))/(24*n^2);
M = (M1*(1/2)*((b-a)^2))/n;
% M = M*length(yest);
end