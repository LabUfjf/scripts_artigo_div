function [bin,mq]=Rudemo2(DATA)

n = length(DATA);
binmax= 150;
wb=waitbar(0,'Aguarde...');
for nbin=2:binmax
    for i=1:n
        N=length(DATA(DATA~=DATA(i)));
        [yh,xh]=hist(DATA,nbin);
        h=diff(xh); h=h(1);
        mq(nbin,i)=(2/((N-1)*h))-(((N+1)/((N-1)*h*N^2))*sum(yh.^2));
    end
    waitbar(nbin/binmax)
end
close(wb)
mq = mean(mq');
bin = round(find(mq(2:end)==min(mq(2:end))));
bin = bin+1;
mq=mq(2:end);
end