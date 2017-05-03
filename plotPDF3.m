function [] = plotPDF3(sg,bg)

figure
plot(sg.gauss.pdf.x.all,sg.gauss.pdf.y.all,'k'); hold on
plot(sg.gauss.hist.x,sg.gauss.hist.y,':k');
plot(bg.gauss.pdf.x.all,bg.gauss.pdf.y.all,'r'); hold on
plot(bg.gauss.hist.x,bg.gauss.hist.y,':r');
xlabel('Data Value')
ylabel('Probability')
legend('Signal PDF','Signal Histogram Normalized','Background PDF','Background Histogram Normalized');
title('Normal PDF')

figure
plot(sg.normal.pdf.x.all,sg.normal.pdf.y.all,'k'); hold on
plot(sg.normal.hist.x,sg.normal.hist.y,':k');
plot(bg.normal.pdf.x.all,bg.normal.pdf.y.all,'r'); hold on
plot(bg.normal.hist.x,bg.normal.hist.y,':r');
xlabel('Data Value')
ylabel('Probability')
legend('Signal PDF','Signal Histogram Normalized','Background PDF','Background Histogram Normalized');
title('Bimodal Normal PDF')
% 
figure
plot(sg.rayleigh.pdf.x.all,sg.rayleigh.pdf.y.all,'k'); hold on
plot(sg.rayleigh.hist.x,sg.rayleigh.hist.y,':k');
plot(bg.rayleigh.pdf.x.all,bg.rayleigh.pdf.y.all,'r'); hold on
plot(bg.rayleigh.hist.x,bg.rayleigh.hist.y,':r');
xlabel('Data Value')
ylabel('Probability')
legend('Signal PDF','Signal Histogram Normalized','Background PDF','Background Histogram Normalized');
title('Rayleigh PDF'); xlim([0 13])
% 
figure
plot(sg.logn.pdf.x.all,sg.logn.pdf.y.all,'k'); hold on
plot(sg.logn.hist.x,sg.logn.hist.y,':k');
plot(bg.logn.pdf.x.all,bg.logn.pdf.y.all,'r'); hold on
plot(bg.logn.hist.x,bg.logn.hist.y,':r');
xlabel('Data Value')
ylabel('Probability')
legend('Signal PDF','Signal Histogram Normalized','Background PDF','Background Histogram Normalized');
title('LogN PDF'); xlim([0 30])

figure
plot(sg.gamma.pdf.x.all,sg.gamma.pdf.y.all,'k'); hold on
plot(sg.gamma.hist.x,sg.gamma.hist.y,':k');
plot(bg.gamma.pdf.x.all,bg.gamma.pdf.y.all,'r'); hold on
plot(bg.gamma.hist.x,bg.gamma.hist.y,':r');
xlabel('Data Value')
ylabel('Probability')
legend('Signal PDF','Signal Histogram Normalized','Background PDF','Background Histogram Normalized');
title('Gamma PDF'); xlim([0 5])

end