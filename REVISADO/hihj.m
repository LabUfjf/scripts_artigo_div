function [hi] = hihj(h,lambda,fpi,n)
for i=1:n
    hi(:,i)=abs((h).*(sqrt(lambda./fpi(i))));
end
end