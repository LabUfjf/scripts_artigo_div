function [K] = KL(P,Q,dx,mod)
T1 = (P./Q);
T2=ar(P.*log(T1).*dx,mod);
T2(isnan(T2)|isinf(T2))=0;

K = ar(sum(T2),mod);

end