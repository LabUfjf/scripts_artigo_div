function [NORMt, NORMd, NORMh] = DivNorm3(DIV)

for nv = 1
    FT.SG=(abs(DIV.SG.tail{nv})+abs(DIV.SG.deriv{nv})+abs(DIV.SG.head{nv}));
    NORMt=abs(DIV.SG.tail{nv})./FT.SG;
    NORMd=abs(DIV.SG.deriv{nv})./FT.SG;
    NORMh=abs(DIV.SG.head{nv})./FT.SG;
    
    
    
end

end