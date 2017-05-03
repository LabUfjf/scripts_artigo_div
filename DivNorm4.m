function [NORMt, NORMd, NORMh] = DivNorm4(DIV)
nv=1;
    NORMt=abs(DIV.SG.tail{nv});
    NORMd=abs(DIV.SG.deriv{nv});
    NORMh=abs(DIV.SG.head{nv});
    
    
end