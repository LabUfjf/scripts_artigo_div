function [x,y] = getAnalytical(sg,bg,nv)

switch (nv)
    case 1
        x.sg=sg.gauss.pdf.x;
        y.sg=sg.gauss.pdf.y;
        
        x.bg=bg.gauss.pdf.x;
        y.bg=bg.gauss.pdf.y;
    case 2
        x.sg=sg.normal.pdf.x;
        y.sg=sg.normal.pdf.y;
        
        x.bg=bg.normal.pdf.x;
        y.bg=bg.normal.pdf.y;
    case 3
        x.sg=sg.rayleigh.pdf.x;
        y.sg=sg.rayleigh.pdf.y;
        
        x.bg=bg.rayleigh.pdf.x;
        y.bg=bg.rayleigh.pdf.y;
    case 4
        x.sg=sg.logn.pdf.x;
        y.sg=sg.logn.pdf.y;
        
        x.bg=bg.logn.pdf.x;
        y.bg=bg.logn.pdf.y;
    case 5
        x.sg=sg.gamma.pdf.x;
        y.sg=sg.gamma.pdf.y;
        
        x.bg=bg.gamma.pdf.x;
        y.bg=bg.gamma.pdf.y;
    otherwise
        x=[];
        y=[];
end