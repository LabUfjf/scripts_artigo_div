 function r=rsum(x,y)
dx=diff(x); 
r = sum(abs(y(1:end-1)).*abs(dx));
end