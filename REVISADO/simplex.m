function [BIN,nbin,Ah]=simplex(DATA,binmax)
ygrid_old = zeros(size(DATA.sg.pdf.truth.x));
SN=50;
for nbin=1:binmax
    R = linspace(min(DATA.sg.evt),max(DATA.sg.evt),nbin+1);
    h=diff(R); h=h(1);
    step = linspace(0,h,SN);
    for s=1:SN
        [xh,yh]=data_normalized(DATA.sg.evt,R+step(s));
        yhgrid= ygrid_old - interp1(xh,yh,DATA.sg.pdf.truth.x,'nearest','extrap');
        %     plot(DATA.sg.pdf.truth.x,ygrid_old,'r',DATA.sg.pdf.truth.x,interp1(xh,yh,DATA.sg.pdf.truth.x,'nearest','extrap'),'k')
        %     pause
        %     close
        Ah(nbin,s) = area2d(DATA.sg.pdf.truth.x,yhgrid);
        ygrid_old=interp1(xh,yh,DATA.sg.pdf.truth.x,'nearest','extrap');
    end
end
nbin=1:binmax;
Ah=Ah(nbin);

ind = find(Ah==min(Ah));
BIN=nbin(ind);