function [S] = Squared(P,Q,dx,mod)

T1 = (P-Q).^2;
T2 = P+Q;
T3=(T1./T2).*dx;
T3(isnan(T3)|isinf(T3))=0;

S = ar(sqrt(sum(T3)),mod);

end