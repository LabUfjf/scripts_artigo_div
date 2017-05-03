function [] = plotPDF(sg,bg)

subplot(2,2,1); plot(sg.normal.pdf.x,sg.normal.pdf.y,'k'); hold on
subplot(2,2,1); plot(sg.normal.hist.x,sg.normal.hist.y,':k');
subplot(2,2,1); plot(bg.normal.pdf.x,bg.normal.pdf.y,'r'); hold on
subplot(2,2,1); plot(bg.normal.hist.x,bg.normal.hist.y,':r');
subplot(2,2,1); legend('Signal PDF','Signal Histogram Normalized','Background PDF','Background Histogram Normalized');
subplot(2,2,1); title('Bimodal Normal PDF')

subplot(2,2,2); plot(sg.rayleigh.pdf.x,sg.rayleigh.pdf.y,'k'); hold on
subplot(2,2,2); plot(sg.rayleigh.hist.x,sg.rayleigh.hist.y,':k');
subplot(2,2,2); plot(bg.rayleigh.pdf.x,bg.rayleigh.pdf.y,'r'); hold on
subplot(2,2,2); plot(bg.rayleigh.hist.x,bg.rayleigh.hist.y,':r');
subplot(2,2,2); legend('Signal PDF','Signal Histogram Normalized','Background PDF','Background Histogram Normalized');
subplot(2,2,2); title('Rayleigh PDF'); xlim([0 13])

subplot(2,2,3); plot(sg.logn.pdf.x,sg.logn.pdf.y,'k'); hold on
subplot(2,2,3); plot(sg.logn.hist.x,sg.logn.hist.y,':k');
subplot(2,2,3); plot(bg.logn.pdf.x,bg.logn.pdf.y,'r'); hold on
subplot(2,2,3); plot(bg.logn.hist.x,bg.logn.hist.y,':r');
subplot(2,2,3); legend('Signal PDF','Signal Histogram Normalized','Background PDF','Background Histogram Normalized');
subplot(2,2,3); title('LogN PDF'); xlim([0 30])

subplot(2,2,4); plot(sg.gamma.pdf.x,sg.gamma.pdf.y,'k'); hold on
subplot(2,2,4); plot(sg.gamma.hist.x,sg.gamma.hist.y,':k');
subplot(2,2,4); plot(bg.gamma.pdf.x,bg.gamma.pdf.y,'r'); hold on
subplot(2,2,4); plot(bg.gamma.hist.x,bg.gamma.hist.y,':r');
subplot(2,2,4); legend('Signal PDF','Signal Histogram Normalized','Background PDF','Background Histogram Normalized');
subplot(2,2,4); title('Gamma PDF'); xlim([0 5])

end