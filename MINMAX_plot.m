function [] = MINMAX_plot(sg,evt,Fsg,name,ngrid)
subplot(2,2,1);errorbar(evt,Fsg.M.pdf(:,1),Fsg.S.pdf(:,1),':r'); hold on
subplot(2,2,1);errorbar(evt,Fsg.M.std(:,1),Fsg.S.std(:,1),':b'); hold on
subplot(2,2,1);errorbar(evt,Fsg.M.data(:,1),Fsg.S.data(:,1),':k');

subplot(2,2,1);errorbar(evt,Fsg.M.pdf(:,2),Fsg.S.pdf(:,2),':r')
subplot(2,2,1);errorbar(evt,Fsg.M.std(:,2),Fsg.S.std(:,2),':b')
subplot(2,2,1);errorbar(evt,Fsg.M.data(:,2),Fsg.S.data(:,2),':k')
subplot(2,2,1);legend('PDF Cut','STD Cut','DATA Cut');axis tight; grid on; set(gca,'GridLineStyle',':');
subplot(2,2,1);xlabel('Events'); ylabel('Amplitude');

subplot(2,2,2);errorbar(evt,Fsg.AM.pdf,Fsg.AS.pdf,':r'); hold on
subplot(2,2,2);errorbar(evt,Fsg.AM.std,Fsg.AS.std,':b'); hold on
subplot(2,2,2);errorbar(evt,Fsg.AM.data,Fsg.AS.data,':k'); hold on
subplot(2,2,2);legend('PDF Cut','STD Cut','DATA Cut');axis tight;  grid on; set(gca,'GridLineStyle',':');
subplot(2,2,2);xlabel('Events'); ylabel('PDF Area');

subplot(2,2,3);plot(sg.pdf.truth.x,sg.pdf.truth.y,'-k'); hold on
subplot(2,2,3);plot([Fsg.M.pdf(end,1) Fsg.M.pdf(end,1)],[0 max(sg.pdf.truth.y)],':r'); hold on
subplot(2,2,3);plot([Fsg.M.std(end,1) Fsg.M.std(end,1)],[0 max(sg.pdf.truth.y)],':b'); hold on
subplot(2,2,3);plot([Fsg.M.data(end,1) Fsg.M.data(end,1)],[0 max(sg.pdf.truth.y)],':k'); hold on
subplot(2,2,3);plot([Fsg.M.pdf(end,2) Fsg.M.pdf(end,2)],[0 max(sg.pdf.truth.y)],':r'); hold on
subplot(2,2,3);plot([Fsg.M.std(end,2) Fsg.M.std(end,2)],[0 max(sg.pdf.truth.y)],':b'); hold on
subplot(2,2,3);plot([Fsg.M.data(end,2) Fsg.M.data(end,2)],[0 max(sg.pdf.truth.y)],':k'); hold on
subplot(2,2,3);legend('PDF','PDF Cut','STD Cut','DATA Cut');axis tight; grid on; set(gca,'GridLineStyle',':');
subplot(2,2,3);xlabel('Amplitude'); ylabel('Probability Density');

xpdf = linspace(Fsg.M.pdf(end,1),Fsg.M.pdf(end,2),ngrid);
xdata = linspace(Fsg.M.data(end,1),Fsg.M.data(end,2),ngrid);
[ypdf]= GridNew(sg,xpdf,name);
[ydata]= GridNew(sg,xdata,name);

subplot(2,2,4);plot(xpdf,ypdf,':r'); hold on
subplot(2,2,4);plot(xdata,ydata,':k'); hold on
subplot(2,2,4);xlabel('Amplitude'); ylabel('Probability Density');
subplot(2,2,4);legend('PDF Cut Zoom','DATA Cut Zoom');grid on; set(gca,'GridLineStyle',':');axis tight;

% figure(1)
% set(gcf, 'Position', get(0, 'Screensize'));
% saveas(gcf,[pwd '\MINMAX\MINMAX_PDF[' name{1} ']'],'fig')
% close

end