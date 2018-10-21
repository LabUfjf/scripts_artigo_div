function [bin,mq]=Rudemo(DATA)

% nbs=10;
% [~,ind] = bootstrp(nbs,@(x)[mean(x) std(x)],DATA);
% for i=1:nbs
SN = 30;                    % # of partitioning positions for shift average
binmax= 150;


for nbin=2:binmax
    edge=linspace(min(DATA),max(DATA),nbin);  
    D = (max(DATA) - min(DATA)) ./ nbin;   % Bin Size Vector
    shift = linspace(0,D,SN);
    for s=1:SN
    N=length(DATA);
    [yh,xh]=hist(DATA,edge+shift(s));
    h=diff(xh); h=h(1);
    mq(nbin,s)=(2/((N-1)*h))-(((N+1)/((N-1)*h*N^2))*sum(yh.^2));
    end
end
%     Q(:,i) = q;
% end

mq = mean(mq');
bin = round(find(mq(2:end)==min(mq(2:end))));
bin = bin+1;
mq=mq(2:end);
end