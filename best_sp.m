function [bsp] = best_sp(ef,fa,ne,nj)

    for h=1:1:length(fa)
        sp(h)=sqrt((sqrt(ef(h)*(1-fa(h)))*((ef(h)+(1-fa(h)))/2)));
    end
    [bsp,i] = max(sp);
    bsp=bsp*100;
%     ef=ef(i);
%     fa=fa(i);
% 
%     [am_ef,bm_ef]=binofit(ef*ne,ne);
%     eim_ef=am_ef-bm_ef(1);
%     esm_ef=bm_ef(2)-am_ef;
%     [am_fa,bm_fa]=binofit((1-fa)*nj,nj);
%     eim_fa=am_fa-bm_fa(1);
%     esm_fa=bm_fa(2)-am_fa;
% 
%     ei = (sqrt((eim_ef.^2)+(eim_fa.^2)))*100;
%     es = (sqrt((esm_ef.^2)+(esm_fa.^2)))*100;
end