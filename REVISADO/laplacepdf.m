function [f] = laplacepdf(x,mu,sigma)

b = sigma / sqrt(2);

f = (1/(2*b))*exp(-(abs(x-mu)/b));

end