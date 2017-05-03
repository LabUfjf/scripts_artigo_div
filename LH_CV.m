function [DL] = LH_CV(DATA,IND,TARGET,N,sg,bg,pdf)

disp('[CV][ANALITICA][..]')
disp('[CV][INTERP][..]')
for i = 1:N.BLOCKS
    [DL.ANALITICA(i,:)] = LH_ANALITICA(sg,bg,DATA(:,IND.VAL(i,:)));
    [DL.INTERP{i}] = LH_INTERP(DATA(:,IND.VAL(i,:)),i,pdf);

    for j = 1:length(DL.INTERP{1})
        figure(3)
        [fa.interp,ef.interp] = perfcurve(TARGET.VAL(i,:),DL.INTERP{i}{j},1);
        plot(ef.interp,1-fa.interp,':k','DisplayName','LH ANALITICA'); hold on
    end    
      figure(3)
    plot(ef.analitica,1-fa.analitica,'r','DisplayName','LH ANALITICA'); hold on
    pause
    
end
disp('[CV][ANALITICA][OK]')
disp('[CV][INTERP][OK]')

% [y,x]=hist(DL(i,:),200);
% figure(2)
% plot(x,y,':'); hold on
% set(gca, 'YScale', 'log')

%
% end





% for i = 1:size(DATA,1)
% [pdf.x,pdf.y] = kernelClean(data,nPoint,f);
% plot(X,pdf)
% pause

end


