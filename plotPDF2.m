function [] = plotPDF2(sg,bg)

figure
subplot(3,2,5); plot(sg.gauss.pdf.x.all,sg.gauss.pdf.y.all,'.k'); hold on
subplot(3,2,5); plot(sg.gauss.pdf.x.tail,sg.gauss.pdf.y.tail,'.r'); hold on
subplot(3,2,5); plot(sg.gauss.pdf.x.deriv,sg.gauss.pdf.y.deriv,'.b'); hold on
subplot(3,2,5); plot(sg.gauss.pdf.x.head,sg.gauss.pdf.y.head,'.g'); hold on
subplot(3,2,5); plot(bg.gauss.pdf.x.all,bg.gauss.pdf.y.all,'.k'); hold on
subplot(3,2,5); plot(bg.gauss.pdf.x.tail,bg.gauss.pdf.y.tail,'.r'); hold on
subplot(3,2,5); plot(bg.gauss.pdf.x.deriv,bg.gauss.pdf.y.deriv,'.b'); hold on
subplot(3,2,5); plot(bg.gauss.pdf.x.head,bg.gauss.pdf.y.head,'.g'); hold on

subplot(3,2,1); plot(sg.normal.pdf.x.all,sg.normal.pdf.y.all,'.k'); hold on
subplot(3,2,1); plot(sg.normal.pdf.x.tail,sg.normal.pdf.y.tail,'.r'); hold on
subplot(3,2,1); plot(sg.normal.pdf.x.deriv,sg.normal.pdf.y.deriv,'.b'); hold on
subplot(3,2,1); plot(sg.normal.pdf.x.head,sg.normal.pdf.y.head,'.g'); hold on
subplot(3,2,1); plot(bg.normal.pdf.x.all,bg.normal.pdf.y.all,'.k'); hold on
subplot(3,2,1); plot(bg.normal.pdf.x.tail,bg.normal.pdf.y.tail,'.r'); hold on
subplot(3,2,1); plot(bg.normal.pdf.x.deriv,bg.normal.pdf.y.deriv,'.b'); hold on
subplot(3,2,1); plot(bg.normal.pdf.x.head,bg.normal.pdf.y.head,'.g'); hold on

subplot(3,2,2); plot(sg.rayleigh.pdf.x.all,sg.rayleigh.pdf.y.all,'.k'); hold on
subplot(3,2,2); plot(sg.rayleigh.pdf.x.tail,sg.rayleigh.pdf.y.tail,'.r'); hold on
subplot(3,2,2); plot(sg.rayleigh.pdf.x.deriv,sg.rayleigh.pdf.y.deriv,'.b'); hold on
subplot(3,2,2); plot(sg.rayleigh.pdf.x.head,sg.rayleigh.pdf.y.head,'.g'); hold on
subplot(3,2,2); plot(bg.rayleigh.pdf.x.all,bg.rayleigh.pdf.y.all,'.k'); hold on
subplot(3,2,2); plot(bg.rayleigh.pdf.x.tail,bg.rayleigh.pdf.y.tail,'.r'); hold on
subplot(3,2,2); plot(bg.rayleigh.pdf.x.deriv,bg.rayleigh.pdf.y.deriv,'.b'); hold on
subplot(3,2,2); plot(bg.rayleigh.pdf.x.head,bg.rayleigh.pdf.y.head,'.g'); hold on

subplot(3,2,3); plot(sg.logn.pdf.x.all,sg.logn.pdf.y.all,'.k'); hold on
subplot(3,2,3); plot(sg.logn.pdf.x.tail,sg.logn.pdf.y.tail,'.r'); hold on
subplot(3,2,3); plot(sg.logn.pdf.x.deriv,sg.logn.pdf.y.deriv,'.b'); hold on
subplot(3,2,3); plot(sg.logn.pdf.x.head,sg.logn.pdf.y.head,'.g'); hold on
subplot(3,2,3); plot(bg.logn.pdf.x.all,bg.logn.pdf.y.all,'.k'); hold on
subplot(3,2,3); plot(bg.logn.pdf.x.tail,bg.logn.pdf.y.tail,'.r'); hold on
subplot(3,2,3); plot(bg.logn.pdf.x.deriv,bg.logn.pdf.y.deriv,'.b'); hold on
subplot(3,2,3); plot(bg.logn.pdf.x.head,bg.logn.pdf.y.head,'.g'); hold on

