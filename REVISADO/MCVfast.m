function CV=MCVfast(x,h,r,type)
% x is the input data
% h is the bandwidth
syms u
n=length(x);
F=zeros(n-1,n);
[F] = fastM(x);

L1 = matlabFunction(kernel_fun_conv(type,r));
D2 = matlabFunction(kernel_fun_der(type,2*r));
D3 = matlabFunction(kernel_fun_der(type,2*r+2));
% Rdk = Rg(kernel_fun_der(type,r));
% R_Kr1 = A3_kM(type);

X = (F)/h;
Q1 = ((-1)^r / ((n-1)*h^(2*r+1)))*sum(L1(X));
Q2 = ((-1)^r / ((n-1)*h^(2*r+1)))*sum(D2(X));
Q3 = ((-1)^r / ((n-1)*h^(2*r+1)))*sum(D3(X));

load MCVfast[0] 
S=sum((1/(n*h^(2*r+1)))*R_Kr1 + Q1 - Q2 -  0.5 * A2_kM(type) * Q3);

CV = (1/n)*S;


