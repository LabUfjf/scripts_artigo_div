function [ area ] = area2d( x,y )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%tbin=abs((x(2)-x(1)));
tbin=min(diff(x));
%area=trapz(x,y);
area=sum(abs(y))*abs(tbin);

end

