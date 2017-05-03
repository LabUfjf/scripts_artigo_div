function [DIV] = calcDivPDFNOISE(DATA,sg,bg,N)

% sd=0;
sd = 0.00001;

for nv = 1:size(DATA,1);
    
    [xpdf,ypdf]=getAnalytical(sg,bg,nv);
    
    for cvtr = 1:N.BLOCKS;
        
        [~,ynoise,noise,ind]= ADDNOISE(xpdf,ypdf,sd);
        [~,ynoisefit]= ADDNOISEFIT(xpdf,ypdf,noise,ind);
        
        [DIV.SG.all{nv}(cvtr,:)] = DFSelect(ynoise.sg.all,ypdf.sg.eq.all);
        [DIV.BG.all{nv}(cvtr,:)] = DFSelect(ynoise.bg.all,ypdf.bg.eq.all);
        
        [DIV.SG.head{nv}(cvtr,:)] = DFSelect(ynoise.sg.head,ypdf.sg.eq.all);
        [DIV.BG.head{nv}(cvtr,:)] = DFSelect(ynoise.bg.head,ypdf.bg.eq.all);
        
        [DIV.SG.tail{nv}(cvtr,:)] = DFSelect(ynoise.sg.tail,ypdf.sg.eq.all);
        [DIV.BG.tail{nv}(cvtr,:)] = DFSelect(ynoise.bg.tail,ypdf.bg.eq.all);
        
        [DIV.SG.deriv{nv}(cvtr,:)] = DFSelect(ynoise.sg.deriv,ypdf.sg.eq.all);
        [DIV.BG.deriv{nv}(cvtr,:)] = DFSelect(ynoise.bg.deriv,ypdf.bg.eq.all);
        
        %% NOISE FIT
        
        [DIV.SG.all{nv}(cvtr,[5 6])] = DFSelect56(ynoisefit.sg.all,ypdf.sg.eq.all);
        [DIV.BG.all{nv}(cvtr,[5 6])] = DFSelect56(ynoisefit.bg.all,ypdf.bg.eq.all);
        
        [DIV.SG.head{nv}(cvtr,[5 6])] = DFSelect56(ynoisefit.sg.head,ypdf.sg.eq.head);
        [DIV.BG.head{nv}(cvtr,[5 6])] = DFSelect56(ynoisefit.bg.head,ypdf.bg.eq.head);
        
        [DIV.SG.tail{nv}(cvtr,[5 6])] = DFSelect56(ynoisefit.sg.tail,ypdf.sg.eq.tail);
        [DIV.BG.tail{nv}(cvtr,[5 6])] = DFSelect56(ynoisefit.bg.tail,ypdf.bg.eq.tail);
        
        [DIV.SG.deriv{nv}(cvtr,[5 6])] = DFSelect56(ynoisefit.sg.deriv,ypdf.sg.eq.deriv);
        [DIV.BG.deriv{nv}(cvtr,[5 6])] = DFSelect56(ynoisefit.bg.deriv,ypdf.bg.eq.deriv);
        
    end
    
    
end