function [V]= volume_pts(x,y,z,pts);

xgrid = min(x):range(x)/pts:max(x);
ygrid = min(y):range(y)/pts:max(y);

h = waitbar(0,'Remaking GRID points');
for i=1:length(xgrid)
        zgrid(i,:)= interp2(x,y,z,xgrid(i),ygrid,'linear');
        waitbar(i/length(xgrid))
end
close(h)
dx=min(diff(xgrid));
dy=min(diff(ygrid));
V=sum(sum(dx*dy*zgrid));
end