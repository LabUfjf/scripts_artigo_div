function CV=BCV1(x,h,r,type)
% x is the input data
% h is the bandwidth
syms u
n=length(x);

% [d2k] = kernel_fun_der(type,2*r);

[dk] = kernel_fun_der(type,r);
Rdk = Rg(dk);
cK = kernel_fun_conv(type,r+2);
mu2 = mu(kernel_function([],type,'syms'),0,2);
FBCV1 = matlabFunction(cK);

% [F] = fastM(x);

for i=1:n
term=term+mean((((-1)^(r+2))/((n-1)*h^((2*r)+5)))*FBCV1(((x(x~=x(i))-x(i)))/h)); 
end

CV = (Rdk*(1/(n*h^((2*r)+1))))+((0.25*h^4)*(mu2)^2)*term;
% CV=(Rdk*(1/(n*h^((2*r)+1))))+((0.25*h^4)*(1)^2)*((-1)^(r+2) / ((n-1)*h^((2*r)+1)))*term;

