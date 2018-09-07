close all; clc; clear
mu = 0;
std = 5;
nevt = 100000;
bin_vect = 2:1000;
data = mu + std*randn(10000,1);
xaxis = linspace(min(data),max(data),1000);
yaxis = zeros(size(xaxis));
data = mu + std*randn(nevt,1);

for bin = bin_vect;
[y,x]=hist(data,bin);

ynew = interp1(x,y,xaxis,'nearest','extrap');
Db(bin) = abs(sum(yaxis - ynew));
Dv(bin) = sum((yaxis - ynew).^2);
D(bin) =Db(bin) + Dv(bin);
yaxis = ynew;


end

BIN_OPT(1)=calcnbins(data,'scott');
BIN_OPT(2)=calcnbins(data,'fd');



plot(bin_vect,Db(2:end),'-b'); hold on
plot(bin_vect,Dv(2:end),'-r'); hold on
plot(bin_vect,D(2:end),'k'); hold on
plot(bin_vect,smooth(smooth(D(2:end))),'g'); hold on

plot(BIN_OPT(1),min(D(2:end)),'*k',BIN_OPT(2),min(D(2:end)),'*r')
set(gca,'Yscale','log')
% 
% dD = diff(D(2:end));
% plot(abs(dD))
% set(gca,'Yscale','log')


bar(abs(D(2:end)-smooth(smooth(D(2:end)))'))
set(gca,'Yscale','log')