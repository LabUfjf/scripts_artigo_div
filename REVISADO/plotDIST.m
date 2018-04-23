function []= plotDIST(P,Q,xgrid)

load rangeRoI

for i=1:size(xgrid,1)
    subplot(3,1,1);plot(xgrid(i,1:end-1),P(:,i),'.r',xgrid(i,1:end-1),Q(:,i),'.k'); hold on
    MAP(i)=max([max(P(:,i)) max(Q(:,i))]);
    MIP(i)=min([min(P(:,i)) min(Q(:,i))]);
end

subplot(3,1,1); plot([rangeRoI.min;rangeRoI.min],[min(MIP)*ones(1,size(xgrid,1)); max(MAP)*ones(1,size(xgrid,1))],':k'); hold on
subplot(3,1,1); plot([rangeRoI.max;rangeRoI.max],[min(MIP)*ones(1,size(xgrid,1)); max(MAP)*ones(1,size(xgrid,1))],':k'); axis tight;

title('Distribution')
legend('P=Grid','Q=Truth')

end