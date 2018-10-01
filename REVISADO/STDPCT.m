function [AR] = STDPCT(S)

if S == 1;
    AR= 68.2689492 ;
end
if S == 2;
    AR = 95.4499736;
end
if S == 3;
    AR = 99.7300204;
end
if S == 4;
    AR = 99.993666;
end
if S == 5;
    AR = 99.999943;
end


AR = AR/100;

end