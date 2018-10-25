function [hk] = hBE(h,lambda,fpk,data,X)

d = diff(X); d=d(1);
dr = diff(fpk)
dr = [dr dr(end)];
%          dx = diff(X1); dx=dx(1);
%             
%             plot(X1(1:end-1),diff(f1)/dx)

% type = 'Gaussian';
% r=0;
% Rdk = Rg(kernel_fun_der(type,r));
% mu2 = mu(kernel_function([],type,'syms'),0,4);
% fpk(fpk==0)=min(fpk(fpk>0));
% dfpk2=((diff(fpk,2))).^2;
% dfpk2 = [dfpk2 dfpk2(end) dfpk2(end)];


for k=1:length(fpk)
%         [~,D] = knnsearch(X(k),data','Distance','Euclidean');
%         hk(k)=mean(D);
    %     hk(k)= ((Rdk*fpk(k))/(length(data)*mu2*dfpk2(k)))^(1/5);
        hk(k)=abs((h)./(dr(k)));
%     hk(k)= abs(h/sqrt(2*length(data)*fpk(k)));
    %     hk(k)=abs(1/(length(data)*fpk(k)));
end

end