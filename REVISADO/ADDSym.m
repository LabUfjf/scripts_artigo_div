function [AS] = ADDSym(P,Q,dx,mod)

T1 = (P-Q).^2;
T2 = P+Q;
T3 = T1.*T2;
T4 = P.*Q;
T5 = (T3./T4).*dx;

T5(isnan(T5)|isinf(T5))=0;
AS = ar(sum(T5),mod);

end