function r=rsum(x,y,method)

dx=diff(x);

if strcmp(method,'left')    
    r = sum(abs(y(1:end-1)).*abs(dx));
end

if strcmp(method,'right')
    r = sum(abs(y(2:end)).*abs(dx));
end

if strcmp(method,'mid')
    y = (y(1:end-1) +y(2:end))/2;
    r = sum(abs(y.*abs(dx)));
end




end