function [y] = fftkernel(x,w)
L = length(x);
Lmax = L+3*w; %take 3 sigma to avoid aliasing 
%n = 2^(nextpow2(Lmax)); 
n = 2^(ceil(log2(Lmax))); 
X = fft(x,n);
f = [-(0:n/2) (n/2-1:-1:1)]/n;
% Gauss
K = exp(-0.5*(w*2*pi*f).^2);
% Laplace
%K = 1 ./ ( 1+ (w*2*pi*f).^2/2 );
y = ifft(X.*K,n);
y = y(1:L);