subplot(3,2,4); plot(sg.gamma.pdf.x.all,sg.gamma.pdf.y.all,'.k'); hold on
subplot(3,2,4); plot(sg.gamma.pdf.x.tail,sg.gamma.pdf.y.tail,'.r'); hold on
subplot(3,2,4); plot(sg.gamma.pdf.x.deriv,sg.gamma.pdf.y.deriv,'.b'); hold on
subplot(3,2,4); plot(sg.gamma.pdf.x.head,sg.gamma.pdf.y.head,'.g'); hold on
subplot(3,2,4); plot(bg.gamma.pdf.x.all,bg.gamma.pdf.y.all,'.k'); hold on
subplot(3,2,4); plot(bg.gamma.pdf.x.tail,bg.gamma.pdf.y.tail,'.r'); hold on
subplot(3,2,4); plot(bg.gamma.pdf.x.deriv,bg.gamma.pdf.y.deriv,'.b'); hold on
subplot(3,2,4); plot(bg.gamma.pdf.x.head,bg.gamma.pdf.y.head,'.g'); hold on



% subplot(3,2,5); plot(sg.gauss.hist.x,sg.gauss.hist.y,':k');
% subplot(3,2,5); plot(bg.gauss.pdf.x.all,bg.gauss.pdf.y.all,'r'); hold on
% subplot(3,2,5); plot(bg.gauss.hist.x,bg.gauss.hist.y,':r');
% subplot(3,2,5); legend('Signal PDF','Signal Histogram Normalized','Background PDF','Background Histogram Normalized');
% subplot(3,2,5); title('Normal PDF')

% subplot(3,2,1); plot(sg.normal.pdf.x.all,sg.normal.pdf.y.all,'k'); hold on
% subplot(3,2,1); plot(sg.normal.hist.x,sg.normal.hist.y,':k');
% subplot(3,2,1); plot(bg.normal.pdf.x.all,bg.normal.pdf.y.all,'r'); hold on
% subplot(3,2,1); plot(bg.normal.hist.x,bg.normal.hist.y,':r');
% subplot(3,2,1); legend('Signal PDF','Signal Histogram Normalized','Background PDF','Background Histogram Normalized');
% subplot(3,2,1); title('Bimodal Normal PDF')
% 
% subplot(3,2,2); plot(sg.rayleigh.pdf.x.all,sg.rayleigh.pdf.y.all,'k'); hold on
% subplot(3,2,2); plot(sg.rayleigh.hist.x,sg.rayleigh.hist.y,':k');
% subplot(3,2,2); plot(bg.rayleigh.pdf.x.all,bg.rayleigh.pdf.y.all,'r'); hold on
% subplot(3,2,2); plot(bg.rayleigh.hist.x,bg.rayleigh.hist.y,':r');
% subplot(3,2,2); legend('Signal PDF','Signal Histogram Normalized','Background PDF','Background Histogram Normalized');
% subplot(3,2,2); title('Rayleigh PDF'); xlim([0 13])
% 
% subplot(3,2,3); plot(sg.logn.pdf.x.all,sg.logn.pdf.y.all,'k'); hold on
% subplot(3,2,3); plot(sg.logn.hist.x,sg.logn.hist.y,':k');
% subplot(3,2,3); plot(bg.logn.pdf.x.all,bg.logn.pdf.y.all,'r'); hold on
% subplot(3,2,3); plot(bg.logn.hist.x,bg.logn.hist.y,':r');
% subplot(3,2,3); legend('Signal PDF','Signal Histogram Normalized','Background PDF','Background Histogram Normalized');
% subplot(3,2,3); title('LogN PDF'); xlim([0 30])
% 
% subplot(3,2,4); plot(sg.gamma.pdf.x.all,sg.gamma.pdf.y.all,'k'); hold on
% subplot(3,2,4); plot(sg.gamma.hist.x,sg.gamma.hist.y,':k');
% subplot(3,2,4); plot(bg.gamma.pdf.x.all,bg.gamma.pdf.y.all,'r'); hold on
% subplot(3,2,4); plot(bg.gamma.hist.x,bg.gamma.hist.y,':r');
% subplot(3,2,4); legend('Signal PDF','Signal Histogram Normalized','Background PDF','Background Histogram Normalized');
% subplot(3,2,4); title('Gamma PDF'); xlim([0 5])

end