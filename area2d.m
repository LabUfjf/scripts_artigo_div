function [ area ] = area2d( x,y )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%tbin=abs((x(2)-x(1)));
tbin=diff(x);
%area=trapz(x,y);
area=sum(abs(y))*abs(tbin);
area=sum(abs(y(1:end-1)).*abs(tbin));
end