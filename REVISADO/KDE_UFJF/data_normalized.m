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