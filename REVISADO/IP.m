function [I] = IP(P,Q,dx,mod)
I = sum(ar(P.*Q.*dx,mod));
end