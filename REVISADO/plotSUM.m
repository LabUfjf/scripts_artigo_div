function [] = plotSUM(xgrid,EQ,MD,cl,leg,norm)

load rangeRoI

for i = 1: length(EQ)
    if strcmp(norm,'do')
        VN = real(EQ{i}-min(EQ{i}));
        VD = real(max(EQ{i}-min(EQ{i})));
        V = real(VN/VD);
       
        subplot(3,1,3); h(i) = plot(rangeRoI.mean,V,['*' cl(i)]); hold on
        MAEQ(i,:)=max(V);
        MIEQ(i,:)=min(V);
    else
        subplot(3,1,3); h(i) = plot(rangeRoI.mean,EQ{i},['*' cl(i)]); hold on
        MAEQ(i,:)=max(EQ{i});
        MIEQ(i,:)=min(EQ{i});
    end
    
end

subplot(3,1,3);plot([rangeRoI.min;rangeRoI.min],[min(min(MIEQ))*ones(1,size(xgrid,1)); max(max(MAEQ))*ones(1,size(xgrid,1))],':k');
subplot(3,1,3);plot([rangeRoI.max;rangeRoI.max],[min(min(MIEQ))*ones(1,size(xgrid,1)); max(max(MAEQ))*ones(1,size(xgrid,1))],':k'); axis tight;

title('Sum DEBUG')
if strcmp(norm,'do')
    MD = real(MD);
    subplot(3,1,3); h(i+1) = plot(rangeRoI.mean,real((MD-min(MD))/max(MD-min(MD))),['om']);

   
%    save MD MD
%    save EQ
else
    subplot(3,1,3); h(i+1) = plot(rangeRoI.mean,MD,['om']);
end
legend(h(1:end),[leg'])

end
