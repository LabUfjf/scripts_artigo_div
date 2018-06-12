function [H] = Hellinger(P,Q,dx,mod)

T1=((ar(sqrt(P),mod)-ar(sqrt(Q),mod)).^2).*dx;
H = ar(sqrt(2*sum(T1)),mod);

end