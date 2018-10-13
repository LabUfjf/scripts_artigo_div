function [bin,info,nbin] =binopt(out,ntmax,setup)
binmax=500;
wb = waitbar(0,'Doing Optimal Binning...');
for nt=1:ntmax
[DATA] = datasetGenSingle(setup);
for nbin=2:binmax    
    [yh,xh]=hist([reshape(DATA.sg.evt,length(DATA.sg.evt),1); out],nbin);
    yh=yh/area2d(xh,yh);
    yhgrid=interp1(xh,yh,DATA.sg.pdf.truth.x,'nearest','extrap');
    A(nbin,nt) = area2d(DATA.sg.pdf.truth.x,abs(DATA.sg.pdf.truth.y-yhgrid));
end
waitbar(nt/ntmax)
end
nbin=2:binmax;  
close(wb)
MA = A(nbin,:);

for i = 1:size(MA,2)
    ind(i) = find(MA(:,i)==min(MA(:,i)));
end
info.SA = std(A(nbin,:)');
info.MA = mean(A(nbin,:)'); 
bin=round(mean(ind));