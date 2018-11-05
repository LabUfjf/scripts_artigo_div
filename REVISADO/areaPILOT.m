function [A,X,Y] = areaPILOT(DATA,nPoint,inter,est,bin,h,type,dolambda)


%  dolambda=1;
%  est = 'ASH';
%  type = 'SSE';
[X.SV,Y.SV] = kernelND(DATA,nPoint,est,bin,h.PI.SV,type,dolambda);
[X.SVM1,Y.SVM1] = kernelND(DATA,nPoint,est,bin,h.PI.SVM1,type,dolambda);
[X.SVM2,Y.SVM2] = kernelND(DATA,nPoint,est,bin,h.PI.SVM2,type,dolambda);
[X.SJ,Y.SJ] = kernelND(DATA,nPoint,est,bin,h.PI.SJ,type,dolambda);
[X.SC,Y.SC] = kernelND(DATA,nPoint,est,bin,h.PI.SC,type,dolambda);

[X.MLCV,Y.MLCV] = kernelND(DATA,nPoint,est,bin,h.CV.MLCV,type,dolambda);
[X.UCV,Y.UCV] = kernelND(DATA,nPoint,est,bin,h.CV.UCV,type,dolambda);
[X.BCV1,Y.BCV1] = kernelND(DATA,nPoint,est,bin,h.CV.BCV1,type,dolambda);
[X.BCV2,Y.BCV2] = kernelND(DATA,nPoint,est,bin,h.CV.BCV2,type,dolambda);
[X.CCV,Y.CCV] = kernelND(DATA,nPoint,est,bin,h.CV.CCV,type,dolambda);
[X.MCV,Y.MCV] = kernelND(DATA,nPoint,est,bin,h.CV.MCV,type,dolambda);
[X.TCV,Y.TCV] = kernelND(DATA,nPoint,est,bin,h.CV.TCV,type,dolambda);
[X.LSCV,Y.LSCV] = kernelND(DATA,nPoint,est,bin,h.CV.LSCV,type,dolambda);
[X.TRUTH,Y.TRUTH] = kernelND(DATA,nPoint,est,bin,h.truth,type,dolambda);
% [X.BE,Y.BE] = fastKDE(DATA.sg.evt,nPoint,1,2,h.PI.SJ,h.be');
% [X.SSE,Y.SSE] = fastKDE(DATA.sg.evt,nPoint,1,2,h.PI.SJ,h.sse');

ygrid(1,:)=interp1(X.SV,Y.SV,DATA.sg.pdf.truth.x,inter,0); 
ygrid(2,:)=interp1(X.SVM1,Y.SVM1,DATA.sg.pdf.truth.x,inter,0); 
ygrid(3,:)=interp1(X.SVM2,Y.SVM2,DATA.sg.pdf.truth.x,inter,0); 
ygrid(4,:)=interp1(X.SJ,Y.SJ,DATA.sg.pdf.truth.x,inter,0); 
ygrid(5,:)=interp1(X.SC,Y.SC,DATA.sg.pdf.truth.x,inter,0); 

ygrid(6,:)=interp1(X.MLCV,Y.MLCV,DATA.sg.pdf.truth.x,inter,0); 
ygrid(7,:)=interp1(X.UCV,Y.UCV,DATA.sg.pdf.truth.x,inter,0); 
ygrid(8,:)=interp1(X.BCV1,Y.BCV1,DATA.sg.pdf.truth.x,inter,0); 
ygrid(9,:)=interp1(X.BCV2,Y.BCV2,DATA.sg.pdf.truth.x,inter,0); 
ygrid(10,:)=interp1(X.CCV,Y.CCV,DATA.sg.pdf.truth.x,inter,0); 
ygrid(11,:)=interp1(X.MCV,Y.MCV,DATA.sg.pdf.truth.x,inter,0); 
ygrid(12,:)=interp1(X.TCV,Y.TCV,DATA.sg.pdf.truth.x,inter,0); 
ygrid(13,:)=interp1(X.LSCV,Y.LSCV,DATA.sg.pdf.truth.x,inter,0);
ygrid(14,:)=interp1(X.TRUTH,Y.TRUTH,DATA.sg.pdf.truth.x,inter,0); 
% ygrid(14,:)=interp1(X.BE,Y.BE,DATA.sg.pdf.truth.x,inter,0); 
% ygrid(15,:)=interp1(X.SSE,Y.SSE,DATA.sg.pdf.truth.x,inter,0); 

for i=1:14
ygrid(i,(ygrid(i,:)<0))=0;
A(i) = area2d(DATA.sg.pdf.truth.x,abs(ygrid(i,:)-DATA.sg.pdf.truth.y));
end

end