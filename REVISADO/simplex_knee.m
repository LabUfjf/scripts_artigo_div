function [BIN,nbin,Ah]=simplex_knee(DATA,binmax)
% f = 1.7863; %1.4826;% 1.4306
% f=1.4826;
% f=1;
ygrid_old = zeros(size(DATA.sg.pdf.truth.x));
for nbin=2:binmax    
    [yh,xh]=hist(DATA.sg.evt,nbin);
    yh = yh/area2d(xh,yh);
    yhgrid= ygrid_old - interp1(xh,yh,DATA.sg.pdf.truth.x,'nearest','extrap');
%     plot(DATA.sg.pdf.truth.x,ygrid_old,'r',DATA.sg.pdf.truth.x,interp1(xh,yh,DATA.sg.pdf.truth.x,'nearest','extrap'),'k')
%     pause
%     close
    Ah(nbin) = area2d(DATA.sg.pdf.truth.x,yhgrid);
    ygrid_old=interp1(xh,yh,DATA.sg.pdf.truth.x,'nearest','extrap');
end
nbin=2:binmax;
Ah=Ah(nbin);
% [~, iknee] = knee_pt(Ah,nbin);
% BIN = nbin(iknee);
ind = find(Ah==min(Ah));
BIN=nbin(ind);
% bin = round(find(Ah(2:end)==min(Ah(2:end)))/f);
% bin=bin-1;

end