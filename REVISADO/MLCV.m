function CV=MLCV(x,h)
% x is the input data
% h is the bandwidth
n=length(x);
sqterm=0;

for i=1:n
    sqterm=sqterm+log(mean(kernel_function((x(x~=x(i))-x(i))/h,'Gaussian','none')))-log((h*(n-1)));   %  The sqrt(2) factors are for
end;
CV=(n^-1)*sqterm;

