function [A,xgrid,ygrid] = areaKDE_METHODS2D(DATA,nPoint,inter,est,bin_method,h_method,type,dolambda)

h.o=h_hunter2D(DATA,[],0,h_method);

[X.SV,pdf.SV] = kernelND(DATA,nPoint,h.o,est,bin_method,h_method,type,dolambda);
[X.BKDE,pdf.BKDE] = bkde(DATA.sg.evt,h.o,nPoint);
[pdf.SS,X.SS] = ssvkernel(DATA.sg.evt); 

xgrid = DATA.sg.pdf.truth.x;
ygrid(1,:)=interp1(X.SV,pdf.SV,DATA.sg.pdf.truth.x,inter,'extrap');
ygrid(2,:)=interp1(X.BKDE,pdf.BKDE,DATA.sg.pdf.truth.x,inter,'extrap');
ygrid(3,:)=interp1(X.SS,pdf.SS,DATA.sg.pdf.truth.x,inter,'extrap');


for i=1:3
    ygrid(i,(ygrid(i,:)<0))=0;
    A(i) = area2d(DATA.sg.pdf.truth.x,abs(ygrid(i,:)-DATA.sg.pdf.truth.y));
end

end