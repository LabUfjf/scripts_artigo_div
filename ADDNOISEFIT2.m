function [xpdf,ynoise]= ADDNOISEFIT2(xpdf,ypdf,noise,ind)

% SIGNAL


ynoise.sg.all = ypdf.sg.eq.all+ noise.sg.all;
ynoise.sg.tail = ypdf.sg.eq.tail + noise.sg.all(ind.sg.tail);
ynoise.sg.deriv = ypdf.sg.eq.deriv+ noise.sg.all(ind.sg.deriv);
ynoise.sg.head = ypdf.sg.eq.head+ noise.sg.all(ind.sg.head);

% plot(xpdf.sg.eq.all,ynoise.tail,'.r'); hold on
% plot(xpdf.sg.eq.all,ynoise.deriv,'.b')
% plot(xpdf.sg.eq.all,ynoise.head,'.g')
% plot(xpdf.sg.eq.all,ypdf.sg.eq.all,'.k')
% legend('tail','deriv','head','all')
end