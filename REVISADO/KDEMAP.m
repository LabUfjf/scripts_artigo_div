function [D] = KDEMAP(DATA,X,pdf,nROI)
for i = 1:nROI
    ygrid{i} = interp1(X{1,1}(1).SS,pdf{1,1}(1).SS,DATA.sg.RoI.x{i},'linear',0);
    
    D(i)=area2d(DATA.sg.RoI.x{i},ygrid{i}-DATA.sg.RoI.y{i});
%     NA(i)=area2d(DATA.sg.RoI.x{i},DATA.sg.RoI.y{i})
end

indu = find(D>0);
inds = find(D==0);
indd = find(D<0);
% stairs(D)
for i = 1:nROI
    if sum(i==indu)==1
        cl = [0 0 1]*abs(D(i)/max(abs(D)));
        area([min(DATA.sg.RoI.x{i}) max(DATA.sg.RoI.x{i})], [1 1],'EdgeColor',cl,'FaceColor',cl); hold on
    end
    if sum(i==indd)==1
        cl = [1 0 0]*abs(D(i)/max(abs(D)));
        area([min(DATA.sg.RoI.x{i}) max(DATA.sg.RoI.x{i})], [1 1],'EdgeColor',cl,'FaceColor',cl); hold on
    end
    if sum(i==inds)==1
        area([min(DATA.sg.RoI.x{i}) max(DATA.sg.RoI.x{i})], [1 1],'EdgeColor',[0 0 0]); hold on
    end
end

% stairs(D)
end