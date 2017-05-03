function [] = barStacked3(DIV)

% figure
bar([mean(DIV.tail); mean(DIV.deriv); mean(DIV.head)]','Stacked'); axis tight;
xticklabel_rotate([],90,{'5.10^1','1.10^2','1.10^3','1.10^4','5.10^4','1.10^5'},'interpreter','none')
legend('Tail','Deriv','Head')
colormap gray
end