function [NORM] = DivNorm(DIV)

for nv = 1:5
    FT.hist.SG=(abs(DIV.hist.SG.tail{nv})+abs(DIV.hist.SG.deriv{nv})+abs(DIV.hist.SG.head{nv}));
    FT.hist.BG=(abs(DIV.hist.BG.tail{nv})+abs(DIV.hist.BG.deriv{nv})+abs(DIV.hist.BG.head{nv}));
    
    FT.ash.SG=(abs(DIV.ash.SG.tail{nv})+abs(DIV.ash.SG.deriv{nv})+abs(DIV.ash.SG.head{nv}));
    FT.ash.BG=(abs(DIV.ash.BG.tail{nv})+abs(DIV.ash.BG.deriv{nv})+abs(DIV.ash.BG.head{nv}));
    
    FT.PDF.FULL.SG=(abs(DIV.PDF.FULL.SG.tail{nv})+abs(DIV.PDF.FULL.SG.deriv{nv})+abs(DIV.PDF.FULL.SG.head{nv}));
    FT.PDF.FULL.BG=(abs(DIV.PDF.FULL.BG.tail{nv})+abs(DIV.PDF.FULL.BG.deriv{nv})+abs(DIV.PDF.FULL.BG.head{nv}));
    
    FT.PDF.FIT.SG=(abs(DIV.PDF.FIT.SG.tail{nv})+abs(DIV.PDF.FIT.SG.deriv{nv})+abs(DIV.PDF.FIT.SG.head{nv}));
    FT.PDF.FIT.BG=(abs(DIV.PDF.FIT.BG.tail{nv})+abs(DIV.PDF.FIT.BG.deriv{nv})+abs(DIV.PDF.FIT.BG.head{nv}));
    
    FT.KDE.SG.VAR=(abs(DIV.KDE.SG.VAR.tail{nv})+abs(DIV.KDE.SG.VAR.deriv{nv})+abs(DIV.KDE.SG.VAR.head{nv}));
    FT.KDE.BG.VAR=(abs(DIV.KDE.BG.VAR.tail{nv})+abs(DIV.KDE.BG.VAR.deriv{nv})+abs(DIV.KDE.BG.VAR.head{nv}));
    
    FT.KDE.SG.FIX=(abs(DIV.KDE.SG.FIX.tail{nv})+abs(DIV.KDE.SG.FIX.deriv{nv})+abs(DIV.KDE.SG.FIX.head{nv}));
    FT.KDE.BG.FIX=(abs(DIV.KDE.BG.FIX.tail{nv})+abs(DIV.KDE.BG.FIX.deriv{nv})+abs(DIV.KDE.BG.FIX.head{nv}));
    
    NORM.hist.SG.tail{nv}=abs(DIV.hist.SG.tail{nv})./FT.hist.SG;
    NORM.hist.SG.deriv{nv}=abs(DIV.hist.SG.deriv{nv})./FT.hist.SG;
    NORM.hist.SG.head{nv}=abs(DIV.hist.SG.head{nv})./FT.hist.SG;
    
    NORM.hist.BG.tail{nv}=abs(DIV.hist.BG.tail{nv})./FT.hist.BG;
    NORM.hist.BG.deriv{nv}=abs(DIV.hist.BG.deriv{nv})./FT.hist.BG;
    NORM.hist.BG.head{nv}=abs(DIV.hist.BG.head{nv})./FT.hist.BG;
    
    NORM.ash.SG.tail{nv}=abs(DIV.ash.SG.tail{nv})./FT.ash.SG;
    NORM.ash.SG.deriv{nv}=abs(DIV.ash.SG.deriv{nv})./FT.ash.SG;
    NORM.ash.SG.head{nv}=abs(DIV.ash.SG.head{nv})./FT.ash.SG;
    
    NORM.ash.BG.tail{nv}=abs(DIV.ash.BG.tail{nv})./FT.ash.BG;
    NORM.ash.BG.deriv{nv}=abs(DIV.ash.BG.deriv{nv})./FT.ash.BG;
    NORM.ash.BG.head{nv}=abs(DIV.ash.BG.head{nv})./FT.ash.BG;
    
    NORM.PDF.FULL.SG.tail{nv}=abs(DIV.PDF.FULL.SG.tail{nv})./FT.PDF.FULL.SG;
    NORM.PDF.FULL.SG.deriv{nv}=abs(DIV.PDF.FULL.SG.deriv{nv})./FT.PDF.FULL.SG;
    NORM.PDF.FULL.SG.head{nv}=abs(DIV.PDF.FULL.SG.head{nv})./FT.PDF.FULL.SG;
    
    NORM.PDF.FIT.SG.tail{nv}=abs(DIV.PDF.FIT.SG.tail{nv})./FT.PDF.FIT.SG;
    NORM.PDF.FIT.SG.deriv{nv}=abs(DIV.PDF.FIT.SG.deriv{nv})./FT.PDF.FIT.SG;
    NORM.PDF.FIT.SG.head{nv}=abs(DIV.PDF.FIT.SG.head{nv})./FT.PDF.FIT.SG;
    
    NORM.PDF.FULL.BG.tail{nv}=abs(DIV.PDF.FULL.BG.tail{nv})./FT.PDF.FULL.BG;
    NORM.PDF.FULL.BG.deriv{nv}=abs(DIV.PDF.FULL.BG.deriv{nv})./FT.PDF.FULL.BG;
    NORM.PDF.FULL.BG.head{nv}=abs(DIV.PDF.FULL.BG.head{nv})./FT.PDF.FULL.BG;
    
    NORM.PDF.FIT.BG.tail{nv}=abs(DIV.PDF.FIT.BG.tail{nv})./FT.PDF.FIT.BG;
    NORM.PDF.FIT.BG.deriv{nv}=abs(DIV.PDF.FIT.BG.deriv{nv})./FT.PDF.FIT.BG;
    NORM.PDF.FIT.BG.head{nv}=abs(DIV.PDF.FIT.BG.head{nv})./FT.PDF.FIT.BG;
    
    NORM.KDE.SG.VAR.tail{nv}=abs(DIV.KDE.SG.VAR.tail{nv})./FT.KDE.SG.VAR;
    NORM.KDE.SG.VAR.deriv{nv}=abs(DIV.KDE.SG.VAR.deriv{nv})./FT.KDE.SG.VAR;
    NORM.KDE.SG.VAR.head{nv}=abs(DIV.KDE.SG.VAR.head{nv})./FT.KDE.SG.VAR;
    
    NORM.KDE.BG.VAR.tail{nv}=abs(DIV.KDE.BG.VAR.tail{nv})./FT.KDE.BG.VAR;
    NORM.KDE.BG.VAR.deriv{nv}=abs(DIV.KDE.BG.VAR.deriv{nv})./FT.KDE.BG.VAR;
    NORM.KDE.BG.VAR.head{nv}=abs(DIV.KDE.BG.VAR.head{nv})./FT.KDE.BG.VAR;
    
    NORM.KDE.SG.FIX.tail{nv}=abs(DIV.KDE.SG.FIX.tail{nv})./FT.KDE.SG.FIX;
    NORM.KDE.SG.FIX.deriv{nv}=abs(DIV.KDE.SG.FIX.deriv{nv})./FT.KDE.SG.FIX;
    NORM.KDE.SG.FIX.head{nv}=abs(DIV.KDE.SG.FIX.head{nv})./FT.KDE.SG.FIX;
    
    NORM.KDE.BG.FIX.tail{nv}=abs(DIV.KDE.BG.FIX.tail{nv})./FT.KDE.BG.FIX;
    NORM.KDE.BG.FIX.deriv{nv}=abs(DIV.KDE.BG.FIX.deriv{nv})./FT.KDE.BG.FIX;
    NORM.KDE.BG.FIX.head{nv}=abs(DIV.KDE.BG.FIX.head{nv})./FT.KDE.BG.FIX;
end

end