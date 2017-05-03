function [DIV] = calcDivKDE3(DATA,sg)
npts = 2000;
type='nearest';

for nv = 1:size(DATA,1);
    
    xpdf.sg=sg.gauss.pdf.x;
    ypdf.sg=sg.gauss.pdf.y;
    
    [ind]=findregion2(xpdf);
        
    DATASG.TR=DATA(nv,:);
    
    [x.tr.sg.VAR,y.tr.sg.VAR]=kernelClean(DATASG.TR,npts,1);
    
    [x.tr.sg.FIX,y.tr.sg.FIX]=kernelCleanFix(DATASG.TR,npts,1);
    
    y.ptr.sg.all.VAR = interp1(x.tr.sg.VAR,y.tr.sg.VAR,xpdf.sg.eq.all,type,'extrap');
    
    y.ptr.sg.head.VAR = interp1(x.tr.sg.VAR,y.tr.sg.VAR,xpdf.sg.eq.head,type,'extrap');
    
    y.ptr.sg.tail.VAR = interp1(x.tr.sg.VAR,y.tr.sg.VAR,xpdf.sg.eq.tail,type,'extrap');
    
    y.ptr.sg.deriv.VAR = interp1(x.tr.sg.VAR,y.tr.sg.VAR,xpdf.sg.eq.deriv,type,'extrap');
    
    y.ptr.sg.all.FIX = interp1(x.tr.sg.FIX,y.tr.sg.FIX,xpdf.sg.eq.all,type,'extrap');
    
    y.ptr.sg.head.FIX = interp1(x.tr.sg.FIX,y.tr.sg.FIX,xpdf.sg.eq.head,type,'extrap');
    
    y.ptr.sg.tail.FIX = interp1(x.tr.sg.FIX,y.tr.sg.FIX,xpdf.sg.eq.tail,type,'extrap');
    
    y.ptr.sg.deriv.FIX = interp1(x.tr.sg.FIX,y.tr.sg.FIX,xpdf.sg.eq.deriv,type,'extrap');
    
    %%VARIAVEL
    
    [DIV.VAR.SG.all{nv}(:,:)] = DFSelect(y.ptr.sg.all.VAR,ypdf.sg.eq.all);
    
    %% FULL
    y.ptr.sg.headf.VAR=ypdf.sg.eq.all;
    
    y.ptr.sg.tailf.VAR=ypdf.sg.eq.all;
    
    y.ptr.sg.derivf.VAR=ypdf.sg.eq.all;
    
    y.ptr.sg.headf.VAR(ind.sg.head)=y.ptr.sg.head.VAR;
    
    y.ptr.sg.tailf.VAR(ind.sg.tail)=y.ptr.sg.tail.VAR;
    
    y.ptr.sg.derivf.VAR(ind.sg.deriv)=y.ptr.sg.deriv.VAR;
    
    [DIV.VAR.SG.head{nv}(:,:)] = DFSelect(y.ptr.sg.headf.VAR,ypdf.sg.eq.all);
    
    [DIV.VAR.SG.tail{nv}(:,:)] = DFSelect(y.ptr.sg.tailf.VAR,ypdf.sg.eq.all);
    
    [DIV.VAR.SG.deriv{nv}(:,:)] = DFSelect(y.ptr.sg.derivf.VAR,ypdf.sg.eq.all);
    
    %% FIT
    
    [DIV.VAR.SG.head{nv}(:,[5 6])] = DFSelect56(y.ptr.sg.head.VAR,ypdf.sg.eq.head);
    
    [DIV.VAR.SG.tail{nv}(:,[5 6])] = DFSelect56(y.ptr.sg.tail.VAR,ypdf.sg.eq.tail);
    
    [DIV.VAR.SG.deriv{nv}(:,[5 6])] = DFSelect56(y.ptr.sg.deriv.VAR,ypdf.sg.eq.deriv);
    
    
    %% FIXO
    [DIV.FIX.SG.all{nv}(:,:)] = DFSelect(y.ptr.sg.all.FIX,ypdf.sg.eq.all);
    
    %%FULL
    y.ptr.sg.headf.FIX=ypdf.sg.eq.all;
    
    y.ptr.sg.tailf.FIX=ypdf.sg.eq.all;
    
    y.ptr.sg.derivf.FIX=ypdf.sg.eq.all;
    
    y.ptr.sg.headf.FIX(ind.sg.head)=y.ptr.sg.head.FIX;
    
    y.ptr.sg.tailf.FIX(ind.sg.tail)=y.ptr.sg.tail.FIX;
    
    y.ptr.sg.derivf.FIX(ind.sg.deriv)=y.ptr.sg.deriv.FIX;
    
    [DIV.FIX.SG.head{nv}(:,:)] = DFSelect(y.ptr.sg.headf.FIX,ypdf.sg.eq.all);    
    [DIV.FIX.SG.tail{nv}(:,:)] = DFSelect(y.ptr.sg.tailf.FIX,ypdf.sg.eq.all);    
    [DIV.FIX.SG.deriv{nv}(:,:)] = DFSelect(y.ptr.sg.derivf.FIX,ypdf.sg.eq.all);    
    
    %% FIT
    
    [DIV.FIX.SG.head{nv}(:,[5 6])] = DFSelect56(y.ptr.sg.head.FIX,ypdf.sg.eq.head);    
    [DIV.FIX.SG.tail{nv}(:,[5 6])] = DFSelect56(y.ptr.sg.tail.FIX,ypdf.sg.eq.tail);    
    [DIV.FIX.SG.deriv{nv}(:,[5 6])] = DFSelect56(y.ptr.sg.deriv.FIX,ypdf.sg.eq.deriv);    
    
    
end