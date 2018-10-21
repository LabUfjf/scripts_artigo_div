function [x,y] = ashN(x,M,inter,bin)
[xh,yh]= ash(x,M,inter,bin);
ah= area2d(xh,yh);
x = xh;
y=yh/ah;
end

function [ area ] = area2d( x,y )
tbin=min(diff(x));
area=sum(abs(y))*tbin;
end

