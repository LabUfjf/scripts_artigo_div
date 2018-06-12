function [T] = Taneja(P,Q,dx,mod)
T1 = (P+Q)/2;
T2 = (P+Q);
T3 = ar(2*sqrt(P.*Q),mod);

T4 = T1.*log(T2./T3).*dx;
T4(isnan(T4)|isinf(T4))=0;
T = ar(sum(T4),mod);

end