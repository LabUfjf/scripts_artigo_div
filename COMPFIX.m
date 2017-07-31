function [COMP]= COMPFIX(data,type)

interp = 'nearest';

if strcmp(type,'hist')
    [COMP.hist.y,COMP.hist.x] = hist(data.evt,data.nPoint);
    COMP.ash.y = interp1(data.pdf.ash.x,data.pdf.ash.y,COMP.hist.x,interp,'extrap');
    COMP.kde.y.fix = interp1(data.pdf.kde.x.fix,data.pdf.kde.y.fix,COMP.hist.x,interp,'extrap');
    COMP.kde.y.var = interp1(data.pdf.kde.x.var,data.pdf.kde.y.var,COMP.hist.x,interp,'extrap');
    COMP.truth.y = interp1(data.pdf.truth.x,data.pdf.truth.y,COMP.hist.x,interp,'extrap');
    COMP.x = COMP.hist.x;
    COMP.hist = rmfield(COMP.hist,'x');
end

if strcmp(type,'truth')
    COMP.truth.y = data.pdf.truth.x;
    COMP.hist.y = interp1(data.pdf.hist.x,data.pdf.hist.y,data.pdf.truth.x,interp,'extrap');
    COMP.ash.y = interp1(data.pdf.ash.x,data.pdf.ash.y,data.pdf.truth.x,interp,'extrap');
    COMP.kde.y.fix = interp1(data.pdf.kde.x.fix,data.pdf.kde.y.fix,data.pdf.truth.x,interp,'extrap');
    COMP.kde.y.var = interp1(data.pdf.kde.x.var,data.pdf.kde.y.var,data.pdf.truth.x,interp,'extrap');
    COMP.x = data.pdf.truth.x;
end

if strcmp(type,'scan')
    i = 0;
    M = 15;
    
     if length(data.evt)>=69998
        DIV = data.Div.L;
    else
        DIV = data.Div.S;
    end
    
    nbin = DIV:DIV:200;
    for bin = nbin
        i= i+1;
        data.nPoint = bin;        
        [data.pdf.ash.x,data.pdf.ash.y] = ashGEN(data,M);
        [data.pdf.kde.x.fix,data.pdf.kde.y.fix] = kdeGEN(data,'Fixed');
        [data.pdf.kde.x.var,data.pdf.kde.y.var] = kdeGEN(data,'Variable');
        
        [COMP.hist.x{i},COMP.hist.y{i}] = data_normalized(data.evt,bin);
        COMP.ash.y{i} = interp1(data.pdf.ash.x,data.pdf.ash.y,COMP.hist.x{i},interp,'extrap');
        COMP.kde.y.fix{i} = interp1(data.pdf.kde.x.fix,data.pdf.kde.y.fix,COMP.hist.x{i},interp,'extrap');
        COMP.kde.y.var{i} = interp1(data.pdf.kde.x.var,data.pdf.kde.y.var,COMP.hist.x{i},interp,'extrap');        
        COMP.truth.y{i} = interp1(data.pdf.truth.x,data.pdf.truth.y,COMP.hist.x{i},interp,'extrap');
        COMP.x{i} = COMP.hist.x{i};
        COMP.hist = rmfield(COMP.hist,'x');
        COMP.bin = nbin;
    end
end

end