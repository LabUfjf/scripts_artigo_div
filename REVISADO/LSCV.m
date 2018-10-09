function moh=LSCV(x,h)
% x is the input data
% h is the bandwidth
n=length(x);
sqterm=0;
xterm=0;
for i=1:n
    sqterm=sqterm+sum(kg((x-x(i))/(sqrt(2)*h)))/sqrt(2);   %  The sqrt(2) factors are for 
    % the K(2) term which is
    % equivalent to a kernel with variance of 2 that is the convolution of 2
    % gaussian kernels.  
    xterm=xterm+sum(kg((x-x(i))/h));
end;
sqterm=sqterm/(n*n*h);
xterm=2*(xterm/(n*(n-1))-kg(0)/(n-1))/h;
moh=sqterm-xterm;


