function [hi] = hihj(h,lambda,fpi,nd,n)
% h = cell
% lambda = vector
% fpi = cell
% nPoint = vector¨
% nd = cell
for d=1:nd
    for i=1:n{d}
    hi{d}(i)=abs((h{d})*(sqrt(lambda(d)/fpi{d}(i))));
    end
end
end