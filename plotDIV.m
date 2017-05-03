function [] = plotDIV(DIV,nv)

figure
subplot(2,2,1)
boxplot(DIV.all{nv},{'LP-LInf','LP-L2 Norm','L1-Sorensen','L1-Gower','IP-Innerproduct','IP-Harmonic','IP-Cosine','SQ-Hellinger','L2-Squared','L2-AddSym','SH-Kullback','CO-Kumar'})
xticklabel_rotate([],90,[],'Fontsize',10)
xlabel('Divergences Name')
ylabel('Similarity')
title('Histogram All')
axis([0 13 -0.01 0.1])

subplot(2,2,2)
boxplot(DIV.head{nv},{'LP-LInf','LP-L2 Norm','L1-Sorensen','L1-Gower','IP-Innerproduct','IP-Harmonic','IP-Cosine','SQ-Hellinger','L2-Squared','L2-AddSym','SH-Kullback','CO-Kumar'})
xticklabel_rotate([],90,[],'Fontsize',10)
xlabel('Divergences Name')
ylabel('Similarity')
title('Histogram Head')
axis([0 13 -0.01 0.1])

subplot(2,2,3)
boxplot(DIV.tail{nv},{'LP-LInf','LP-L2 Norm','L1-Sorensen','L1-Gower','IP-Innerproduct','IP-Harmonic','IP-Cosine','SQ-Hellinger','L2-Squared','L2-AddSym','SH-Kullback','CO-Kumar'})
xticklabel_rotate([],90,[],'Fontsize',10)
xlabel('Divergences Name')
ylabel('Similarity')
axis([0 13 -0.01 0.1])
title('Histogram Tail')

subplot(2,2,4)
boxplot(DIV.deriv{nv},{'LP-LInf','LP-L2 Norm','L1-Sorensen','L1-Gower','IP-Innerproduct','IP-Harmonic','IP-Cosine','SQ-Hellinger','L2-Squared','L2-AddSym','SH-Kullback','CO-Kumar'})
xticklabel_rotate([],90,[],'Fontsize',10)
xlabel('Divergences Name')
ylabel('Similarity')
title('Histogram Deriv')
axis([0 13 -0.01 0.1])

end