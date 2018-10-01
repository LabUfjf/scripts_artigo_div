function [bin,info,nbin] =binopt(DATA,out,ntmax,name,setup)
binmax=1000;
wb = waitbar(0,'Doing Optimal Binning...');
for nt=1:ntmax
[DATA] = datasetGenSingle(setup);
for nbin=2:binmax    
    [yh,xh]=hist([DATA.sg.evt; out],nbin);
    yh=yh/area2d(xh,yh);
    yhgrid=interp1(xh,yh,DATA.sg.pdf.truth.x,'nearest','extrap');
    A(nbin,nt) = area2d(DATA.sg.pdf.truth.x,abs(DATA.sg.pdf.truth.y-yhgrid));
end
waitbar(nt/ntmax)
end
nbin=2:binmax;  
close(wb)
MA = mean(A(nbin,:)');
info.SA = std(A(nbin,:)');
info.MA = mean(A(nbin,:)'); ind = find(MA==min(MA));
bin=ind;