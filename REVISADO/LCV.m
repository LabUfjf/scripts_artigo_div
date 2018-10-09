function sqterm=LCV(x,h)
% likelihood
% x is the input data
% h is the bandwidth
n=length(x);
sqterm=0;
for i=1:n
    sqterm=sqterm+log(sum(1/(n*h)*kg((x-x(i))/h)));   %  The sqrt(2) factors are for 
    % the K(2) term which is
    % equivalent to a kernel with variance of 2 that is the convolution of 2
    % gaussian kernels.  

end;
sqterm=(n^(-1))*sqterm;
