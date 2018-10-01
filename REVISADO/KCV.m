function [K] = KCV(x,h,r,type,METHOD,kind)

[Kraw] = kernel_function(x,type,kind);
switch METHOD
    case 'MLCV'
        K= Kraw;
    case 'UCV'     
        dK = diff(Kraw,r);
        d2K = diff(Kraw,2*r);
        CKK=symconv(dK, dK);
        FUCV = CKK-(2*d2K);
        K= FUCV;
    case 'BCV1'
        dK2 = diff(Kraw,r+2);
        CKK=symconv(dK2, dK2);
        K= (CKK);
    case 'BCV2'
        dK24 = diff(Kraw,2*r+4);
        K= (dK24);
    case 'CCV'
        dK = diff(Kraw,r);
        CKK=symconv(dK, dK);
        K= (CKK);
    case 'MCV'
        dK = diff(Kraw,r);
        CKK=symconv(dK, dK);
        d2K = diff(Kraw,2*r);
        d2r2K = diff(Kraw,(2*r)+2);
        K=(CKK-d2K-(mu(Kraw,0,2)*d2r2K));
    case 'TCV'
        dK = diff(Kraw,r);
        CKK=symconv(dK, dK);
        d2K = diff(Kraw,2*r);
        cn=1/length(x);       
        a = x;
        for i=1:length(a)            
            x = a(i);
            if abs(a(i))> cn/(h^((2*r)+1))
                K(i)=eval(CKK-d2K);
            else
                K(i)=0;
            end
        end
end


end