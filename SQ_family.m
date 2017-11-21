function [V] = SQ_family(xgrid,P,Q)

dx = diff(xgrid);
dx = dx(1);

SQ.Hellinger = sqrt(((1/2)*sum((sqrt(P)-sqrt(Q)).^2))*dx);

V = (cell2mat(struct2cell(SQ))');
    
end