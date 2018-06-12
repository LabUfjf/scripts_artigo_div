function [K] = Kumar(P,Q,dx,mod)

T1 = (P.^2-Q.^2).^2;
T2 = ar(2*((P.*Q).^(3/2)),mod);
T3= (T1./T2).*dx;
T3(isnan(T3)|isinf(T3))=0;
K = ar(sum(T3),mod);

end