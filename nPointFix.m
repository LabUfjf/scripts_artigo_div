function [nPoint] = nPointFix(nPoint,Div,n,nd)
%==========================================================================
% FUNÇÃO PARA AJUSTAR O NÚMERO DE PONTOS DE ACORDO COM AS DIVISÕES DO 
% FASTKDE, PARA A DIVISÃO SER UM NÚMERO INTEIRO:
%==========================================================================
if nd == 1
    if n>=69998
        nPoint = nPoint - mod(nPoint,Div.L);
    else
        nPoint = nPoint - mod(nPoint,Div.S);
    end
    
else
    if n>20000
        nPoint = nPoint - mod(nPoint,Div.D);
    end
end

end