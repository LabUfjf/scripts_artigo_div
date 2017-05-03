function [DIV] = calcDivHist(DATA,IND,TARGET,sg,bg,N)

for nv = 1:size(DATA,1);
    
    [xpdf,ypdf]=getAnalytical(sg,bg,nv);

    for cvtr = 1:N.BLOCKS;
        
        ind.TR.SG=find(TARGET.TR(cvtr,:)==1);
        ind.TR.BG=find(TARGET.TR(cvtr,:)==0);
        
        DATASG.TR=DATA(nv,IND.TR(cvtr,ind.TR.SG));
        DATABG.TR=DATA(nv,IND.TR(cvtr,ind.TR.BG));
        
        [x.tr.sg,y.tr.sg]=data_normalized(DATASG.TR,calcnbins(DATASG.TR,'fd'));
        [x.tr.bg,y.tr.bg]=data_normalized(DATABG.TR,calcnbins(DATASG.TR,'fd'));
        
        y.ptr.sg.all = interp1(x.tr.sg,y.tr.sg,xpdf.sg.eq.all,'nearest','extrap');
        y.ptr.bg.all = interp1(x.tr.bg,y.tr.bg,xpdf.bg.eq.all,'nearest','extrap');
        
        y.ptr.sg.head = interp1(x.tr.sg,y.tr.sg,xpdf.sg.eq.head,'nearest','extrap');
        y.ptr.bg.head = interp1(x.tr.bg,y.tr.bg,xpdf.bg.eq.head,'nearest','extrap');
        
        y.ptr.sg.tail = interp1(x.tr.sg,y.tr.sg,xpdf.sg.eq.tail,'nearest','extrap');
        y.ptr.bg.tail = interp1(x.tr.bg,y.tr.bg,xpdf.bg.eq.tail,'nearest','extrap');
        
        y.ptr.sg.deriv = interp1(x.tr.sg,y.tr.sg,xpdf.sg.eq.deriv,'nearest','extrap');
        y.ptr.bg.deriv = interp1(x.tr.bg,y.tr.bg,xpdf.bg.eq.deriv,'nearest','extrap');
        
%         [DIV.SG.all{nv}(cvtr,:)] = DFSelect(ypdf.sg.all,ypdf.sg.all);
        [DIV.SG.all{nv}(cvtr,:)] = DFSelect(y.ptr.sg.all,ypdf.sg.eq.all);
        [DIV.BG.all{nv}(cvtr,:)] = DFSelect(y.ptr.bg.all,ypdf.bg.eq.all);
        
        [DIV.SG.head{nv}(cvtr,:)] = DFSelect(y.ptr.sg.head,ypdf.sg.eq.head);
        [DIV.BG.head{nv}(cvtr,:)] = DFSelect(y.ptr.bg.head,ypdf.bg.eq.head);
        
        [DIV.SG.tail{nv}(cvtr,:)] = DFSelect(y.ptr.sg.tail,ypdf.sg.eq.tail);
        [DIV.BG.tail{nv}(cvtr,:)] = DFSelect(y.ptr.bg.tail,ypdf.bg.eq.tail);
        
        [DIV.SG.deriv{nv}(cvtr,:)] = DFSelect(y.ptr.sg.deriv,ypdf.sg.eq.deriv);
        [DIV.BG.deriv{nv}(cvtr,:)] = DFSelect(y.ptr.bg.deriv,ypdf.bg.eq.deriv);
    end
    
    
end