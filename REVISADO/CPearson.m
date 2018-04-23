function [CP] = CPearson(P,Q)

for i=1:size(P,2) 
    MC=cov(P(:,i),Q(:,i));
    C(i)=MC(1,2);
    VP(i) =var(P(:,i));
    VQ(i)=var(Q(:,i));
    CP(i)=C(i)/sqrt(VP(i)*VQ(i));
end
    
end