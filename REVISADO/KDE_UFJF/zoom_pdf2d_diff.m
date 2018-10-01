function [data_zoom,sd] = zoom_pdf2d_diff(data,mode)

[dmax,x,y,sd.v1,vmax] = calc_diff(data,mode,1);
ratio = 0;
d1.n.v1 = 0.1*dmax.v1;
while dmax.v1 >= d1.n.v1
    ratio = ratio+0.0001;
    r =ratio/100;
    ratio_yh1=y.v1/vmax.v1;
    ind1 = find(ratio_yh1>=r);
    xh1_max=max(x.v1(ind1));
    xh1_min=min(x.v1(ind1));
    i1 = find((data(1,:)>=xh1_min & data(1,:)<=xh1_max));
    data_zoom=data(:,i1);
    [d1,x,y,sd.v1,~] = calc_diff(data_zoom,mode,1);
end

[dmax,x,y,sd.v2,vmax] = calc_diff(data,mode,2);
ratio = 0;
d2.n.v2 = 0.1*dmax.v2;
while dmax.v2 >= d2.n.v2
    ratio = ratio+0.0001;
    r =ratio/100;
    ratio_yh2=y.v2/vmax.v2;
    ind2 = find(ratio_yh2>=r);
    xh2_max=max(x.v2(ind2));
    xh2_min=min(x.v2(ind2));
    i2 = find((data(2,:)>=xh2_min & data(2,:)<=xh2_max));
    data_zoom=data(:,i2);
    [d2,x,y,sd.v2,~] = calc_diff(data_zoom,mode,2);
end

ind=intersect(i1,i2);
var1_zoom=data(1,ind);
var2_zoom=data(2,ind);
data_zoom = [var1_zoom; var2_zoom];

end

