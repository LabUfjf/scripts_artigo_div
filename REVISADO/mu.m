function [M] = mu(f,c,m)

syms x
M=eval(int(((x-c)^m)*f,-Inf,Inf));

end