function CV=CCV(x,h,r,type)
% x is the input data
% h is the bandwidth
syms u
n=length(x);
term=0;


L1 = matlabFunction(kernel_fun_conv(type,r));
D2 = matlabFunction(kernel_fun_der(type,2*r));
D3 = matlabFunction(kernel_fun_der(type,2*(r+1)));
D4 = matlabFunction(kernel_fun_der(type,2*(r+2)));
Rdk = Rg(kernel_fun_der(type,r));

for i=1:n
    X = (x(x~=x(i))-x(i))/h;
    Q1 = sum(((-1)^(r)/((n-1)*h^(2*r+1)))*L1(X));
    Q2 = sum(((-1)^r /((n-1)*h^(2*r+1)))*D2(X));
    Q3 = sum(((-1)^(r+1) /((n-1)*h^(2*r+3)))*D3(X));
    Q4 = sum(((-1)^(r+2) /((n-1)*h^(2*r+5)))*D4(X));

 term=term+(1/(n*h^(2*r+1)))* Rdk + Q1 - Q2 + 0.5 * h^2 *A2_kM(type) * Q3 + (h^4 / 24) *(6*(A2_kM(type))^2 - A5_kM(type)) * Q4;
end;
CV = (1/n)*term;


