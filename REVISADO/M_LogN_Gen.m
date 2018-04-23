function [DATA] = M_LogN_Gen(setup,range)

%==========================================================================
% Sinal
%==========================================================================
if strcmp(setup.TYPE.DATA,'sg') || strcmp(setup.TYPE.DATA,'both')
    sg.n.x = setup.PTS;
    sg.mu = 2;
    sg.std = 0.6;
    if range == 1;
        load([pwd '\TEST1\TEST1[' setup.TYPE.NAME ']STD[' num2str(setup.MINMAX.STD) '][' setup.TYPE.DATA ']'],'pdf');
        sg.pdf.truth.x = linspace(pdf.xlimit(1),pdf.xlimit(2),sg.n.x);
        [sg.Integral] = PDF_integral(sg,pdf.xlimit(1),pdf.xlimit(2),setup.TYPE.NAME);
    else
        sg.pdf.truth.x = linspace(0,150,sg.n.x);
    end
    sg.pdf.truth.y = lognpdf(sg.pdf.truth.x,sg.mu,sg.std);
    sg.n.evt = setup.EVT;
    sg.evt = random('logn',sg.mu,sg.std,1,sg.n.evt);
    DATA.sg = sg;
end

%==========================================================================
% Ruído
%==========================================================================
if strcmp(setup.TYPE.DATA,'bg') || strcmp(setup.TYPE.DATA,'both')
    bg.n.x = setup.PTS;
    bg.mu = log(1);
    bg.std = 1;
    if range == 1;
        load([pwd '\TEST1\TEST1[' setup.TYPE.NAME ']STD[' num2str(setup.MINMAX.STD) '][' setup.TYPE.DATA ']'],'pdf');
        bg.pdf.truth.x = linspace(pdf.xlimit(1),pdf.xlimit(2),bg.n.x);
        [bg.Integral] = PDF_integral(bg,pdf.xlimit(1),pdf.xlimit(2),setup.TYPE.NAME);
    else
        bg.pdf.truth.x = linspace(0,300,bg.n.x);
    end
    bg.pdf.truth.y = lognpdf(bg.pdf.truth.x,bg.mu,bg.std);
    bg.n.evt = setup.EVT;
    bg.evt = random('logn',bg.mu,bg.std,1,bg.n.evt);
    DATA.bg = bg;
end


end



