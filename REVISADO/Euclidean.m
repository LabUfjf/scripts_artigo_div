function [E] = Euclidean(P,Q,dx,mod)

T1 = ((P-Q).^2).*dx;
E = sum(ar(T1,mod));

end