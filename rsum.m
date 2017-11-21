 function r=rsum(x,y)
dx=diff(x); dx = dx(1);
r = sum(abs(y))*abs(dx);
end