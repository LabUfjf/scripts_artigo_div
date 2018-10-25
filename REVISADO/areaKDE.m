function [A,X,pdf] = areaKDE(DATA,nPoint,h,inter,band)

[X.SV,pdf.SV] = fastKDE(DATA.sg.evt,nPoint,1,2,h.PI.SV,band);
[X.SVM1,pdf.SVM1] = fastKDE(DATA.sg.evt,nPoint,1,2,h.PI.SVM1,band);
[X.SVM2,pdf.SVM2] = fastKDE(DATA.sg.evt,nPoint,1,2,h.PI.SVM2,band);
[X.SJ,pdf.SJ] = fastKDE(DATA.sg.evt,nPoint,1,2,h.PI.SJ,band);
[X.SC,pdf.SC] = fastKDE(DATA.sg.evt,nPoint,1,2,h.PI.SC,band);

[X.MLCV,pdf.MLCV] = fastKDE(DATA.sg.evt,nPoint,1,2,h.CV.MLCV,band);
[X.UCV,pdf.UCV] = fastKDE(DATA.sg.evt,nPoint,1,2,h.CV.UCV,band);
[X.BCV1,pdf.BCV1] = fastKDE(DATA.sg.evt,nPoint,1,2,h.CV.BCV1,band);
[X.BCV2,pdf.BCV2] = fastKDE(DATA.sg.evt,nPoint,1,2,h.CV.BCV2,band);
[X.CCV,pdf.CCV] = fastKDE(DATA.sg.evt,nPoint,1,2,h.CV.CCV,band);
[X.MCV,pdf.MCV] = fastKDE(DATA.sg.evt,nPoint,1,2,h.CV.MCV,band);
[X.TCV,pdf.TCV] = fastKDE(DATA.sg.evt,nPoint,1,2,h.CV.TCV,band);
[X.LSCV,pdf.LSCV] = fastKDE(DATA.sg.evt,nPoint,1,2,h.CV.LSCV,band);
[X.TRUTH,pdf.TRUTH] = fastKDE(DATA.sg.evt,nPoint,1,2,h.truth,band);
% [X.BE,pdf.BE] = fastKDE(DATA.sg.evt,nPoint,1,2,h.PI.SJ,'be');
% [X.SSE,pdf.SSE] = fastKDE(DATA.sg.evt,nPoint,1,2,h.PI.SJ,'sse');

ygrid(1,:)=interp1(X.SV,pdf.SV,DATA.sg.pdf.truth.x,inter,0); 
ygrid(2,:)=interp1(X.SVM1,pdf.SVM1,DATA.sg.pdf.truth.x,inter,0); 
ygrid(3,:)=interp1(X.SVM2,pdf.SVM2,DATA.sg.pdf.truth.x,inter,0); 
ygrid(4,:)=interp1(X.SJ,pdf.SJ,DATA.sg.pdf.truth.x,inter,0); 
ygrid(5,:)=interp1(X.SC,pdf.SC,DATA.sg.pdf.truth.x,inter,0); 

ygrid(6,:)=interp1(X.MLCV,pdf.MLCV,DATA.sg.pdf.truth.x,inter,0); 
ygrid(7,:)=interp1(X.UCV,pdf.UCV,DATA.sg.pdf.truth.x,inter,0); 
ygrid(8,:)=interp1(X.BCV1,pdf.BCV1,DATA.sg.pdf.truth.x,inter,0); 
ygrid(9,:)=interp1(X.BCV2,pdf.BCV2,DATA.sg.pdf.truth.x,inter,0); 
ygrid(10,:)=interp1(X.CCV,pdf.CCV,DATA.sg.pdf.truth.x,inter,0); 
ygrid(11,:)=interp1(X.MCV,pdf.MCV,DATA.sg.pdf.truth.x,inter,0); 
ygrid(12,:)=interp1(X.TCV,pdf.TCV,DATA.sg.pdf.truth.x,inter,0); 
ygrid(13,:)=interp1(X.LSCV,pdf.LSCV,DATA.sg.pdf.truth.x,inter,0);
ygrid(14,:)=interp1(X.TRUTH,pdf.TRUTH,DATA.sg.pdf.truth.x,inter,0); 
% ygrid(14,:)=interp1(X.BE,pdf.BE,DATA.sg.pdf.truth.x,inter,0); 
% ygrid(15,:)=interp1(X.SSE,pdf.SSE,DATA.sg.pdf.truth.x,inter,0); 

for i=1:14
ygrid(i,(ygrid(i,:)<0))=0;
A(i) = area2d(DATA.sg.pdf.truth.x,abs(ygrid(i,:)-DATA.sg.pdf.truth.y));
end

end