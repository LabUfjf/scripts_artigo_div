function [C] = Cosine(P,Q,dx,mod)

T1 = sum(ar((P.*Q).*dx,mod));
T2 = ar(sqrt(sum((P.^2).*dx)),mod);
T3 = ar(sqrt(sum((Q.^2).*dx)),mod);

C = T1./(T2.*T3);

end