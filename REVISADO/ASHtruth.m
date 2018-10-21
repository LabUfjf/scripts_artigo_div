function [bin,MA,nbin]=ASHtruth(DATA,M,binmax,inter)

io=3;
for nbin=io:binmax
    [xash,yash] = ashN(DATA.sg.evt,M,inter,nbin);
    yhgrid=interp1(xash,yash,DATA.sg.pdf.truth.x,inter,0);
    A(nbin) = area2d(DATA.sg.pdf.truth.x,abs(DATA.sg.pdf.truth.y-yhgrid));
end

nbin=io:binmax;
MA = A(nbin);
bin = find(MA==min(MA))+io-1;

end