function [V] = CO_family(xgrid,P,Q)

dx = diff(xgrid);
dx = dx(1);

COf=((P.^2-Q.^2).^2)./(2*(P.*Q).^(3/2));
CO.Kumar = sum(COf(~isnan(COf)&~isinf(COf)))*dx;

V = (cell2mat(struct2cell(CO))');
    
end