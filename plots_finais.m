close all
load ('medidas_finais.mat')

title_name={'LP-L_{Inf}','LP-L2 Norm','L1-Sorensen','L1-Gower','IP-Innerproduct','IP-Harmonic','IP-Cosine','SQ-Hellinger','L2-Squared','L2-AddSym','SH-Kullback','CO-Kumar'};

xx=[1 2 3 4;1 2 3 4;1 2 3 4;1 2 3 4;1 2 3 4];

for i=[4 5 11]
    figure
    
    errorbar(xx', matrix_menor{i}',matrix_menor_error{i}',':*')
    set(gca,'XTick',[1 2 3 4],'XTickLabel',{'HIST','ASH','KDE-FIX','KDE-VAR'})
    ylabel('Absolute Divergence Values')
    legend('Gaussian','Bimodal Gaussian','Rayleigh','LogNormal','Gamma','Location','best')
    title([title_name{i} ' in All Regions'])
    grid on
    set(gca,'yscale','log','GridLineStyle',':')
    
end

for i=[4 5 11]
    figure
    
    errorbar(xx', matrix_tail_menor{i}',matrix_tail_menor_error{i}',':*')
    set(gca,'XTick',[1 2 3 4],'XTickLabel',{'HIST','ASH','KDE-FIX','KDE-VAR'})
    ylabel('Absolute Divergence Values')
    legend('Gaussian','Bimodal Gaussian','Rayleigh','LogNormal','Gamma','Location','best')
    title([title_name{i} ' in Tail Region'])
    grid on
    set(gca,'yscale','log','GridLineStyle',':')
    
end

for i=[4 5 11]
    figure
    
    errorbar(xx', matrix_deriv_menor{i}',matrix_deriv_menor_error{i}',':*')
    set(gca,'XTick',[1 2 3 4],'XTickLabel',{'HIST','ASH','KDE-FIX','KDE-VAR'})
    ylabel('Absolute Divergence Values')
    legend('Gaussian','Bimodal Gaussian','Rayleigh','LogNormal','Gamma','Location','best')
    title([title_name{i} ' in Derivative Region'])
    grid on
    set(gca,'yscale','log','GridLineStyle',':')
    
end

for i=[4 5 11]
    figure
    
    errorbar(xx', matrix_head_menor{i}',matrix_head_menor_error{i}',':*')
    set(gca,'XTick',[1 2 3 4],'XTickLabel',{'HIST','ASH','KDE-FIX','KDE-VAR'})
    ylabel('Absolute Divergence Values')
    legend('Gaussian','Bimodal Gaussian','Rayleigh','LogNormal','Gamma','Location','best')
    title([title_name{i} ' in Head Region'])
    grid on
    set(gca,'yscale','log','GridLineStyle',':')
    
end