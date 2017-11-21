function [V] = L2_family(xgrid,P,Q)

dx = diff(xgrid);
dx = dx(1);

L2f=(((P-Q).^2)./(P+Q))*dx;
L2.Squared = sqrt(sum(L2f(~isnan(L2f)&~isinf(L2f)))*dx);

L2f1 = P+Q;
L2f2 = (P.*Q);
L2f3 = (((P-Q).^2).*((L2f1(~isnan(L2f1)&~isinf(L2f1)))))./(L2f2(~isnan(L2f2)&~isinf(L2f2)));
L2.AddSym = sum(L2f3(~isnan(L2f3)&~isinf(L2f3)))*dx;

V = (cell2mat(struct2cell(L2))');
    
end