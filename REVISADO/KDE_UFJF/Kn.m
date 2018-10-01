function [K]=Kn(u)
 K=((2*pi)^(-1/2))*exp((-(u.^2)/2)); %Gaussian
end