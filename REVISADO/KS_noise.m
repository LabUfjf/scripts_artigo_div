function [] = KS_noise(mu,sigma,Q)   



mu =  0;
sigma = (Q/max(Q)).*f.norm(sd(j));

% wb = waitbar(0,'Aguarde')
for i=1:length(Q)
    i
 data(i) = pearsrnd(mu,sigma(i),0+(1/2).^(100*Q(i)),3+(1/2).^(100*Q(i)),1,1);
%  waitbar(i/length(Q))
end
% close(wb)


