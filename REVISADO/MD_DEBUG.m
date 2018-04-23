function [] = MD_DEBUG(xgrid,P,Q,MD,norm)
% xgrid=X.GRID;
% P=Y.GRID;
% Q=Y.TRUTH;
P=P(:,1:end-1)';
Q=Q(:,1:end-1)';
dx = diff(xgrid');

if strcmp(MD,'Pearson')
    DEBUG_Pearson(P,Q,xgrid,norm)
end

if strcmp(MD,'Sorensen')
    DEBUG_Sorensen(P,Q,dx,xgrid,norm)
end

if strcmp(MD,'IP')
    DEBUG_IP(P,Q,dx,xgrid,norm)
end

if strcmp(MD,'Harmonic')
    DEBUG_Harmonic(P,Q,dx,xgrid,norm)
end

if strcmp(MD,'Cosine')
    DEBUG_Cosine(P,Q,dx,xgrid,norm)
end

if strcmp(MD,'Linf')
    DEBUG_Linf(P,Q,xgrid,norm)
end

if strcmp(MD,'L2N')
    DEBUG_L2N(P,Q,dx,xgrid,norm)
end

if strcmp(MD,'Gower')
    DEBUG_Gower(P,Q,dx,xgrid,norm)
end

if strcmp(MD,'Hellinger')
    DEBUG_Hellinger(P,Q,dx,xgrid,norm)
end

if strcmp(MD,'Euclidean')
    DEBUG_Euclidean(P,Q,dx,xgrid,norm)
end

if strcmp(MD,'Squared')
    DEBUG_Squared(P,Q,dx,xgrid,norm)
end

if strcmp(MD,'AddSym')
    DEBUG_AddSym(P,Q,dx,xgrid,norm)
end

if strcmp(MD,'Kullback')
    DEBUG_Kullback(P,Q,dx,xgrid,norm)
end

if strcmp(MD,'Taneja')
    DEBUG_Taneja(P,Q,dx,xgrid,norm)
end

if strcmp(MD,'Kumar')
    DEBUG_Kumar(P,Q,dx,xgrid,norm)
end

end