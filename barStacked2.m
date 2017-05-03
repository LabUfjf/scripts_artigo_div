function [] = barStacked2(DIV)

% figure
bar([mean(DIV.tail); mean(DIV.deriv); mean(DIV.head)]','Stacked'); axis tight;
xticklabel_rotate([],90,{'LP-LInf','LP-L2 Norm','L1-Sorensen','L1-Gower','IP-Innerproduct','IP-Harmonic','IP-Cosine','SQ-Hellinger','L2-Squared','L2-AddSym','SH-Kullback','CO-Kumar'},'interpreter','none')
legend('Tail','Deriv','Head')
colormap gray
end