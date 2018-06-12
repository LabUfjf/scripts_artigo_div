function [P,Q,dx] = fixPQ(XGRID,YGRID,YTRUTH)
P=YGRID(:,1:end-1)';
Q=YTRUTH(:,1:end-1)';
dx = diff(XGRID');
end