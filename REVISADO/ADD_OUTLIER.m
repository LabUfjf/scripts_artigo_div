function [OUT]= ADD_OUTLIER(OUT,n)


V=100*stdRobust(OUT','MAD');
M=median(OUT');
d=0;
for i=1:n;    
% OUT(:,end+1)= [M(1); M(2); (d*M(3)+randn)*V(3)];
% OUT(:,end+1)= [M(1); randn*V(2); (d*M(3)+randn)*V(3)];
OUT(:,end+1)= [(d*M(1)+randn)*V(1); (d*M(2)+randn)*V(2); (d*M(3)+randn)*V(3)];
end

end