function CV=BCV2fast(x,h,r,type)
% x is the input data
% h is the bandwidth
syms u
n=length(x);
% F=zeros(n-1,n);
[F] = fastM(x);

% [d2k] = kernel_fun_der(type,2*r);

% [dk] = kernel_fun_der(type,r);
% Rdk = Rg(dk);
% cK = kernel_fun_der(type,2*r+4);
% mu2 = mu(kernel_function([],type,'syms'),0,2);
% FBCV2 = matlabFunction(cK);
load BCV2fast[0]

S=sum(mean((((-1)^(r+2))/((n-1)*h^((2*r)+5)))*FBCV2((F)/h))); 
clearvars -except S mu2 h r n Rdk
CV = (Rdk*(1/(n*h^((2*r)+1))))+((0.25*h^4)*(mu2)^2)*S;
% CV=(Rdk*(1/(n*h^((2*r)+1))))+((0.25*h^4)*(1)^2)*((-1)^(r+2) / ((n-1)*h^((2*r)+1)))*term;

