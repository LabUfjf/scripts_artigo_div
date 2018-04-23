function [r,E]=rsum(x,y,method,sg,name,deriv)

if deriv ==1
    xtruth =linspace(min(x),max(x),1e6);
    ytruth = GridNew(sg,xtruth,name);
    dxtruth=diff(xtruth);
    h = dxtruth(1);
    d1 = diff(ytruth)/h;
    d2 = diff(d1)/h;
    K = max(abs(d2));
    a = min(xtruth);
    b = max(xtruth);
    n=length(x);
    E=abs((K*((b-a)^3))/(24*(n^2)));
else
    E=0;
end

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