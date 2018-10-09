function [f] = laplacecdf(x,mu,sigma)
b = sigma / sqrt(2);
f = (1/2)+ (1/2)*sign(x-mu).*(1-exp(-(abs(x-mu)/b)));
end