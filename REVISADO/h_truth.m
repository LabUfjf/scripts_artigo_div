function [h] = h_truth(DATA,nPoint)
nd = 1;
ho = ((4/3)^(1/5))*(std(DATA.sg.evt)*DATA.sg.n.evt^(-1/5));
vTH=linspace(0.01*ho,5*ho,500);
wb = waitbar(0,'Calculating [h] truth...');
for TH = 1:length(vTH)
    h=vTH(TH)^2;  
    X = linspace(min(DATA.sg.evt),max(DATA.sg.evt),nPoint);
    [X,f] = KDEfixed(reshape(DATA.sg.evt,1,DATA.sg.n.evt),X,h,nPoint,DATA.sg.n.evt,nd);
    ygrid = interp1(X,f,DATA.sg.pdf.truth.x,'linear',0);
    C(TH)=sum(abs(ygrid-DATA.sg.pdf.truth.y));
    waitbar(TH/length(vTH))
end
close(wb)
 h=vTH(find(C==min(C)));