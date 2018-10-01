function [R] = Rg(F)
syms x
R=eval(int(F.^2,-Inf,Inf));
end