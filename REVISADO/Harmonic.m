function [H] = Harmonic(P,Q,dx,mod)

T1 = ar((P.*Q)./(P+Q),mod);
T1(isnan(T1)|isinf(T1))=0;
H = 2*sum(T1.*dx);

end