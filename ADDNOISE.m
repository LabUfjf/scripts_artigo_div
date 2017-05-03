function [xpdf,ynoise,noise,ind]= ADDNOISE(xpdf,ypdf,sd)

% SIGNAL
[~,ind.sg.tail]=ismember(xpdf.sg.eq.tail,xpdf.sg.eq.all);
[~,ind.sg.deriv]=ismember(xpdf.sg.eq.deriv,xpdf.sg.eq.all);
[~,ind.sg.head]=ismember(xpdf.sg.eq.head,xpdf.sg.eq.all);

ind.sg.tail=unique(ind.sg.tail(ind.sg.tail~=0));
ind.sg.deriv=unique(ind.sg.deriv(ind.sg.deriv~=0));
ind.sg.head=unique(ind.sg.head(ind.sg.head~=0));

ynoise.sg.tail = ypdf.sg.eq.all;
ynoise.sg.deriv = ypdf.sg.eq.all;
ynoise.sg.head = ypdf.sg.eq.all;

[noise] = noiseADD(ypdf,sd,'normal');

ynoise.sg.all = ypdf.sg.eq.all+ noise.sg.all;
ynoise.sg.tail(ind.sg.tail) = ypdf.sg.eq.all(ind.sg.tail)+ noise.sg.all(ind.sg.tail);
ynoise.sg.deriv(ind.sg.deriv) = ypdf.sg.eq.all(ind.sg.deriv)+ noise.sg.all(ind.sg.deriv);
ynoise.sg.head(ind.sg.head) = ypdf.sg.eq.all(ind.sg.head)+ noise.sg.all(ind.sg.head);

% BACKGROUND
[~,ind.bg.tail]=ismember(xpdf.bg.eq.tail,xpdf.bg.eq.all);
[~,ind.bg.deriv]=ismember(xpdf.bg.eq.deriv,xpdf.bg.eq.all);
[~,ind.bg.head]=ismember(xpdf.bg.eq.head,xpdf.bg.eq.all);

ind.bg.tail=unique(ind.bg.tail(ind.bg.tail~=0));
ind.bg.deriv=unique(ind.bg.deriv(ind.bg.deriv~=0));
ind.bg.head=unique(ind.bg.head(ind.bg.head~=0));

ynoise.bg.tail = ypdf.bg.eq.all;
ynoise.bg.deriv = ypdf.bg.eq.all;
ynoise.bg.head = ypdf.bg.eq.all;


ynoise.bg.all = ypdf.bg.eq.all+ noise.bg.all;
ynoise.bg.tail(ind.bg.tail) = ypdf.bg.eq.all(ind.bg.tail)+ noise.bg.all(ind.bg.tail);
ynoise.bg.deriv(ind.bg.deriv) = ypdf.bg.eq.all(ind.bg.deriv)+ noise.bg.all(ind.bg.deriv);
ynoise.bg.head(ind.bg.head) = ypdf.bg.eq.all(ind.bg.head)+ noise.bg.all(ind.bg.head);

% plot(xpdf.sg.eq.all,ynoise.tail,'.r'); hold on
% plot(xpdf.sg.eq.all,ynoise.deriv,'.b')
% plot(xpdf.sg.eq.all,ynoise.head,'.g')
% plot(xpdf.sg.eq.all,ypdf.sg.eq.all,'.k')
% legend('tail','deriv','head','all')
end