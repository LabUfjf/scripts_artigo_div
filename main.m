clear variables; close all; clc

N.EVT = 20000;
N.BLOCKS = 20;
N.bins = 10:2:100;

[sg,bg,DATA] = dataGen(N.EVT);

[IND,TARGET] = CV(N.EVT+N.EVT,N.BLOCKS);

[opt]=pdf_hist(DATA,IND,TARGET,N.bins);
opt.SG = repmat(linspace(1,100000,14),4,1);
opt.BG = repmat(linspace(1,100000,14),4,1);

[analitica.ef,analitica.fa,analitica.auc,analitica.sp] = LH_ANALITICA(DATA,IND,TARGET,sg,bg,N);
[histo.ef,histo.fa,histo.auc] = LH_HIST(DATA,IND,TARGET,opt,N);
[ash.ef,ash.fa,ash.auc] = LH_ASH(DATA,IND,TARGET,opt,N);
[kde.ef,kde.fa,kde.auc,kde.sp] = LH_KDE(DATA,IND,TARGET,opt,N);




% boxplot([histo.auc.mean; analitica.auc.mean]',{'LP-LInf','LP-L2 Norm','L1-Sorensen','L1-Gower','IP-Innerproduct','IP-Harmonic','IP-Cosine','SQ-Hellinger','L2-Squared','L2-AddSym','SH-Kullback','CO-Kumar','Fd','AMISE','Analitica'})
% xticklabel_rotate([],90,[],'Fontsize',10)
% xlabel('Divergences')
% ylabel('AUC')
% title('Histogram')
% 
% figure
% boxplot([ash.auc.mean; analitica.auc.mean]',{'LP-LInf','LP-L2 Norm','L1-Sorensen','L1-Gower','IP-Innerproduct','IP-Harmonic','IP-Cosine','SQ-Hellinger','L2-Squared','L2-AddSym','SH-Kullback','CO-Kumar','Fd','AMISE','Analitica'})
% xticklabel_rotate([],90,[],'Fontsize',10)
% xlabel('Divergences')
% ylabel('AUC')
% title('ASH')

figure
boxplot([kde.auc.mean; analitica.auc.mean]',{'LP-LInf','LP-L2 Norm','L1-Sorensen','L1-Gower','IP-Innerproduct','IP-Harmonic','IP-Cosine','SQ-Hellinger','L2-Squared','L2-AddSym','SH-Kullback','CO-Kumar','Fd','AMISE','KDE Fix','Analitica'})
xticklabel_rotate([],90,[],'Fontsize',10)
xlabel('Divergences')
ylabel('AUC')
title('KDE')

% figure
% boxplot([kde.sp.mean; analitica.sp.mean]',{'LP-LInf','LP-L2 Norm','L1-Sorensen','L1-Gower','IP-Innerproduct','IP-Harmonic','IP-Cosine','SQ-Hellinger','L2-Squared','L2-AddSym','SH-Kullback','CO-Kumar','Fd','AMISE','Analitica'})
% xticklabel_rotate([],90,[],'Fontsize',10)
% xlabel('Divergences')
% ylabel('SP')
% title('KDE')


