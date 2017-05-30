function [pe,pd,gridx] = cdfdata(DATASET,TH,npts)
% TH = 0.1
% TH = TH/100;
clear Y
DATASORT = sort(DATASET);
wb = waitbar(0,'Aguarde...')
for i = 1:length(DATASORT)
    CDFDATA(i) =  sum(DATASET <= DATASORT(i));
    %     CDFDATA(i) = Y(i);
    waitbar(i/length(DATASORT))
end
close(wb)

CDFDATA = 100*(CDFDATA/max(CDFDATA));
[~,ind]=unique(CDFDATA);

% plot(DATASORT,CDFDATA); hold on
% [yh,xh]=hist(DATASET,150);
% plot(xh,(yh/max(yh))*100)
% plot(sg.logn.pdf.x.all,(sg.logn.pdf.y.all/max(sg.logn.pdf.y.all))*100,'-')

pe = interp1(CDFDATA(ind),DATASORT(ind),TH,'nearest','extrap');
pd = interp1(CDFDATA(ind),DATASORT(ind),100-TH,'nearest','extrap');
% hist(DATASET,100)
%  plot(CDFDATA(ind),DATASORT(ind),'k'); hold on
%  plot([TH TH],[min(DATASORT(ind)) max(DATASORT(ind))],'-r',[100-TH 100-TH],[min(DATASORT(ind)) max(DATASORT(ind))],'-r')
gridx = interp1(CDFDATA(ind),DATASORT(ind),linspace(TH,1-TH,npts),'nearest','extrap');

% hist(DATASET(DATASET>pe & DATASET<pd),gridx)

end
