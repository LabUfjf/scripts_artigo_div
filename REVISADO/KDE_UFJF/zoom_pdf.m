function [ data_zoom ] = zoom_pdf(data,bin,ratio,plotar)

r =ratio/100;
var1 = data(:);
var2 = var1;
% var2 = data(2,:);
var1
bin(1)
[yh1,xh1] = hist(var1',bin(1));
[yh2,xh2] = hist(var2',bin(2));

max_yh1=max(yh1);
max_yh2=max(yh2);

ratio_yh1=yh1/max_yh1;
ratio_yh2=yh2/max_yh2;

ind1 = find(ratio_yh1>=r);
ind2 = find(ratio_yh2>=r);

xh1_max=max(xh1(ind1));
xh1_min=min(xh1(ind1));
xh2_max=max(xh2(ind2));
xh2_min=min(xh2(ind2));

i1 = find((var1>=xh1_min & var1<=xh1_max));
i2 = find((var2>=xh2_min & var2<=xh2_max));

ind=intersect(i1,i2);

var1_zoom=var1(ind);
var2_zoom=var2(ind);

data_zoom = [var1_zoom; var2_zoom];

switch plotar
    case 'doPlot'
        
    [xh1,yh1] = data_normalized(var1,bin(1));
    [xh2,yh2] = data_normalized(var2,bin(2));
    figure
    stairs(xh1,yh1,'r'); hold on
    [xh1_zoom,yh1_zoom]=data_normalized(data_zoom(1,:),bin(1));
    stairs(xh1_zoom,yh1_zoom,'k')
    legend('Normal Data','Zoom Data')
    axis tight
    figure
    stairs(xh2,yh2,'r'); hold on
    [xh2_zoom,yh2_zoom]=data_normalized(data_zoom(2,:),bin(2));
    stairs(xh2_zoom,yh2_zoom,'k')
    legend('Normal Data','Zoom Data')
    axis tight
end

end

