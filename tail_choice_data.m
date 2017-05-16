function [le,ld,T] = tail_choice_data(DATA,TH)
TH = (TH/100);

DATASORT = sort(DATA);

for i = 1:floor(length(DATA)/2);
    DATARM = DATASORT(i:end-i);
    T(i) = abs(DATARM(1)-DATARM(end));
end

T = abs(T/max(T));

i= round(TH*length(DATA));
DATA = DATASORT(i:end-i);
le = min(DATA);
ld = max(DATA);

end