function [A,xgrid,ygrid] = areaKDE_NEWMETHOD(DATA,nPoint,inter,est,bin_method,h_method,type,dolambda)
r=1;
h.o=h_hunter(DATA,[],0,h_method);

[X.SV,pdf.SV] = kernelND(DATA,nPoint,h.o,est,bin_method,h_method,type,dolambda);
[X.BKDE,pdf.BKDE] = bkde(DATA.sg.evt',h.o,nPoint);
[pdf.SS,X.SS,h.ss] = ssvkernel(DATA.sg.evt); h.xss = X.SS;
[X.MGKDE,Y.MGKDE] = MGKDE(DATA,r,nPoint,h,est,bin_method,h_method);

xgrid = DATA.sg.pdf.truth.x;
ygrid(1,:)=interp1(X.SV,pdf.SV,DATA.sg.pdf.truth.x,inter,'extrap');
ygrid(2,:)=interp1(X.BKDE,pdf.BKDE,DATA.sg.pdf.truth.x,inter,'extrap');
ygrid(3,:)=interp1(X.SS,pdf.SS,DATA.sg.pdf.truth.x,inter,'extrap');
ygrid(4,:)=interp1(X.MGKDE,Y.MGKDE,DATA.sg.pdf.truth.x,inter,'extrap');

for i=1:4
    ygrid(i,(ygrid(i,:)<0))=0;
    A(i) = area2d(DATA.sg.pdf.truth.x,abs(ygrid(i,:)-DATA.sg.pdf.truth.y));
end

end