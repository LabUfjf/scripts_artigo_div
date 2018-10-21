function [A,X,pdf] = areaKDE_VAR(DATA,nPoint,h,inter,band)

[X.SV,pdf.SV] = fastKDE(DATA.sg.evt,nPoint,1,2,h.PI.SV,band);
[X.MLCV,pdf.MLCV] = fastKDE(DATA.sg.evt,nPoint,1,2,h.CV.MLCV,band);
[pdf.SS,X.SS] = ssvkernel(DATA.sg.evt);
[X.BE1,pdf.BE1] = fastKDE(DATA.sg.evt,nPoint,1,2,h.PI.SV,'be');
[X.SSE1,pdf.SSE1] = fastKDE(DATA.sg.evt,nPoint,1,2,h.PI.SV,'sse');
[X.BE2,pdf.BE2] = fastKDE(DATA.sg.evt,nPoint,1,2,h.CV.MLCV,'be');
[X.SSE2,pdf.SSE2] = fastKDE(DATA.sg.evt,nPoint,1,2,h.CV.MLCV,'sse');


ygrid(1,:)=interp1(X.SV,pdf.SV,DATA.sg.pdf.truth.x,inter,0); 
ygrid(2,:)=interp1(X.MLCV,pdf.MLCV,DATA.sg.pdf.truth.x,inter,0); 
ygrid(3,:)=interp1(X.SS,pdf.SS,DATA.sg.pdf.truth.x,inter,0); 
ygrid(4,:)=interp1(X.BE1,pdf.BE1,DATA.sg.pdf.truth.x,inter,0); 
ygrid(5,:)=interp1(X.SSE1,pdf.SSE1,DATA.sg.pdf.truth.x,inter,0);
ygrid(6,:)=interp1(X.BE2,pdf.BE2,DATA.sg.pdf.truth.x,inter,0); 
ygrid(7,:)=interp1(X.SSE2,pdf.SSE2,DATA.sg.pdf.truth.x,inter,0);


for i=1:7
ygrid(i,(ygrid(i,:)<0))=0;
A(i) = area2d(DATA.sg.pdf.truth.x,abs(ygrid(i,:)-DATA.sg.pdf.truth.y));
end

end