function [ef,fa,auc] = LH_ASH(DATA,IND,TARGET,opt,N)
M = 10;
npts = 2000;

for i = 1:length(opt.SG);
    
    for cvtr = 1:N.BLOCKS;
        
        for nv = 1:4;
            ind.TR.SG=find(TARGET.TR(cvtr,:)==1);
            ind.TR.BG=find(TARGET.TR(cvtr,:)==0);
            
            DATASG.TR=DATA(nv,IND.TR(cvtr,ind.TR.SG));
            DATABG.TR=DATA(nv,IND.TR(cvtr,ind.TR.BG));
            
            DATAALL=DATA(nv,IND.VAL(cvtr,:));
            
            range.SG = linspace(min([DATASG.TR]) ,max([DATASG.TR]),npts);
            range.BG = linspace(min([DATABG.TR]) ,max([DATABG.TR]),npts);
      
            [x.tr.sg,y.tr.sg]=ashNorm(DATASG.TR,M,opt.SG(nv,i));
            [x.tr.bg,y.tr.bg]=ashNorm(DATABG.TR,M,opt.BG(nv,i));
            
            y.hist.sg = interp1(x.tr.sg,y.tr.sg,range.SG,'nearest','extrap');
            y.hist.bg = interp1(x.tr.bg,y.tr.bg,range.BG,'nearest','extrap');
            
            Psg(nv,:) = interp1(range.SG,y.hist.sg,DATAALL,'nearest','extrap');
            Pbg(nv,:) = interp1(range.BG,y.hist.bg,DATAALL,'nearest','extrap');
            
        end
        Pvar.sg = Psg(1,:).*Psg(2,:).*Psg(3,:).*Psg(4,:);
        Pvar.bg = Pbg(1,:).*Pbg(2,:).*Pbg(3,:).*Pbg(4,:);
        DLvar=Pvar.sg./(Pvar.sg+Pvar.bg);
        DLvar(isnan(DLvar))=0.5;
        [auccv(cvtr),facv(cvtr,:),efcv(cvtr,:)] = fastAUC(logical(TARGET.VAL(cvtr,:))',DLvar',0);
        
    end
    ef.mean(i,:) = mean(efcv);
    ef.std(i,:) = std(efcv);
    fa.mean(i,:) = mean(facv);
    fa.std(i,:) = std(facv);
    auc.mean(i,:) = auccv;
    auc.std(i,:) = auccv;
end



