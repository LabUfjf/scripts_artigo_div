function [hk] = hkfct(h,fpk,nPoint)
for i=1:nPoint
    hk(i)=abs((h)./(sqrt(fpk(i))));
end
end