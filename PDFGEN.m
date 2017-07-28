function [sg,bg] = PDFGEN(sg,bg)

%% CALCULANDO NÚMERO DE PONTOS DAS PDFS
sg.nPoint=calcnbins(sg.evt,'fd');
bg.nPoint=calcnbins(bg.evt,'fd');

%% AJUSTANDO NÚMERO DE PONTOS DE ACORDO COM O FAST-KERNEL
sg.Div.L=10; sg.Div.S=2; sg.Div.D=5; % Garantir que os parâmetros estejam iguais ao fastKDE
[sg.nPoint] = nPointFix(sg.nPoint,sg.Div,size(sg.evt,2),size(sg.evt,1));
[bg.nPoint] = nPointFix(bg.nPoint,sg.Div,size(bg.evt,2),size(bg.evt,1));

%% PDFs
[sg.pdf.hist.x,sg.pdf.hist.y] = histGEN(sg);
[bg.pdf.hist.x,bg.pdf.hist.y] = histGEN(bg);

M = 15;
[sg.pdf.ash.x,sg.pdf.ash.y] = ashGEN(sg,M);
[bg.pdf.ash.x,bg.pdf.ash.y] = ashGEN(bg,M);

[sg.pdf.kde.x.fix,sg.pdf.kde.y.fix] = kdeGEN(sg,'Fixed');
[bg.pdf.kde.x.fix,bg.pdf.kde.y.fix] = kdeGEN(bg,'Fixed');

[sg.pdf.kde.x.var,sg.pdf.kde.y.var] = kdeGEN(sg,'Variable');
[bg.pdf.kde.x.var,bg.pdf.kde.y.var] = kdeGEN(bg,'Variable');

end