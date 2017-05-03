function [DL] = LH_INTERP(DATA,cv,pdf)

for bin=1:size(pdf.hist.sg.x,2);
    for var = 1:size(pdf.hist.sg.x{1}{1},1);
        psg(var,:)= interp1(pdf.hist.sg.x{bin}{cv}(var,:),pdf.hist.sg.y{bin}{cv}(var,:),DATA(var,:),'nearest','extrap');
        pbg(var,:)= interp1(pdf.hist.bg.x{bin}{cv}(var,:),pdf.hist.bg.y{bin}{cv}(var,:),DATA(var,:),'nearest','extrap');
    end
    Lsg = psg(1,:).*psg(2,:).*psg(3,:).*psg(4,:);
    Lbg = pbg(1,:).*pbg(2,:).*pbg(3,:).*pbg(4,:);
    DL{bin} = Lsg./(Lsg+Lbg);
end

