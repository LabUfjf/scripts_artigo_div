function [opt] = pdf_hist(DATA,IND,TARGET,bins)

V = [];

for nv = 1:size(DATA,1);
% wb = waitbar(0,'Trabalhando...');
i=0;
for bin = bins;
    i = i+1;
    
    for cvtr = 1:10;        
        ind.TR.SG=find(TARGET.TR(cvtr,:)==1);
        ind.TR.BG=find(TARGET.TR(cvtr,:)==0);
        
        ind.TST.SG=find(TARGET.TST(cvtr,:)==1);
        ind.TST.BG=find(TARGET.TST(cvtr,:)==0);
        
        DATASG.TR=DATA(nv,IND.TR(cvtr,ind.TR.SG));
        DATABG.TR=DATA(nv,IND.TR(cvtr,ind.TR.BG));
        
        DATASG.TST=DATA(nv,IND.TST(cvtr,ind.TST.SG));
        DATABG.TST=DATA(nv,IND.TST(cvtr,ind.TST.BG));
        
        range.SG = linspace(min([DATASG.TR DATASG.TST]) ,max([DATASG.TR DATASG.TST]),2000);
        range.BG = linspace(min([DATABG.TR DATABG.TST]) ,max([DATABG.TR DATABG.TST]),2000);
        
        [x.tr.sg,y.tr.sg]=data_normalized(DATASG.TR,bin);
        [x.tst.sg,y.tst.sg]=data_normalized(DATASG.TST,bin);
        
        [x.tr.bg,y.tr.bg]=data_normalized(DATABG.TR,bin);
        [x.tst.bg,y.tst.bg]=data_normalized(DATABG.TST,bin);
        
        y.ptr.sg = interp1(x.tr.sg,y.tr.sg,range.SG,'nearest','extrap');
        y.ptst.sg = interp1(x.tst.sg,y.tst.sg,range.SG,'nearest','extrap');
        
        y.ptr.bg = interp1(x.tr.bg,y.tr.bg,range.BG,'nearest','extrap');
        y.ptst.bg = interp1(x.tst.bg,y.tst.bg,range.BG,'nearest','extrap');
        
        [DIV.SG(cvtr,:)] = DFSelect(y.ptr.sg,y.ptst.sg);
        [DIV.BG(cvtr,:)] = DFSelect(y.ptr.bg,y.ptst.bg);
        
        bias.sg = sum(y.ptr.sg-y.ptst.sg)/length(range.SG);
        variance.sg = var(y.ptr.sg-y.ptst.sg);
        %
        bias.bg = sum(y.ptr.bg-y.ptst.bg);
        variance.bg = var(y.ptr.bg-y.ptst.bg);
        %
        BM.SG(cvtr) = (bias.sg);
        VM.SG(cvtr) = (variance.sg);
        
        BM.BG(cvtr) = (bias.bg);
        VM.BG(cvtr) = (variance.bg);
        
    end
    
    Vbin = bins(1:i);
    VBM.SG(i)= mean(BM.SG);
    VVM.SG(i)=mean(VM.SG);
    VBM.BG(i)= mean(BM.BG);
    VVM.BG(i)=mean(VM.BG);   
    
    AMISE.SG(i)=(mean(BM.SG)^2)+mean(VM.SG);
    AMISE.BG(i)=(mean(BM.BG)^2)+mean(VM.BG);
    
    VDIV.SG(i,:)=mean(DIV.SG) ;
    VDIV.BG(i,:)=mean(DIV.BG) ;
    
            figure(2)
            subplot(2,2,1:2);plot(range.SG,y.ptr.sg,'k',range.SG,y.ptst.sg,'r')
            subplot(2,2,3);bar(range.SG,abs(y.ptr.sg-y.ptst.sg))
            subplot(2,2,4);bar(sum(y.ptr.sg-y.ptst.sg)/length(range.SG))
    
            figure(3)
            subplot(1,4,1);plot(Vbin,VBM.SG,'o:r'); title('Bias')
            subplot(1,4,2);plot(Vbin,VVM.SG,'o:k');  title('Variance')
            subplot(1,4,3);plot(Vbin,AMISE.SG,'o:b'); title('Bias² + Variance')
%             pause
            waitbar(i/length(bins))
end

% name = [{'LP-LInf'},{'LP-L2 Norm'},{'L1-Sorensen'},{'L1-Gower'},{'IP-Innerproduct'},{'IP-Harmonic'},{'IP-Cosine'},...
%     {'SQ-Hellinger'},{'L2-Squared'},{'L2-AddSym'},{'SH-Kullback'},{'CO-Kumar'}];
% cl = [{'+k'},{'+r'},{'+b'},{'+g'},{'+y'},{'+c'},{'+m'},{'ok'},{'or'},{'ob'},{'og'},{'oc'}];

% for ip = 1:12;
%     subplot(1,4,4);plot(Vbin,VDIV.SG(:,ip),[':' cl{ip}]); hold on
% end

% subplot(1,4,4); legend(name)
% close(wb)

for ib = 1:12
    if ib == 5 || ib == 6 || ib == 7
        opt.SG(nv,ib)=bins(find(VDIV.SG(:,ib)==max(VDIV.SG(:,ib))));
        opt.BG(nv,ib)=bins(find(VDIV.BG(:,ib)==max(VDIV.BG(:,ib))));
    else
        opt.SG(nv,ib)=bins(find(VDIV.SG(:,ib)==min(VDIV.SG(:,ib))));
        opt.BG(nv,ib)=bins(find(VDIV.BG(:,ib)==min(VDIV.BG(:,ib))));
    end
end

opt.SG(nv,13)=calcnbins(DATASG.TR,'fd');
opt.BG(nv,13)=calcnbins(DATABG.TR,'fd');

opt.SG(nv,14)=bins(find(AMISE.SG==min(AMISE.SG)));
opt.BG(nv,14)=bins(find(AMISE.BG==min(AMISE.BG)));
end
% figure
% [x,y.tr]=data_normalized(DATASG.TR,bins(find(VDIV(:,11)==min(VDIV(:,11)))));
% plot(x,y.tr,'k','DisplayName',['Binagem Ótima = ' num2str(bins(find(VDIV(:,11)==min(VDIV(:,11)))))])

end


