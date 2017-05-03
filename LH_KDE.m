function [ef,fa,auc,sp] = LH_KDE(DATA,IND,TARGET,opt,N)


for i = 1:length(opt.SG)+1;
    
    for cvtr = 1:N.BLOCKS;
        
        for nv = 1:4;
            
            
            ind.VAL.SG=find(TARGET.VAL(cvtr,:)==1);
            ind.VAL.BG=find(TARGET.VAL(cvtr,:)==0);
            
            ind.TR.SG=find(TARGET.TR(cvtr,:)==1);
            ind.TR.BG=find(TARGET.TR(cvtr,:)==0);
            
            DATASG.TR=DATA(nv,IND.TR(cvtr,ind.TR.SG));
            DATABG.TR=DATA(nv,IND.TR(cvtr,ind.TR.BG));
            
            DATAALL=DATA(nv,IND.VAL(cvtr,:));
            
            range.SG = linspace(min([DATASG.TR]) ,max([DATASG.TR]),2000);
            range.BG = linspace(min([DATABG.TR]) ,max([DATABG.TR]),2000);
            
            if i<(length(opt.SG)+1)
            [x.tr.sg,y.tr.sg] = kernelClean(DATASG.TR,2000,opt.SG(nv,i),1);
            [x.tr.bg,y.tr.bg] = kernelClean(DATABG.TR,2000,opt.BG(nv,i),1);
            else
            [x.tr.sg,y.tr.sg] = kernelCleanFix(DATASG.TR,2000,1);
            [x.tr.bg,y.tr.bg] = kernelCleanFix(DATABG.TR,2000,1);
            end
%             subplot(2,2,nv);plot(x.tr.sg,y.tr.sg,'k',x.tr.bg,y.tr.bg,'r'); hold on            
            Psg(nv,:) = interp1(x.tr.sg,y.tr.sg,DATAALL,'nearest','extrap');
            Pbg(nv,:) = interp1(x.tr.bg,y.tr.bg,DATAALL,'nearest','extrap');
            disp(['[KDE][BIN=' num2str((i/length(opt.SG))*100) '%][CV='  num2str((cvtr/N.BLOCKS)*100) '%][VAR='  num2str((nv/4)*100) '%]'])
            
        end
        
        Pvar.sg = Psg(1,:).*Psg(2,:).*Psg(3,:).*Psg(4,:);
        Pvar.bg = Pbg(1,:).*Pbg(2,:).*Pbg(3,:).*Pbg(4,:);
        DLvar=Pvar.sg./(Pvar.sg+Pvar.bg);
        DLvar(isnan(DLvar))=0.5;
        [auccv(cvtr),facv(cvtr,:),efcv(cvtr,:)] = fastAUC(logical(TARGET.VAL(cvtr,:))',DLvar',0);
        [bspcv(cvtr)] = best_sp(efcv(cvtr,:),facv(cvtr,:),length(ind.VAL.SG),length(ind.VAL.BG));
    end
%     pause
    ef.mean(i,:) = mean(efcv);
    ef.std(i,:) = std(efcv);
    fa.mean(i,:) = mean(facv);
    fa.std(i,:) = std(facv);
    auc.mean(i,:) = auccv;
    sp.mean(i,:) = bspcv;
    
    
end



