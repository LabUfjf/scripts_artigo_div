function [ind]=findregion2(xpdf)

%SIGNAL
[~,ind.sg.tail]=ismember(xpdf.sg.eq.tail,xpdf.sg.eq.all);
[~,ind.sg.deriv]=ismember(xpdf.sg.eq.deriv,xpdf.sg.eq.all);
[~,ind.sg.head]=ismember(xpdf.sg.eq.head,xpdf.sg.eq.all);

ind.sg.tail=unique(ind.sg.tail(ind.sg.tail~=0));
ind.sg.deriv=unique(ind.sg.deriv(ind.sg.deriv~=0));
ind.sg.head=unique(ind.sg.head(ind.sg.head~=0));

% % BACKGROUND
% [~,ind.bg.tail]=ismember(xpdf.bg.eq.tail,xpdf.bg.eq.all);
% [~,ind.bg.deriv]=ismember(xpdf.bg.eq.deriv,xpdf.bg.eq.all);
% [~,ind.bg.head]=ismember(xpdf.bg.eq.head,xpdf.bg.eq.all);
% 
% ind.bg.tail=unique(ind.bg.tail(ind.bg.tail~=0));
% ind.bg.deriv=unique(ind.bg.deriv(ind.bg.deriv~=0));
% ind.bg.head=unique(ind.bg.head(ind.bg.head~=0));

end