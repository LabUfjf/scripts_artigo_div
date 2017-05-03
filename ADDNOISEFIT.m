function [xpdf,ynoise]= ADDNOISEFIT(xpdf,ypdf,noise,ind)

% SIGNAL


ynoise.sg.all = ypdf.sg.eq.all+ noise.sg.all;
ynoise.sg.tail = ypdf.sg.eq.tail + noise.sg.all(ind.sg.tail);
ynoise.sg.deriv = ypdf.sg.eq.deriv+ noise.sg.all(ind.sg.deriv);
ynoise.sg.head = ypdf.sg.eq.head+ noise.sg.all(ind.sg.head);

% BACKGROUND

ynoise.bg.all = ypdf.bg.eq.all+ noise.bg.all;
ynoise.bg.tail = ypdf.bg.eq.tail+ noise.bg.all(ind.bg.tail);
ynoise.bg.deriv = ypdf.bg.eq.deriv+ noise.bg.all(ind.bg.deriv);
ynoise.bg.head = ypdf.bg.eq.head+ noise.bg.all(ind.bg.head);
% plot(xpdf.sg.eq.all,ynoise.tail,'.r'); hold on
% plot(xpdf.sg.eq.all,ynoise.deriv,'.b')
% plot(xpdf.sg.eq.all,ynoise.head,'.g')
% plot(xpdf.sg.eq.all,ypdf.sg.eq.all,'.k')
% legend('tail','deriv','head','all')
end