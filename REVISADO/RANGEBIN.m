function [A,binrange]=RANGEBIN(DATA,binrange)

for nbin=binrange
        [yh,xh]=hist(DATA.sg.evt,nbin);
        yh=yh/area2d(xh,yh);
        yhgrid=interp1(xh,yh,DATA.sg.pdf.truth.x,'linear',0);
        A(nbin) = area2d(DATA.sg.pdf.truth.x,abs(DATA.sg.pdf.truth.y-yhgrid));
end
nbin=2:binmax;  
MA = A(nbin);


end