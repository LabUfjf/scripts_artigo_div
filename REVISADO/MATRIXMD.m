function M = MATRIXMD(P,Q,dx,mod)

M(1,:) = Pearson(P,Q,mod);
M(2,:) = Linf(P,Q);
M(3,:) = L2N(P,Q,dx,mod);
M(4,:) = Sorensen(P,Q,dx,mod);
M(5,:) = Gower(P,Q,dx,mod);
M(6,:) = IP(P,Q,dx,mod);
M(7,:) = Harmonic(P,Q,dx,mod);
M(8,:) = Cosine(P,Q,dx,mod);
M(9,:) = Hellinger(P,Q,dx,mod);
M(10,:) = Euclidean(P,Q,dx,mod);
M(11,:) = Squared(P,Q,dx,mod);
M(12,:) = ADDSym(P,Q,dx,mod);
M(13,:) = KL(P,Q,dx,mod);
M(14,:) = Taneja(P,Q,dx,mod);
M(15,:) = Kumar(P,Q,dx,mod);

end