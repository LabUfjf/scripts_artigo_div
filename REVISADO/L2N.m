function [L] = L2N(P,Q,dx,mod)

T1 = (P-Q).^2;
L = ar(sqrt(sum(T1.*dx)),mod);

end