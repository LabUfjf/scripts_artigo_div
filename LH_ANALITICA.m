function [ef,fa,auc,sp] = LH_ANALITICA(DATA,IND,TARGET,sg,bg,N)

for cvtr = 1:N.BLOCKS;
    
    M = DATA(:,IND.VAL(cvtr,:));
    ind.VAL.SG=find(TARGET.VAL(cvtr,:)==1);
    ind.VAL.BG=find(TARGET.VAL(cvtr,:)==0);
    p.sg.normal = (normpdf(M(1,:),sg.normal.g1.mu,sg.normal.g1.std) + normpdf(M(1,:),sg.normal.g2.mu,sg.normal.g2.std))/2;
    p.bg.normal = (normpdf(M(1,:),bg.normal.g1.mu,bg.normal.g1.std) + normpdf(M(1,:),bg.normal.g2.mu,bg.normal.g2.std))/2;
    
    p.sg.rayleigh = raylpdf(M(2,:),sg.rayleigh.b);
    p.bg.rayleigh = raylpdf(M(2,:),bg.rayleigh.b);
    
    p.sg.logn = lognpdf(M(3,:),sg.logn.mu,sg.logn.std);
    p.bg.logn = lognpdf(M(3,:),bg.logn.mu,bg.logn.std);
    
    p.sg.gamma = gampdf(M(4,:),sg.gamma.A,sg.gamma.B);
    p.bg.gamma = gampdf(M(4,:),bg.gamma.A,bg.gamma.B);
    
    Lsg = p.sg.normal.*p.sg.rayleigh.*p.sg.logn.*p.sg.gamma;
    Lbg = p.bg.normal.*p.bg.rayleigh.*p.bg.logn.*p.bg.gamma;
    
    DL = Lsg./(Lsg+Lbg);
    [auccv(cvtr),facv(cvtr,:),efcv(cvtr,:)] = fastAUC(logical(TARGET.VAL(cvtr,:))',DL',0);
    [bspcv(cvtr)] = best_sp(efcv(cvtr,:),facv(cvtr,:),length(ind.VAL.SG),length(ind.VAL.BG));
end

ef.mean = mean(efcv);
ef.std = std(efcv);
fa.mean = mean(facv);
fa.std = std(facv);
auc.mean = auccv;
sp.mean = bspcv;

end