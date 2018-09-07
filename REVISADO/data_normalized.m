%% data normalized
function [x,y] = data_normalized(x,bin);

[yh,xh]= hist(x,bin);
ah= area2d(xh,yh);
x = xh;
y=yh/ah;
% 
% figure
%  stairs(x,y,'k')
end

function [ area ] = area2d( x,y )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%tbin=abs((x(2)-x(1)));
tbin=min(diff(x));
%area=trapz(x,y);
area=sum(abs(y))*abs(tbin);

end