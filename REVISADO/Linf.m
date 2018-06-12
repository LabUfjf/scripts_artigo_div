function [L] = Linf(P,Q)
 L = max(abs(P-Q));
end
