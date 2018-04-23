function [DATA] = M_Rayleigh_Gen(setup,range)

%==========================================================================
% Sinal
%==========================================================================
if strcmp(setup.TYPE.DATA,'sg') || strcmp(setup.TYPE.DATA,'both')
    sg.n.x = setup.PTS;
    sg.b = 2;
    if range == 1;
        load([pwd '\TEST1\TEST1[' setup.TYPE.NAME ']STD[' num2str(setup.MINMAX.STD) '][' setup.TYPE.DATA ']'],'pdf');
        sg.pdf.truth.x = linspace(pdf.xlimit(1),pdf.xlimit(2),sg.n.x);
        [sg.Integral] = PDF_integral(sg,pdf.xlimit(1),pdf.xlimit(2),setup.TYPE.NAME);
    else
        sg.pdf.truth.x = linspace(0,50,sg.n.x);
    end
    sg.pdf.truth.y = raylpdf(sg.pdf.truth.x,sg.b);
    sg.n.evt = setup.EVT;
    sg.evt = random('Rayleigh',sg.b,1,sg.n.evt);
    DATA.sg = sg;
end

%==========================================================================
% Ruído
%==========================================================================
if strcmp(setup.TYPE.DATA,'bg') || strcmp(setup.TYPE.DATA,'both')
    bg.n.x = setup.PTS;
    bg.b = 4;
    if range == 1;
        load([pwd '\TEST1\TEST1[' setup.TYPE.NAME ']STD[' num2str(setup.MINMAX.STD) '][' setup.TYPE.DATA ']'],'pdf');
        bg.pdf.truth.x = linspace(pdf.xlimit(1),pdf.xlimit(2),bg.n.x);
        [bg.Integral] = PDF_integral(bg,pdf.xlimit(1),pdf.xlimit(2),setup.TYPE.NAME);
    else
        bg.pdf.truth.x = linspace(0,50,bg.n.x);
    end
    bg.pdf.truth.y = raylpdf(bg.pdf.truth.x,bg.b);
    bg.n.evt = setup.EVT;
    bg.evt = random('Rayleigh',bg.b,1,bg.n.evt);
    DATA.bg = bg;
end



end





