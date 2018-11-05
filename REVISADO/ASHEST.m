function [x,y] = ASHEST(DATA, bin)
M = 10;

        [x,y] = ashN(DATA.sg.evt,M,'linear',bin);
end
