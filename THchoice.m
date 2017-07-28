function [TH] = THchoice(sd)

if sd == 1
    TH = 1-(68.268/100);    
elseif sd == 2
    TH = 1-(95.449/100);
elseif sd == 3
    TH = 1-(99.730/100);
elseif sd == 4
    TH = 1-(99.993/100);
elseif sd == 5
    TH = 1-(99.999/100);
end

TH = TH/2;

end




