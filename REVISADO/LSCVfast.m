function moh=LSCVfast(x,h)
% x is the input data
% h is the bandwidth
n=length(x);
F=zeros(n-1,n);

[F] = fastMfull(x);

S1=sum(sum(kg(F/(sqrt(2)*h)))/sqrt(2));   %  The sqrt(2) factors are for
S2=sum(sum(kg(F/h)));

clearvars -except S1 S2 n h

S1=S1/(n*n*h);
S2=2*(S2/(n*(n-1))-kg(0)/(n-1))/h;
moh=S1-S2;


