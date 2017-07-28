function [pe,pd,gridx] = cdfdata(DATASET,TH,npts)
% TH = 0.1
% TH = TH/100;
clear Y
DATASORT = sort(DATASET);
% step = round(0.0005*length(DATASET));
step =1;
wb = waitbar(0,'Aguarde...');
for i = 1:step:length(DATASORT)
    CDFDATA(i) =  sum(DATASET <= DATASORT(i));
    %     CDFDATA(i) = Y(i);
    waitbar(i/length(DATASORT))
end
close(wb)

CDFDATA = (CDFDATA/max(CDFDATA));
[~,ind]=unique(CDFDATA);


% [yh,xh]=hist(DATASET,150);
% plot(xh,(yh/max(yh))*100)
% plot(sg.logn.pdf.x.all,(sg.logn.pdf.y.all/max(sg.logn.pdf.y.all))*100,'-')

pe = interp1(CDFDATA(ind),DATASORT(ind),TH,'linear','extrap');
pd = interp1(CDFDATA(ind),DATASORT(ind),1-TH,'linear','extrap');
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
