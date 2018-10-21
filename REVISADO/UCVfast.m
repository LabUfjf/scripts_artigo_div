function CV=UCVfast(x,h,r,type)
% x is the input datafast
% h is the bandwidth
syms u
n=length(x);
% F=zeros(n-1,n);
[F] = fastM(x);

% [dk] = kernel_fun_der(type,r);
% [d2k] = kernel_fun_der(type,2*r);
% cK = kernel_fun_conv(type,r);
% Rdk = Rg(dk);
% FUCV = matlabFunction(cK-2*d2k);
load UCVfast[0] 

S=sum(mean(FUCV((F/h)))); 
clearvars -except S h r n Rdk
CV=(Rdk*(1/(n*h^((2*r)+1))))+((-1)^r / ((n-1)*h^((2*r)+1)))*S;

