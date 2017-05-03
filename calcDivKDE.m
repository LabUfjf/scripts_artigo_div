function [DIV] = calcDivKDE(DATA,IND,TARGET,sg,bg,N)
npts = 2000;

for nv = 1:size(DATA,1);
    
    [xpdf,ypdf]=getAnalytical(sg,bg,nv);
    
    for cvtr = 1:N.BLOCKS;
        
        ind.TR.SG=find(TARGET.TR(cvtr,:)==1);
        ind.TR.BG=find(TARGET.TR(cvtr,:)==0);
        
        DATASG.TR=DATA(nv,IND.TR(cvtr,ind.TR.SG));
        DATABG.TR=DATA(nv,IND.TR(cvtr,ind.TR.BG));
        
        [x.tr.sg.VAR,y.tr.sg.VAR]=kernelClean(DATASG.TR,npts,1);
        [x.tr.bg.VAR,y.tr.bg.VAR]=kernelClean(DATABG.TR,npts,1);
        
        [x.tr.sg.FIX,y.tr.sg.FIX]=kernelCleanFix(DATASG.TR,npts,1);
        [x.tr.bg.FIX,y.tr.bg.FIX]=kernelCleanFix(DATABG.TR,npts,1);
        
        y.ptr.sg.all.VAR = interp1(x.tr.sg.VAR,y.tr.sg.VAR,xpdf.sg.eq.all,'nearest','extrap');
        y.ptr.bg.all.VAR = interp1(x.tr.bg.VAR,y.tr.bg.VAR,xpdf.bg.eq.all,'nearest','extrap');
        
        y.ptr.sg.head.VAR = interp1(x.tr.sg.VAR,y.tr.sg.VAR,xpdf.sg.eq.head,'nearest','extrap');
        y.ptr.bg.head.VAR = interp1(x.tr.bg.VAR,y.tr.bg.VAR,xpdf.bg.eq.head,'nearest','extrap');
        
        y.ptr.sg.tail.VAR = interp1(x.tr.sg.VAR,y.tr.sg.VAR,xpdf.sg.eq.tail,'nearest','extrap');
        y.ptr.bg.tail.VAR = interp1(x.tr.bg.VAR,y.tr.bg.VAR,xpdf.bg.eq.tail,'nearest','extrap');
        
        y.ptr.sg.deriv.VAR = interp1(x.tr.sg.VAR,y.tr.sg.VAR,xpdf.sg.eq.deriv,'nearest','extrap');
        y.ptr.bg.deriv.VAR = interp1(x.tr.bg.VAR,y.tr.bg.VAR,xpdf.bg.eq.deriv,'nearest','extrap');
        
        y.ptr.sg.all.FIX = interp1(x.tr.sg.FIX,y.tr.sg.FIX,xpdf.sg.eq.all,'nearest','extrap');
        y.ptr.bg.all.FIX = interp1(x.tr.bg.FIX,y.tr.bg.FIX,xpdf.bg.eq.all,'nearest','extrap');
        
        y.ptr.sg.head.FIX = interp1(x.tr.sg.FIX,y.tr.sg.FIX,xpdf.sg.eq.head,'nearest','extrap');
        y.ptr.bg.head.FIX = interp1(x.tr.bg.FIX,y.tr.bg.FIX,xpdf.bg.eq.head,'nearest','extrap');
        
        y.ptr.sg.tail.FIX = interp1(x.tr.sg.FIX,y.tr.sg.FIX,xpdf.sg.eq.tail,'nearest','extrap');
        y.ptr.bg.tail.FIX = interp1(x.tr.bg.FIX,y.tr.bg.FIX,xpdf.bg.eq.tail,'nearest','extrap');
        
        y.ptr.sg.deriv.FIX = interp1(x.tr.sg.FIX,y.tr.sg.FIX,xpdf.sg.eq.deriv,'nearest','extrap');
        y.ptr.bg.deriv.FIX = interp1(x.tr.bg.FIX,y.tr.bg.FIX,xpdf.bg.eq.deriv,'nearest','extrap');
        
        [DIV.SG.VAR.all{nv}(cvtr,:)] = DFSelect(y.ptr.sg.all.VAR,ypdf.sg.eq.all);
        [DIV.BG.VAR.all{nv}(cvtr,:)] = DFSelect(y.ptr.bg.all.VAR,ypdf.bg.eq.all);
        
        [DIV.SG.VAR.head{nv}(cvtr,:)] = DFSelect(y.ptr.sg.head.VAR,ypdf.sg.eq.head);
        [DIV.BG.VAR.head{nv}(cvtr,:)] = DFSelect(y.ptr.bg.head.VAR,ypdf.bg.eq.head);
        
        [DIV.SG.VAR.tail{nv}(cvtr,:)] = DFSelect(y.ptr.sg.tail.VAR,ypdf.sg.eq.tail);
        [DIV.BG.VAR.tail{nv}(cvtr,:)] = DFSelect(y.ptr.bg.tail.VAR,ypdf.bg.eq.tail);
        
        [DIV.SG.VAR.deriv{nv}(cvtr,:)] = DFSelect(y.ptr.sg.deriv.VAR,ypdf.sg.eq.deriv);
        [DIV.BG.VAR.deriv{nv}(cvtr,:)] = DFSelect(y.ptr.bg.deriv.VAR,ypdf.bg.eq.deriv);
        
        [DIV.SG.FIX.all{nv}(cvtr,:)] = DFSelect(y.ptr.sg.all.FIX,ypdf.sg.eq.all);
        [DIV.BG.FIX.all{nv}(cvtr,:)] = DFSelect(y.ptr.bg.all.FIX,ypdf.bg.eq.all);
        
        [DIV.SG.FIX.head{nv}(cvtr,:)] = DFSelect(y.ptr.sg.head.FIX,ypdf.sg.eq.head);
        [DIV.BG.FIX.head{nv}(cvtr,:)] = DFSelect(y.ptr.bg.head.FIX,ypdf.bg.eq.head);
        
        [DIV.SG.FIX.tail{nv}(cvtr,:)] = DFSelect(y.ptr.sg.tail.FIX,ypdf.sg.eq.tail);
        [DIV.BG.FIX.tail{nv}(cvtr,:)] = DFSelect(y.ptr.bg.tail.FIX,ypdf.bg.eq.tail);
        
        [DIV.SG.FIX.deriv{nv}(cvtr,:)] = DFSelect(y.ptr.sg.deriv.FIX,ypdf.sg.eq.deriv);
        [DIV.BG.FIX.deriv{nv}(cvtr,:)] = DFSelect(y.ptr.bg.deriv.FIX,ypdf.bg.eq.deriv);
    end
    
    
end