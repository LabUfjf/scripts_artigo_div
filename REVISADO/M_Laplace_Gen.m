function [DATA] = M_Laplace_Gen(setup,range)

%==========================================================================
% Sinal
%==========================================================================
if strcmp(setup.TYPE.DATA,'sg') || strcmp(setup.TYPE.DATA,'both')
    sg.n.x = setup.PTS;
    sg.mu = 0;
    sg.std = 1;
    if range == 1;
        load([pwd '\TEST1\TEST1[' setup.TYPE.NAME ']STD[' num2str(setup.MINMAX.STD) '][' setup.TYPE.DATA ']'],'pdf');
        sg.pdf.truth.x = linspace(pdf.xlimit(1),pdf.xlimit(2),sg.n.x);
        [sg.Integral] = PDF_integral(sg,pdf.xlimit(1),pdf.xlimit(2),setup.TYPE.NAME);
    else
        sg.pdf.truth.x = linspace(-20,20,sg.n.x);
    end
    sg.pdf.truth.y = laplacepdf(sg.pdf.truth.x,sg.mu,sg.std);
    sg.n.evt = setup.EVT;
    sg.evt = laprnd(1, sg.n.evt,sg.mu,sg.std);
    DATA.sg = sg;
end

%==========================================================================
% Ruído
%==========================================================================
if strcmp(setup.TYPE.DATA,'bg') || strcmp(setup.TYPE.DATA,'both')
    bg.n.x = setup.PTS;
    bg.mu = 0;
    bg.std = 1;
    if range == 1;
        load([pwd '\TEST1\TEST1[' setup.TYPE.NAME ']STD[' num2str(setup.MINMAX.STD) '][' setup.TYPE.DATA ']'],'pdf');
        bg.pdf.truth.x = linspace(pdf.xlimit(1),pdf.xlimit(2),bg.n.x);
        [bg.Integral] = PDF_integral(bg,pdf.xlimit(1),pdf.xlimit(2),setup.TYPE.NAME);
    else
        bg.pdf.truth.x = linspace(-20,20,bg.n.x);
    end
    bg.pdf.truth.y = laplacepdf(bg.pdf.truth.x,bg.mu,bg.std);
    bg.n.evt = setup.EVT;
    bg.evt = laprnd(1, bg.n.evt,bg.mu,bg.std);
    DATA.bg = bg;
end



end





