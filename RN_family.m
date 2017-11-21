function [V] = RN_family(xgrid,P,Q)

dx = diff(xgrid);
dx = dx(1);


RN.ISB=(sum(P-Q))*dx;
RN.IV=(sum((P-Q).^2))*dx;

TESTDIV(xgrid,P,Q,(P-Q))

RN.MISE = RN.IV+(RN.ISB)^2;

V = (cell2mat(struct2cell(RN))');
    
end