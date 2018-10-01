function [SET] = ecdfepdf(D,TH)

[f,x] = ecdf(D);
 [~,ind] = unique(f);
 
 
TH = (1-TH);
% xlimit(1) = interp1(f(ind),x(ind),TH,'linear','extrap');
xlimit(2) = interp1(f(ind),x(ind),1-TH,'nearest','extrap');

% linf = D>xlimit(1);
lsup = D<xlimit(2);
SET = lsup;
SET = ~SET;