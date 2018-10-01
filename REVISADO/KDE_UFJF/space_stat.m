function [xs,xn] = space_stat(data,pts)
[yh,xh]=hist(data,pts);
yh=max(yh)-yh; 
yh=smooth(yh,'moving');yh=smooth(yh,'moving');yh=smooth(yh,'moving');yh=smooth(yh,'moving');
f=yh/max(yh);
xn=linspace(min(data),max(data),pts);
xs=xn.*f';
% figure
% stairs(f)