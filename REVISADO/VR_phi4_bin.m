function [u] = VR_phi4_bin(n, d, x, h)
soma = 0;
for i = 1:length(x);
    delta = delta*((i * d) / h);
    term = exp(-delta/2) * (delta * delta - 6*delta + 3);
    soma = soma + (term * x(i));
    
end
soma = 2* soma + nn * 3;
u = soma / (n*(n - 1.)* h^5 * sqrt(2 * pi));
