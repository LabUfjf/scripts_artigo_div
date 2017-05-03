vetor=[50 100 1000 10000 50000 100000];
titlename={'LP-L_{Inf}','LP-L2 Norm','L1-Sorensen','L1-Gower','IP-Innerproduct','IP-Harmonic','IP-Cosine','SQ-Hellinger','L2-Squared','L2-AddSym','SH-Kullback','CO-Kumar'};
region={'Tail','Deriv','Head'};

for i=1:length(vetor)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% HISTOGRAM
    hist.tail.m(i,:)=mean(NORM{i}.tail);
    hist.deriv.m(i,:)=mean(NORM{i}.deriv);
    hist.head.m(i,:)=mean(NORM{i}.head);
    
    hist.tail.e(i,:)=std(NORM{i}.tail)/sqrt(Ntimes);
    hist.deriv.e(i,:)=std(NORM{i}.deriv)/sqrt(Ntimes);
    hist.head.e(i,:)=std(NORM{i}.head)/sqrt(Ntimes);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% ASH
    ash.tail.m(i,:)=mean(NORMa{i}.tail);
    ash.deriv.m(i,:)=mean(NORMa{i}.deriv);
    ash.head.m(i,:)=mean(NORMa{i}.head);
    
    ash.tail.e(i,:)=std(NORMa{i}.tail)/sqrt(Ntimes);
    ash.deriv.e(i,:)=std(NORMa{i}.deriv)/sqrt(Ntimes);
    ash.head.e(i,:)=std(NORMa{i}.head)/sqrt(Ntimes);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% KDE FIX
    kdef.tail.m(i,:)=mean(NORMf{i}.tail);
    kdef.deriv.m(i,:)=mean(NORMf{i}.deriv);
    kdef.head.m(i,:)=mean(NORMf{i}.head);
    
    kdef.tail.e(i,:)=std(NORMf{i}.tail)/sqrt(Ntimes);
    kdef.deriv.e(i,:)=std(NORMf{i}.deriv)/sqrt(Ntimes);
    kdef.head.e(i,:)=std(NORMf{i}.head)/sqrt(Ntimes);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% KDE VAR
    kdev.tail.m(i,:)=mean(NORMv{i}.tail);
    kdev.deriv.m(i,:)=mean(NORMv{i}.deriv);
    kdev.head.m(i,:)=mean(NORMv{i}.head);
    
    kdev.tail.e(i,:)=std(NORMv{i}.tail)/sqrt(Ntimes);
    kdev.deriv.e(i,:)=std(NORMv{i}.deriv)/sqrt(Ntimes);
    kdev.head.e(i,:)=std(NORMv{i}.head)/sqrt(Ntimes);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    labelx{i}=num2str(vetor(i));
end

vvetor=repmat(vetor,3,1);

colors={'r';'b';'k';'g'};

for kk=4
    figure
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% HISTOGRAM
    errorbar(vetor, hist.tail.m(:,kk),hist.tail.e(:,kk),[colors{1} ':o'])
    hold on
    errorbar(vetor, hist.deriv.m(:,kk),hist.deriv.e(:,kk),[colors{1} ':s'])
    errorbar(vetor, hist.head.m(:,kk),hist.head.e(:,kk),[colors{1} ':p'])
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% ASH
    errorbar(vetor, ash.tail.m(:,kk),ash.tail.e(:,kk),[colors{2} ':o'])
    hold on
    errorbar(vetor, ash.deriv.m(:,kk),ash.deriv.e(:,kk),[colors{2} ':s'])
    errorbar(vetor, ash.head.m(:,kk),ash.head.e(:,kk),[colors{2} ':p'])
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% KERNEL FIX
    errorbar(vetor, kdef.tail.m(:,kk),kdef.tail.e(:,kk),[colors{3} ':o'])
    hold on
    errorbar(vetor, kdef.deriv.m(:,kk),kdef.deriv.e(:,kk),[colors{3} ':s'])
    errorbar(vetor, kdef.head.m(:,kk),kdef.head.e(:,kk),[colors{3} ':p'])
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% KERNEL VAR
    errorbar(vetor, kdev.tail.m(:,kk),kdev.tail.e(:,kk),[colors{4} ':o'])
    hold on
    errorbar(vetor, kdev.deriv.m(:,kk),kdev.deriv.e(:,kk),[colors{4} ':s'])
    errorbar(vetor, kdev.head.m(:,kk),kdev.head.e(:,kk),[colors{4} ':p'])
    
    ylabel('Absolute Divergence Values')
    legend('HIST - Tail','HIST - Deriv','HIST - Head','ASH - Tail','ASH - Deriv','ASH - Head','KDE FIX - Tail','KDE FIX - Deriv','KDE FIX - Head','KDE VAR - Tail','KDE VAR - Deriv','KDE VAR - Head','Location','best')
    title([titlename{kk} ' in All Regions'])
    grid on
    set(gca,'xscale','log','GridLineStyle',':')
    
end
% set(gca,'XTick',[1 2 3 4],'XTickLabel',{'HIST','ASH','KDE-FIX','KDE-VAR'})



% boxplot(hist.tail{4}','labels',labelx,'colors','r')
% hold on
% boxplot(hist.deriv{4}','labels',labelx,'colors','k')
% hold on
% boxplot(hist.head{4}','labels',labelx,'colors','b')
% hold on
%
% xlabel('Number of data events')
% ylabel('Absolute Divergence Values')
% legend('Tail','Head','Deriv','Location','best')