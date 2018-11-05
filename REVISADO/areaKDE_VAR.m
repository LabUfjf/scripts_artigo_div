function [A,X,pdf] = areaKDE_VAR(DATA,nPoint,inter,est,bin_method,type,dolambda)
 bin = bin_hunter(DATA,method,est);
 h = h_methods(DATA,nPoint);
 
[X.SV,pdf.SV] = kernelND(DATA,nPoint,est,bin_method,'SV',type,dolambda);
[X.SVM1,pdf.SVM1] = kernelND(DATA,nPoint,est,bin_method,'SVM1',type,dolambda);
[X.SVM2,pdf.SVM2] = kernelND(DATA,nPoint,est,bin_method,'SVM2',type,dolambda);
[X.SJ,pdf.SJ] = kernelND(DATA,nPoint,est,bin_method,'SJ',type,dolambda);
[X.SC,pdf.SC] = kernelND(DATA,nPoint,est,bin_method,'SC',type,dolambda);

[X.MLCV,pdf.MLCV] = kernelND(DATA,nPoint,est,bin_method,'MLCV',type,dolambda);
[X.UCV,pdf.UCV] = kernelND(DATA,nPoint,est,bin_method,'UCV',type,dolambda);
[X.BCV1,pdf.BCV1] = kernelND(DATA,nPoint,est,bin_method,'BCV1',type,dolambda);
[X.BCV2,pdf.BCV2] = kernelND(DATA,nPoint,est,bin_method,'BCV2',type,dolambda);
[X.CCV,pdf.CCV] = kernelND(DATA,nPoint,est,bin_method,'CCV',type,dolambda);
[X.MCV,pdf.MCV] = kernelND(DATA,nPoint,est,bin_method,'MCV',type,dolambda);
[X.TCV,pdf.TCV] = kernelND(DATA,nPoint,est,bin_method,'TCV',type,dolambda);
[X.LSCV,pdf.LSCV] = kernelND(DATA,nPoint,est,bin_method,'LSCV',type,dolambda);
[X.TRUTH,pdf.TRUTH] = kernelND(DATA,nPoint,est,bin_method,'truth',type,dolambda);
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