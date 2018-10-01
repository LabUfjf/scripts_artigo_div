function CV=UCV(x,h,r,type)
% x is the input data
% h is the bandwidth
syms u
n=length(x);
term=0;

[dk] = kernel_fun_der(type,r);
[d2k] = kernel_fun_der(type,2*r);
cK = kernel_fun_conv(type,r);
Rdk = Rg(dk);
FUCV = matlabFunction(cK-2*d2k);

for i=1:n
term=term+mean(FUCV((x(x~=x(i))-x(i))/h)); 
end;

CV=(Rdk*(1/(n*h^((2*r)+1))))+((-1)^r / ((n-1)*h^((2*r)+1)))*term;

