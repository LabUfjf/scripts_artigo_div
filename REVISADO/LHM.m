function [BIN,nbin,C]= LHM(DATA,interp)

[ycdf,xcdf]=ecdf(DATA);
nEVT=length(DATA);
x = linspace(min(DATA),max(DATA),10^5);
% nbin=[2:sqrt(nEVT) round(nEVT/sqrt(nEVT)):nEVT/4 nEVT];
nbin=[2:50 floor(linspace(50+1,nEVT,100))];
for ibin = 1:length(nbin);
    bin=nbin(ibin);
R = linspace(min(DATA),max(DATA),bin+1);
I=0;
for i=1:bin
    I=I + sum(DATA>=R(i) &  DATA<=R(i+1));
    CDFbin(i)=I/length(DATA);
end
d=diff(R); d=d(1)/2;
CDFrange = R(1:end-1)+d;

CDFgrid_bin=interp1(CDFrange,CDFbin,x,interp,'extrap');
[~,ind] = unique(xcdf);
CDFgrid_e=interp1(xcdf(ind),ycdf(ind),x,interp,'extrap');
C(ibin) = sum(abs(CDFgrid_bin-CDFgrid_e));
clear CDFbin
end
[~, iknee] = knee_pt(C,nbin);
BIN = nbin(iknee);


