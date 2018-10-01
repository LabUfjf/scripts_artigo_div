function [bin,q]=Rudemo(DATA)

for nbin=2:1000
    N=length(DATA);
    [yh,xh]=hist(DATA,nbin);
    h=diff(xh); h=h(1);
    q(nbin)=(2/((N-1)*h))-(((N+1)/((N-1)*h*N^2))*sum(yh.^2));
end

bin = round(find(q(2:end)==min(q(2:end))));
bin = bin+1;
q=q(2:end);
end