function [hi] = hSSE(h,lambda,fpi)
fpi(fpi==0)=min(fpi(fpi>0));


for i=1:length(fpi)    
    hi(i)=abs((h).*(sqrt(lambda./fpi(i))));
end
end

