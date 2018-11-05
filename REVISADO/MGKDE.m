function [Xpdf,Ypdf] = MGKDE(DATA,r,nPoint,h,est,bin_method,h_method)
% h_method = 'SV';
% est='ASH';
% bin_method='Rudemo';
% r=1;
% [h0]=h_hunter(DATA,[],0,'UCV');
% [h1]=h_hunter(DATA,[],1,'UCV');s
% h1 = ones(length(DATA.sg.evt),1)*h1;
% ho=h_hunter(DATA,[],h_method);
[~,himg] = PILOT(DATA,nPoint,est,bin_method,h_method,'SSE');



% [xest,yest] = ASHEST(DATA,bin_method);
% fx = interp1(xest,yest,DATA.sg.evt,'linear','extrap');
% lambda=exp((length(DATA.sg.evt)^-1)*sum(log(fx(fx~=0))));
% fpi = interp1(xest,yest,DATA.sg.evt,'linear','extrap');
% [hi1] = hSSE(h1,lambda,fpi);












% [~,xh.ss,h.ss] = ssvkernel(DATA.sg.evt);
% hiss = interp1(h.xss,h.ss,DATA.sg.evt,'linear','extrap');
%  plot(DATA.sg.evt,hiv,'.k');hold on
%   plot(DATA.sg.evt,hiss,'.r');hold on

[X,df] = dKDE(DATA,h.o,1,nPoint);
df = abs(df);
% plot(df); hold on;
% df = df/max(df);
dfi = interp1(X,df,DATA.sg.evt,'linear','extrap');
% dfi = dfi/max(dfi);
% fpiv = fpi/max(fpi);
% TH1 = dfi>0.15;
% TH2 = dfi>0.2 & dfi>0.18;
% himg= hiss;
% himg(TH1)=hi1(TH1);

% himg=himg./dfi;
% himg=(((hi1.*dfi)+(himg.*(1-dfi)))+(((hi1.*(1-fpiv))+(himg.*(fpiv)))))/2;
% himg=((hiss.*dfi)+(hiv.*(1-dfi)')');
% himg(TH2)=hiv(TH2)+hiss(TH2);

[Xpdf,Ypdf,~] = KDESSE(DATA.sg.evt,{himg},nPoint);
% himgs = smooth(himg,0.1,'lowess');
% figure

% %  df=abs(df)
%
% plot(DATA.sg.evt,himg,'.')
%
%  plot(DATA.sg.evt,hiv,'.k');hold on
%  plot(DATA.sg.evt,hiss,'.r');hold on
%  plot(DATA.sg.evt,himg,'ob');hold on
% %  plot(DATA.sg.evt,himgs,'oc');hold on
%  plot(DATA.sg.pdf.truth.x,DATA.sg.pdf.truth.y,'g');hold on
% plot(X,df);
% legend('VKDE','SS','MG','MGS','PDF','df')

end