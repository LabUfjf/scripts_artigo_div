function [le,ld] = tail_choice_data(DATASET,TH)
TH = (TH/100);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Probabilidade
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[yh,xh]=hist(DATASET,calcnbins(DATASET,'fd'));

yh = yh/max(yh);
xrange = xh;
ind.py = find(yh<TH);
le.py=xrange(ind.py((find(diff(ind.py)>2)))); le.py = min(le.py);
ld.py=xrange(ind.py((find(diff(ind.py)>2))+1)); ld.py = max(ld.py);

if isempty(le.py)
    le.py = min(xrange);
end
if isempty(ld.py)
    ld.py = max(xrange);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Número de eventos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TH = 2* TH;

DATASORT = sort(DATASET);

de = abs(min(DATASORT) - mean(DATASORT));
dd = abs(max(DATASORT) - mean(DATASORT));
fe = de/(de+dd);
fd = 1-fe;

nTH=round(TH*length(DATASORT));

if round(nTH*fe) == 0
    init = 1;
else
    init = round(nTH*fe);
end

DATASORT = DATASORT(init:end -round(nTH*fd));
le.n = min(DATASORT);
ld.n = max(DATASORT);





% plot(xh,yh); hold on
plot(le.py,0,'sb',ld.py,0,'sb','DisplayName','DATA Probability'); hold on
plot(le.n,0,'^k',ld.n,0,'^k','DisplayName','DATA Number')

end