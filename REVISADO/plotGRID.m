function [] = plotGRID(xgrid,EQ,cl,leg,norm)
load rangeRoI

for i = 1: length(EQ)
    for j = 1:size(EQ{1},2)
        if strcmp(norm,'do')
            VN = real(EQ{i}(:,j)-min(EQ{i}(:,j)));
            VD = real(max(EQ{i}(:,j)-min(EQ{i}(:,j))));
            V= real(VN/VD);
            subplot(3,1,2); h(i) = plot(xgrid(j,1:end-1)',V,['.' cl(i)]); hold on
            MAEQ(i,j)=max(max(V));
            MIEQ(i,j)=max(min(V));
        else
            subplot(3,1,2); h(i) = plot(xgrid(j,1:end-1)',EQ{i}(:,j),['.' cl(i)]); hold on
            MAEQ(i,j)=max([max(EQ{i})]);
            MIEQ(i,j)=min([min(EQ{i})]);
        end
    end    
end
% subplot(3,1,2); set(gca,'Yscale','log');
subplot(3,1,2);plot([rangeRoI.min;rangeRoI.min],[min(min(MIEQ))*ones(1,size(xgrid,1)); max(max(MAEQ))*ones(1,size(xgrid,1))],':k');hold on
subplot(3,1,2);plot([rangeRoI.max;rangeRoI.max],[min(min(MIEQ))*ones(1,size(xgrid,1)); max(max(MAEQ))*ones(1,size(xgrid,1))],':k'); axis tight;

title('Grid DEBUG')
legend(h(1:end),[leg'])
end

%

