function [DIV] = calcDivKDE2(DATA,IND,TARGET,sg,bg,N)
npts = 2000;

for nv = 1:size(DATA,1);
    
    [xpdf,ypdf]=getAnalytical(sg,bg,nv);
    [ind]=findregion(xpdf);
    
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
        
        %%VARIAVEL
        
        [DIV.VAR.SG.all{nv}(cvtr,:)] = DFSelect(y.ptr.sg.all.VAR,ypdf.sg.eq.all);
        [DIV.VAR.BG.all{nv}(cvtr,:)] = DFSelect(y.ptr.bg.all.VAR,ypdf.bg.eq.all);
        
        %% FULL
        y.ptr.sg.headf.VAR=ypdf.sg.eq.all;
        y.ptr.bg.headf.VAR=ypdf.bg.eq.all;
        
        y.ptr.sg.tailf.VAR=ypdf.sg.eq.all;
        y.ptr.bg.tailf.VAR=ypdf.bg.eq.all;
        
        y.ptr.sg.derivf.VAR=ypdf.sg.eq.all;
        y.ptr.bg.derivf.VAR=ypdf.bg.eq.all;
        
        y.ptr.sg.headf.VAR(ind.sg.head)=y.ptr.sg.head.VAR;
        y.ptr.bg.headf.VAR(ind.bg.head)=y.ptr.bg.head.VAR;
        
        y.ptr.sg.tailf.VAR(ind.sg.tail)=y.ptr.sg.tail.VAR;
        y.ptr.bg.tailf.VAR(ind.bg.tail)=y.ptr.bg.tail.VAR;
        
        y.ptr.sg.derivf.VAR(ind.sg.deriv)=y.ptr.sg.deriv.VAR;
        y.ptr.bg.derivf.VAR(ind.bg.deriv)=y.ptr.bg.deriv.VAR;
        
        [DIV.VAR.SG.head{nv}(cvtr,:)] = DFSelect(y.ptr.sg.headf.VAR,ypdf.sg.eq.all);
        [DIV.VAR.BG.head{nv}(cvtr,:)] = DFSelect(y.ptr.bg.headf.VAR,ypdf.bg.eq.all);
        
        [DIV.VAR.SG.tail{nv}(cvtr,:)] = DFSelect(y.ptr.sg.tailf.VAR,ypdf.sg.eq.all);
        [DIV.VAR.BG.tail{nv}(cvtr,:)] = DFSelect(y.ptr.bg.tailf.VAR,ypdf.bg.eq.all);
        
        [DIV.VAR.SG.deriv{nv}(cvtr,:)] = DFSelect(y.ptr.sg.derivf.VAR,ypdf.sg.eq.all);
        [DIV.VAR.BG.deriv{nv}(cvtr,:)] = DFSelect(y.ptr.bg.derivf.VAR,ypdf.bg.eq.all);
        
        %% FIT
        
        [DIV.VAR.SG.head{nv}(cvtr,[5 6])] = DFSelect56(y.ptr.sg.head.VAR,ypdf.sg.eq.head);
        [DIV.VAR.BG.head{nv}(cvtr,[5 6])] = DFSelect56(y.ptr.bg.head.VAR,ypdf.bg.eq.head);
        
        [DIV.VAR.SG.tail{nv}(cvtr,[5 6])] = DFSelect56(y.ptr.sg.tail.VAR,ypdf.sg.eq.tail);
        [DIV.VAR.BG.tail{nv}(cvtr,[5 6])] = DFSelect56(y.ptr.bg.tail.VAR,ypdf.bg.eq.tail);
        
        [DIV.VAR.SG.deriv{nv}(cvtr,[5 6])] = DFSelect56(y.ptr.sg.deriv.VAR,ypdf.sg.eq.deriv);
        [DIV.VAR.BG.deriv{nv}(cvtr,[5 6])] = DFSelect56(y.ptr.bg.deriv.VAR,ypdf.bg.eq.deriv);
        
        
        %% FIXO
        [DIV.FIX.SG.all{nv}(cvtr,:)] = DFSelect(y.ptr.sg.all.FIX,ypdf.sg.eq.all);
        [DIV.FIX.BG.all{nv}(cvtr,:)] = DFSelect(y.ptr.bg.all.FIX,ypdf.bg.eq.all);
        
        %%FULL
        y.ptr.sg.headf.FIX=ypdf.sg.eq.all;
        y.ptr.bg.headf.FIX=ypdf.bg.eq.all;
        
        y.ptr.sg.tailf.FIX=ypdf.sg.eq.all;
        y.ptr.bg.tailf.FIX=ypdf.bg.eq.all;
        
        y.ptr.sg.derivf.FIX=ypdf.sg.eq.all;
        y.ptr.bg.derivf.FIX=ypdf.bg.eq.all;
        
        y.ptr.sg.headf.FIX(ind.sg.head)=y.ptr.sg.head.FIX;
        y.ptr.bg.headf.FIX(ind.bg.head)=y.ptr.bg.head.FIX;
        
        y.ptr.sg.tailf.FIX(ind.sg.tail)=y.ptr.sg.tail.FIX;
        y.ptr.bg.tailf.FIX(ind.bg.tail)=y.ptr.bg.tail.FIX;
        
        y.ptr.sg.derivf.FIX(ind.sg.deriv)=y.ptr.sg.deriv.FIX;
        y.ptr.bg.derivf.FIX(ind.bg.deriv)=y.ptr.bg.deriv.FIX;
        
        [DIV.FIX.SG.head{nv}(cvtr,:)] = DFSelect(y.ptr.sg.headf.FIX,ypdf.sg.eq.all);
        [DIV.FIX.BG.head{nv}(cvtr,:)] = DFSelect(y.ptr.bg.headf.FIX,ypdf.bg.eq.all);
        
        [DIV.FIX.SG.tail{nv}(cvtr,:)] = DFSelect(y.ptr.sg.tailf.FIX,ypdf.sg.eq.all);
        [DIV.FIX.BG.tail{nv}(cvtr,:)] = DFSelect(y.ptr.bg.tailf.FIX,ypdf.bg.eq.all);
        
        [DIV.FIX.SG.deriv{nv}(cvtr,:)] = DFSelect(y.ptr.sg.derivf.FIX,ypdf.sg.eq.all);
        [DIV.FIX.BG.deriv{nv}(cvtr,:)] = DFSelect(y.ptr.bg.derivf.FIX,ypdf.bg.eq.all);
        
        
        %% FIT
        
        [DIV.FIX.SG.head{nv}(cvtr,[5 6])] = DFSelect56(y.ptr.sg.head.FIX,ypdf.sg.eq.head);
        [DIV.FIX.BG.head{nv}(cvtr,[5 6])] = DFSelect56(y.ptr.bg.head.FIX,ypdf.bg.eq.head);
        
        [DIV.FIX.SG.tail{nv}(cvtr,[5 6])] = DFSelect56(y.ptr.sg.tail.FIX,ypdf.sg.eq.tail);
        [DIV.FIX.BG.tail{nv}(cvtr,[5 6])] = DFSelect56(y.ptr.bg.tail.FIX,ypdf.bg.eq.tail);
        
        [DIV.FIX.SG.deriv{nv}(cvtr,[5 6])] = DFSelect56(y.ptr.sg.deriv.FIX,ypdf.sg.eq.deriv);
        [DIV.FIX.BG.deriv{nv}(cvtr,[5 6])] = DFSelect56(y.ptr.bg.deriv.FIX,ypdf.bg.eq.deriv);
    end
    
    figure(nv)
    hold on
    plot(x.tr.sg.FIX,y.tr.sg.FIX) 
    hold on
    plot(x.tr.sg.VAR,y.tr.sg.VAR)
    
    
    
    
end