function CV=TCV(x,h,r,type)
% x is the input data
% h is the bandwidth
syms u
n=length(x);
term=0;

L1 = matlabFunction(kernel_fun_conv(type,r));
D2 = matlabFunction(kernel_fun_der(type,2*r));

Rdk = Rg(kernel_fun_der(type,r));
% R_Kr1 = A3_kM(type);
for i=1:n
    X = (x(x~=x(i))-x(i))/h;
    X = X(abs(X)>(1/(n*h^(2*r+1))));
    Q1 = sum(((-1)^(r)/((n-1)*h^(2*r+1)))*L1(X));
    Q2 = sum(((-1)^(r)/((n-1)*h^(2*r+1)))*D2(X));
    term=term+(1/(n*h^(2*r+1)))*Rdk + Q1 - 2 * Q2 ;
end;
CV = term*(1/n);


