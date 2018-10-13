function [BIN,nbin,C]= LHM(DATA,interp)

[ycdf,xcdf]=ecdf(DATA.sg.evt);
nEVT=length(DATA.sg.evt);

nbin=[2:sqrt(nEVT) round(nEVT/sqrt(nEVT)):nEVT/2 nEVT];
for ibin = 1:length(nbin);
    bin=nbin(ibin);
R = linspace(min(DATA.sg.evt),max(DATA.sg.evt),bin+1);
I=0;
for i=1:bin
    I=I + sum(DATA.sg.evt>=R(i) &  DATA.sg.evt<=R(i+1));
    CDFbin(i)=I/length(DATA.sg.evt);
end
d=diff(R); d=d(1)/2;
CDFrange = R(1:end-1)+d;

CDFgrid_bin=interp1(CDFrange,CDFbin,DATA.sg.pdf.truth.x,interp,'extrap');
[~,ind] = unique(xcdf);
CDFgrid_e=interp1(xcdf(ind),ycdf(ind),DATA.sg.pdf.truth.x,interp,'extrap');
% R(bin) = sum((diff(yh,2)/d)*(d*2));
C(ibin) = sum(abs(CDFgrid_bin-CDFgrid_e));
clear CDFbin
end
% C = C(nbin);
[~, iknee] = knee_pt(C,nbin);
BIN = nbin(iknee);
% plot(bin,C);hold on
% plot(bin(iknee),C(iknee),'sr');
% 
% plot(xcdf,ycdf)
% plot(DATA.sg.pdf.truth.x,CDFgrid_bin)

