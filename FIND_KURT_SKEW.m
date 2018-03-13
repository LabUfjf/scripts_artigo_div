function [KT,SK,PB] = FIND_KURT_SKEW(sg,xgrid,xest,yest,rn,errortype,name)

M = [min(xgrid'); max(xgrid')];


ntmax = 500;

for i = 1:size(xgrid,1)
    PT_ROI{i} = [];
end

wb = waitbar(0,'Aguarde...');

for j=1:ntmax;

     signal = noiseADD(xest,yest,rn,errortype);
    for i = 1:size(xgrid,1)
       
        IND_ROI{i} = find(xest>=M(1,i) & xest<=M(2,i));
        Yest_ROI{i} = GridNew(sg,xest(IND_ROI{i}),name);
        
        Yest_ROI_noise{i} = signal(IND_ROI{i});
        
        PT_ROI{i} = [PT_ROI{i} Yest_ROI{i}-Yest_ROI_noise{i}];
    
    end
    
    waitbar(j/ntmax)
end

for i = 1:size(xgrid,1)
    n = length(PT_ROI{i});
    SK.Value(i)=skewness(PT_ROI{i});
    SK.Error(i)= sqrt([6*n*(n-1)]/[(n-2)*(n+1)*(n+3)]);
    
    KT.Value(i)=kurtosis(PT_ROI{i});
    KT.Error(i) = 2*(SK.Error(i))*sqrt([(n^2)-1]/[(n-3)*(n+5)]);
    PB(i)=mean(Yest_ROI{i});
end

close(wb)

Xerror = diff(sg.RoI.Xaxis); Xerror = [Xerror/2 Xerror(end)/2];

figure
errorbarxy(sg.RoI.Xaxis,KT.Value,Xerror,KT.Error,{'ko:', 'k', 'k'}); hold on
errorbarxy(sg.RoI.Xaxis,SK.Value,Xerror,SK.Error,{'rs:', 'r', 'r'})
plot([min(sg.RoI.Xaxis) max(sg.RoI.Xaxis)],[3 3],'k')
plot([min(sg.RoI.Xaxis) max(sg.RoI.Xaxis)],[0 0],'r')
axis tight
legend({'Kurtosis \pm Erro','Skewness \pm Erro','Kurtosis = 3','Skewness = 0'},'Location','Best','Fontsize',12)
grid on
set(gca,'GridLineStyle',':')


end