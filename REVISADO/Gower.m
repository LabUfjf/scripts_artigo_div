function [G] = Gower(P,Q,dx,mod)

T1 = abs(P-Q);
G = ar(sum(T1.*dx),mod);

end