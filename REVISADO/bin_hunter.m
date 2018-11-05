function bin = bin_hunter(DATA,method,est)
x = DATA.sg.evt;
bincommon = calcnbins(x,method);

switch est
    case 'HIST'
        bin = bincommon;
        [bin.truth,~,~]=bintruth(DATA,100,'nearest');
    case 'PF'
        bin = bincommon;
        h = 2.15*std(x)*length(x)^(-1/5);
        bin.scott = ceil((max(x)-min(x))/h);
        [bin.LHM,~,~] = LHM(DATA.sg.evt,'linear');
        [bin.truth,~,~]=bintruth(DATA,100,'linear');
    case 'ASH'
        bin = bincommon;
        [bin.LHM,~,~] = LHM(DATA.sg.evt,'linear');
        [bin.truth,~,~]=ASHtruth(DATA,10,100,'linear');
    case 'all'
        bin.HIST = bincommon;
        [bin.HIST.truth,~,~]=bintruth(DATA,100,'nearest');
        
        bin.PF = bincommon;
        h = 2.15*std(x)*length(x)^(-1/5);
        bin.PF.scott = ceil((max(x)-min(x))/h);
        [bin.PF.LHM,~,~] = LHM(DATA.sg.evt,'linear');
        [bin.PF.truth,~,~]=bintruth(DATA,100,'linear');
        
        bin.ASH = bincommon;
        [bin.ASH.LHM,~,~] = LHM(DATA.sg.evt,'linear');
        [bin.ASH.truth,~,~]=ASHtruth(DATA,10,100,'linear');
        
end