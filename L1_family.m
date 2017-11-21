function [V] = L1_family(xgrid,P,Q)

dx = diff(xgrid);
dx = dx(1);

L1.Sorensen = (sum(abs(P-Q))/sum(abs(P+Q)))*dx;
L1.Gower = sum(abs(P-Q))*dx;

V = (cell2mat(struct2cell(L1))');
    
end