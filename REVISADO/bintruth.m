function [bin]=bintruth(DATA,out)

DADO = [reshape(DATA.sg.evt,length(DATA.sg.evt),1); out];
SN = 10;
binmax = 100;
for nbin=2:binmax
        [yh,xh]=hist(DADO,nbin);
        yh=yh/area2d(xh,yh);
        yhgrid=interp1(xh,yh,DATA.sg.pdf.truth.x,'nearest','extrap');
        A(nbin) = area2d(DATA.sg.pdf.truth.x,abs(DATA.sg.pdf.truth.y-yhgrid));
end

nbin=2:binmax;  
MA = A(nbin);

bin = find(MA==min(MA))+1;

end