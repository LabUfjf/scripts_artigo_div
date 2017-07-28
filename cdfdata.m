function [pe,pd,gridx] = cdfdata(DATASET,TH,npts)
TH = 0.1
TH = TH/100;
clear CDFDATA THX
DATASORT = sort(DATASET);
% step = round(0.0005*length(DATASET));
step =1;

wb = waitbar(0,'Aguarde...');
for i = 1:30:length(DATASORT)
    THX(i) = DATASORT(i);
    CDFDATA(i) =  sum(DATASET <= DATASORT(i));
    waitbar(i/length(DATASORT))
end

hold on
[yh,xh]=hist(DATASET,150);
plot(xh,(yh),'-r'); hold on
h = diff(THX);
plot(THX(1:end-1),diff(CDFDATA)./h,'.k')
% plot(THX(1:end),(CDFDATA),'.k')

hold on
close(wb)

CDFDATA = (CDFDATA/max(CDFDATA));
[~,ind]=unique(CDFDATA);

plot(DATASORT,CDFDATA); hold on
[yh,xh]=hist(DATASET,150);
plot(xh,(yh/max(yh))*100)
% plot(sg.logn.pdf.x.all,(sg.logn.pdf.y.all/max(sg.logn.pdf.y.all))*100,'-')
pause
pe = interp1(CDFDATA(ind),DATASORT(ind),TH,'nearest','extrap');
pd = interp1(CDFDATA(ind),DATASORT(ind),100-TH,'nearest','extrap');
% hist(DATASET,100)
%  plot(CDFDATA(ind),DATASORT(ind),'k'); hold on

% X = CDFDATA(ind(1:100:end));
% Y= DATASORT(ind(1:100:end));
% r=ksrlin(X,Y)
%    cftool(CDFDATA(ind(1:100:end)),DATASORT(ind(1:100:end)))
%   plot(CDFDATA(ind),smooth(DATASORT(ind)),'r'); hold on
%  plot(CDFDATA,DATASORT); hold on
%  plot([TH TH],[min(DATASORT(ind)) max(DATASORT(ind))],'-r',[1-TH 1-TH],[min(DATASORT(ind)) max(DATASORT(ind))],'-r')
gridx = interp1(CDFDATA(ind),DATASORT(ind),linspace(0,1,npts),'linear','extrap');

% hist(DATASET(DATASET>pe & DATASET<pd),gridx)
% plot(pe,0,'sc',pd,0,'sc','DisplayName','DATA CDF')
% legend show
end
