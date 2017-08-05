function [sg,bg] = PDFGEN(setup,sg,bg,type)

%% CALCULANDO NÚMERO DE PONTOS DAS PDFS
sg.nPoint=calcnbins(sg.evt,'fd');
bg.nPoint=calcnbins(bg.evt,'fd');

%% AJUSTANDO NÚMERO DE PONTOS DE ACORDO COM O FAST-KERNEL

[sg.nPoint] = nPointFix(sg.nPoint,setup.Div,size(sg.evt,2),size(sg.evt,1));
[bg.nPoint] = nPointFix(bg.nPoint,setup.Div,size(bg.evt,2),size(bg.evt,1));

%% PDFs
if strcmp(type,'hist') || strcmp(type,'all')
    [sg.pdf.hist.x,sg.pdf.hist.y] = histGEN(sg);
    [bg.pdf.hist.x,bg.pdf.hist.y] = histGEN(bg);
end
if strcmp(type,'ash') || strcmp(type,'all')
    M = 15;
    [sg.pdf.ash.x,sg.pdf.ash.y] = ashGEN(sg,M);
    [bg.pdf.ash.x,bg.pdf.ash.y] = ashGEN(bg,M);
end
if strcmp(type,'kdefix') || strcmp(type,'all')
    [sg.pdf.kde.x.fix,sg.pdf.kde.y.fix] = kdeGEN(setup,sg,'Fixed');
    [bg.pdf.kde.x.fix,bg.pdf.kde.y.fix] = kdeGEN(setup,bg,'Fixed');
end
if strcmp(type,'kdevar') || strcmp(type,'all')
    [sg.pdf.kde.x.var,sg.pdf.kde.y.var] = kdeGEN(setup,sg,'Variable');
    [bg.pdf.kde.x.var,bg.pdf.kde.y.var] = kdeGEN(setup,bg,'Variable');
end
end