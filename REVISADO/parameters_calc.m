clear; close all; clc
syms x tau
type = 'Gaussian';
r = 1;
[H] = hermiteP(x,r);
[K] = kernel_function(type);
dK = diff(K,r);
% dKH = ((-1)^r)*H*K; 
CdK=symconv(dK, dK);
CK=symconv(K, K);



[fx] = kernel_fun_der(kernel,r)
x = linspace(-4,4,1000);

% plot(x,eval(K)); hold on
% plot(x,eval(dK),'-k'); 
% legend('K(x)',['dK^' num2str(r) '(x)'],['dKH^' num2str(r) '(x)'])
% 
% figure
% plot(x,eval(CdK(1)))
% 
% [M] = mu(K,0,1);
% 


A=int(Kraw,x,-Inf,Inf)