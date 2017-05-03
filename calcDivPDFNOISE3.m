function [DIV] = calcDivPDFNOISE3(DATA,sg,bins,i)

% sd=0;
sd = 0.00001;

for nv = 1:size(DATA,1);
    
    xpdf.sg=sg.gauss.pdf.x;
    ypdf.sg=sg.gauss.pdf.y;
    
    [~,ynoise,noise,ind]= ADDNOISE2(xpdf,ypdf,sd);
    [~,ynoisefit]= ADDNOISEFIT2(xpdf,ypdf,noise,ind);
    
    ind.l.tail=round(linspace(1,length(ynoisefit.sg.tail(1:(end/2))),bins.l.tail(i)));
    ind.r.tail=round(linspace(length(ynoisefit.sg.tail(1:(end/2)))+1,length(ynoisefit.sg.tail),bins.r.tail(i)));
    
    ind.l.head=round(linspace(1,length(ynoisefit.sg.head(1:(end/2))),bins.l.head(i)));
    ind.r.head=round(linspace(length(ynoisefit.sg.head(1:(end/2)))+1,length(ynoisefit.sg.head),bins.r.head(i)));
    
    ind.l.deriv=round(linspace(1,length(ynoisefit.sg.deriv(1:(end/2))),bins.l.deriv(i)));
    ind.r.deriv=round(linspace(length(ynoisefit.sg.deriv(1:(end/2)))+1,length(ynoisefit.sg.deriv),bins.r.deriv(i)));
    
    ytail = interp1(xpdf.sg.eq.tail([ind.l.tail ind.r.tail]),ynoisefit.sg.tail([ind.l.tail ind.r.tail]),xpdf.sg.eq.tail,'nearest','extrap');
    
    yderiv = interp1(xpdf.sg.eq.deriv([ind.l.deriv ind.r.deriv]),ynoisefit.sg.deriv([ind.l.deriv ind.r.deriv]),xpdf.sg.eq.deriv,'nearest','extrap');
    
    yhead = interp1(xpdf.sg.eq.head([ind.l.head ind.r.head]),ynoisefit.sg.head([ind.l.head ind.r.head]),xpdf.sg.eq.head,'nearest','extrap');
    
    [xteste,ia]=unique([xpdf.sg.eq.tail(ind.l.tail) xpdf.sg.eq.deriv(ind.l.deriv) xpdf.sg.eq.head(ind.l.head) xpdf.sg.eq.head(ind.r.head) xpdf.sg.eq.deriv(ind.r.deriv) xpdf.sg.eq.tail(ind.r.tail)]);
    
    yteste=([ynoisefit.sg.tail(ind.l.tail) ynoisefit.sg.deriv(ind.l.deriv) ynoisefit.sg.head(ind.l.head) ynoisefit.sg.head(ind.r.head) ynoisefit.sg.deriv(ind.r.deriv) ynoisefit.sg.tail(ind.r.tail)]);
    
    yall = interp1(xteste,yteste(ia),xpdf.sg.eq.all,'nearest','extrap');
    
    ynoise.sg.tail(ind.sg.tail)=ytail;
    ynoise.sg.deriv(ind.sg.deriv)=yderiv;
    ynoise.sg.head(ind.sg.head)=yhead;
    
    [DIV.SG.all{nv}(:,:)] = DFSelect(yall,ypdf.sg.eq.all);
    
    [DIV.SG.head{nv}(:,:)] = DFSelect(ynoise.sg.head,ypdf.sg.eq.all);
    
    [DIV.SG.tail{nv}(:,:)] = DFSelect(ynoise.sg.tail,ypdf.sg.eq.all);
    
    [DIV.SG.deriv{nv}(:,:)] = DFSelect(ynoise.sg.deriv,ypdf.sg.eq.all);
    
    %% NOISE FIT
    
    [DIV.SG.all{nv}(:,[5 6])] = DFSelect56(yall,ypdf.sg.eq.all);
    
    [DIV.SG.head{nv}(:,[5 6])] = DFSelect56(yhead,ypdf.sg.eq.head);
    
    [DIV.SG.tail{nv}(:,[5 6])] = DFSelect56(ytail,ypdf.sg.eq.tail);
    
    [DIV.SG.deriv{nv}(:,[5 6])] = DFSelect56(yderiv,ypdf.sg.eq.deriv);
    
    %% PLOTS
    
%     figure
%     plot(xpdf.sg.eq.all,ypdf.sg.eq.all,'.')
%     hold on
%     plot(xteste,yteste(ia),'r.')
%     plot(xpdf.sg.eq.all,yall,'.k')
%     title(['Number of Events = ' num2str(length(DATA))])
%     plot(x.tr.sg,y.tr.sg,'r.')
    
    
    
    
end