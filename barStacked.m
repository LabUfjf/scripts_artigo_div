function [] = barStacked(DIV,nv)

% figure
bar([mean(DIV.tail{nv}); mean(DIV.deriv{nv}); mean(DIV.head{nv})]','Stacked'); axis tight;
xticklabel_rotate([],90,{'LP-LInf','LP-L2 Norm','L1-Sorensen','L1-Gower','IP-Innerproduct','IP-Harmonic','IP-Cosine','SQ-Hellinger','L2-Squared','L2-AddSym','SH-Kullback','CO-Kumar'},'interpreter','none')
legend('Tail','Deriv','Head')
colormap gray
end