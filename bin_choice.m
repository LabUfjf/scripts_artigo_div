function [opt] = bin_choice(DATA,IND,TARGET,N)

cv = N.BLOCKS;
  wb = waitbar(0,'Trabalhando...');
for nv = 1:size(DATA,1); 

    for cvtr = 1:cv;
        
        ind.TR.SG=find(TARGET.TR(cvtr,:)==1);
        ind.TR.BG=find(TARGET.TR(cvtr,:)==0);        
       
        DATASG.TR=DATA(nv,IND.TR(cvtr,ind.TR.SG));
        DATABG.TR=DATA(nv,IND.TR(cvtr,ind.TR.BG));    
        
        optSG(cvtr)=calcnbins(DATASG.TR,'fd');
        optBG(cvtr)=calcnbins(DATABG.TR,'fd');
        
    end       

    opt.SG(nv)=round(mean(optSG));
    opt.BG(nv)=round(mean(optBG));
    
    waitbar(nv/size(DATA,1))
    
    clear optSG optBG    

end
close(wb)

end