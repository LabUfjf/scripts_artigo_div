function [bin,Ah]=simplex(DATA,xgrid,binmax)
% f = 1.7863; %1.4826;% 1.4306
f=1.4826;
% f=1;
ygrid_old = zeros(size(xgrid));
for nbin=2:binmax    
    [yh,xh]=hist(DATA,nbin);
    yh = yh/area2d(xh,yh);
    yhgrid= ygrid_old - interp1(xh,yh,xgrid,'nearest','extrap');
%     plot(DATA.sg.pdf.truth.x,ygrid_old,'r',DATA.sg.pdf.truth.x,interp1(xh,yh,DATA.sg.pdf.truth.x,'nearest','extrap'),'k')
%     pause
%     close
    Ah(nbin) = area2d(xgrid,yhgrid);
    ygrid_old=interp1(xh,yh,xgrid,'nearest','extrap');
end
bin = round(find(Ah(2:end)==min(Ah(2:end)))/f);
bin=bin-1;

end