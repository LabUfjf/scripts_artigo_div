function [u] = VR_phi6_bin(n, d, x, h)
soma = 0;
for i = 1:length(x);
    delta = delta*((i * d) / h);
    term = exp(-delta/2) * (delta * delta *delta - 15*delta*delta + 45*delta - 15);
    soma = soma + (term * x(i));
   
end
 soma = 2* soma -15 * nn;
u = soma / (n*(n - 1.)* h^7 * sqrt(2 * pi));
