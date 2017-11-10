clear; clc;
load VCTGAUSS1000
load VCTPOISSON1000

nevt = 1000;
for nv = 2:16
% plot(VCTGAUSS.MEAN(nv,:),VCTGAUSS.MEAN(1,:))
% hold on
% plot(VCTPOISSON.MEAN(nv,:),VCTPOISSON.MEAN(1,:))
MAXMIN = max([min(VCTGAUSS.MEAN(nv,:)) min(VCTPOISSON.MEAN(nv,:))]);
MINMAX = min([max(VCTGAUSS.MEAN(nv,:)) max(VCTPOISSON.MEAN(nv,:))]);
i=0;
xrange= linspace(MAXMIN,MINMAX,100000);

for x= xrange
i=i+1;
xg(i) = interp1(VCTGAUSS.MEAN(nv,:),VCTGAUSS.MEAN(1,:),x,'linear','extrap');
xp(i) = interp1(VCTPOISSON.MEAN(nv,:),VCTPOISSON.MEAN(1,:),x,'linear','extrap');
end

ind=find(abs(xp-nevt)==min(abs(xp-nevt)));
PT_int(nv-1,:) =[xg(ind) xp(ind)];

% plot(xrange,xg,'r',xrange,xp,'k')
% pause
% close

end
save(['PT_int' num2str(nevt)], 'PT_int');