function [V] = IP_family(xgrid,P,Q)

dx = diff(xgrid);
dx = dx(1);

IP.Innerproduct = sum(P.*Q)*dx;
IPf1 = ((P.*Q)./(P+Q))*dx;
IP.Harmonic = 2*sum(IPf1(~isnan(IPf1)&~isinf(IPf1)))*dx;
IP.Cosine = 1-(((sum(P.*Q)/(sqrt(sum(P.^2))*sqrt(sum(Q.^2))))))*dx;

V = (cell2mat(struct2cell(IP))');
    
end