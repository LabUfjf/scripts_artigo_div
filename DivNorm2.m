function [NORM] = DivNorm2(DIV)

for nv = 1:5
    FT.SG=(abs(DIV.SG.tail{nv})+abs(DIV.SG.deriv{nv})+abs(DIV.SG.head{nv}));
    FT.BG=(abs(DIV.BG.tail{nv})+abs(DIV.BG.deriv{nv})+abs(DIV.BG.head{nv}));
    
    NORM.SG.tail{nv}=abs(DIV.SG.tail{nv})./FT.SG;
    NORM.SG.deriv{nv}=abs(DIV.SG.deriv{nv})./FT.SG;
    NORM.SG.head{nv}=abs(DIV.SG.head{nv})./FT.SG;
    
    NORM.BG.tail{nv}=abs(DIV.BG.tail{nv})./FT.BG;
    NORM.BG.deriv{nv}=abs(DIV.BG.deriv{nv})./FT.BG;
    NORM.BG.head{nv}=abs(DIV.BG.head{nv})./FT.BG;
   
end

end