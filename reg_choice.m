function [x,y] = reg_choice(xpdf,ypdf,div)

h = diff(xpdf); h = h(1);

dy = diff(ypdf)/h;
dy = abs(dy)/max(dy);

py = abs(ypdf/max(ypdf));

TH = linspace(0,1,div+1);

for i = 1:length(TH)-1
    ind.dy{i} = find(dy>TH(i) & dy<TH(i+1));
    ind.py{i} = find(py>TH(i) & py<TH(i+1));
    
    x.dy{i} = xpdf(ind.dy{i});
    y.dy{i} = ypdf(ind.dy{i});
    
    x.py{i} = xpdf(ind.py{i});
    y.py{i} = ypdf(ind.py{i});
    
    Ndy(i)=length(x.dy{i});
    Npy(i)=length(x.py{i});
end

Ndy = min(Ndy);
Npy = min(Npy);

for i = 1:length(TH)-1
    
    ind.dy{i} = find(dy>TH(i) & dy<TH(i+1));
    ind.py{i} = find(py>TH(i) & py<TH(i+1));
    
    x.dy{i} = xpdf(ind.dy{i});
    y.dy{i} = ypdf(ind.dy{i});
    
    x.py{i} = xpdf(ind.py{i});
    y.py{i} = ypdf(ind.py{i});
    
end

for i = 1:div;
    
    R.dy = [x.dy{i}(1) -abs(x.dy{i}(find(diff(ind.dy{i})>2)))];
    V.dy = [R.dy fliplr(abs(R.dy))];
    Range.dy = reshape(V.dy,2,length(V.dy)/2)';
    
    R.py = [x.py{i}(1) -abs(x.py{i}(find(diff(ind.py{i})>2)))];
    V.py = [R.py fliplr(abs(R.py))];
    Range.py = reshape(V.py,2,length(V.py)/2)';
    
    xeq.dy = [];
    xeq.py = [];
    
    d.dy = abs(Range.dy(:,1)-Range.dy(:,2))/sum(abs(Range.dy(:,1)-Range.dy(:,2)));
    d.py = abs(Range.py(:,1)-Range.py(:,2))/sum(abs(Range.py(:,1)-Range.py(:,2)));
    
    N.sec.dy = round(length(xpdf)/div);
    N.sec.py = round(length(xpdf)/div);
    
    N.dy = [floor( N.sec.dy*d.dy)];
    N.dy(end)= N.dy(end) + (N.sec.dy-sum(N.dy));
    
    N.py = [floor(N.sec.py*d.py)];
    N.py(end)= N.py(end) + (N.sec.py-sum(N.py));
    
    for j = 1:size(Range.py,1)
        xeq.py = [xeq.py linspace(Range.py(j,1),Range.py(j,2),N.py(j))];
    end
    
    for j = 1:size(Range.dy,1)
        xeq.dy = [xeq.dy linspace(Range.dy(j,1),Range.dy(j,2),N.dy(j))];
    end
    
    x.eq.py(i,:) = xeq.py;
    x.eq.dy(i,:) = xeq.dy;
    
    y.eq.dy(i,:) = interp1(x.dy{i},y.dy{i},xeq.dy,'linear');
    y.eq.py(i,:) = interp1(x.py{i},y.py{i},xeq.py,'linear');
    
    %     subplot(1,2,1);plot( x.eq.dy(i,:), y.eq.dy(i,:),'.'); hold on; axis tight
    %     subplot(1,2,2);plot( x.eq.py(i,:), y.eq.py(i,:),'.'); hold on; axis tight
    %     pause
end

end



