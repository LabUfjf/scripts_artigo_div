function [S] = Sorensen(P,Q,dx,mod)
S = sum(ar((P-Q).*dx,mod))./sum(ar((P+Q).*dx,mod));
end