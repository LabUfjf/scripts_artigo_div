function [] = plotLOG(x,M,cl,P,F)
figure(F)
subplot(3,2,P);plot(x,mean(M),[':.' cl]); axis tight; set(gca,'gridlinestyle',':'); hold on;
% subplot(3,2,P);plot(x,mean(M)+std(M),[':' cl]); hold on;
% subplot(3,2,P);plot(x,mean(M)-std(M),[':' cl]); hold on; axis tight;

subplot(3,2,P+1);plot(x,mean(M),[':.' cl]); hold on; axis tight;  set(gca,'gridlinestyle',':','Yscale','log');
% subplot(3,2,P+1);plot(x,mean(M)+std(M),[':' cl]); hold on;
% subplot(3,2,P+1);plot(x,mean(M)-std(M),[':' cl]); hold on; axis tight;  set(gca,'gridlinestyle',':','Yscale','log');

end