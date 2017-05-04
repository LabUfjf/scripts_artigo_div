function [data] =  dataStep(data,bin)
N=length(data);
F = 2*floor(sqrt(N));

for i = 1:F-1
    ind = setdiff(1:N,i*F:(i+1)*F);
    length(ind)
    datacut = data(ind);     
    [xh,yh] = data_normalized(datacut,bin);
    
    xm(i,:)=xh;
    ym(i,:)=yh;
%     plot(xh,yh); hold on
  
end

errorbar(mean(xm),mean(ym),var(ym),'-r'); hold on
plot(sg.gauss.pdf.x.all,sg.gauss.pdf.y.all,'-k')
  
end