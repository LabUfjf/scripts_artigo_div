function [h] = h_hunter2D(DATA,nPoint,r,method)
d = size(DATA.sg.evt,2);
DATAND = DATA.sg.evt;
for i=1:d
 DATA.sg.evt = DATAND(:,i);    
[h(i)]=h_hunter(DATA,nPoint,r,method);
end