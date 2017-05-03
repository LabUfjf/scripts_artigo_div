function [hi] = hihj(h,lambda,fpi,n)
% h = cell
% lambda = vector
% fpi = cell
% nPoint = vector¨
% nd = cell
for i=1:n
    hi(i)=abs((h)*(sqrt(lambda/fpi(i))));
end
end