function [DATA] = M_Gamma_Gen(setup,range)

%==========================================================================
% Sinal
%==========================================================================
if strcmp(setup.TYPE.DATA,'sg') || strcmp(setup.TYPE.DATA,'both')
    sg.n.x = setup.PTS;
    sg.A = 5;
    sg.B = 0.5;
    if range == 1;
        load([pwd '\TEST1\TEST1[' setup.TYPE.NAME ']STD[' num2str(setup.MINMAX.STD) '][' setup.TYPE.DATA ']'],'pdf');
        sg.pdf.truth.x = linspace(pdf.xlimit(1),pdf.xlimit(2),sg.n.x);
        [sg.Integral] = PDF_integral(sg,pdf.xlimit(1),pdf.xlimit(2),setup.TYPE.NAME);
    else
        sg.pdf.truth.x = linspace(0,50,sg.n.x);
    end
    sg.pdf.truth.y = gampdf(sg.pdf.truth.x,sg.A,sg.B);
    sg.n.evt = setup.EVT;
    sg.evt = random('Gamma',sg.A,sg.B,1,sg.n.evt)';
    %sg.evt = gamrnd(sg.A,sg.B,1,sg.n.evt);
    DATA.sg = sg;
end

%==========================================================================
% Ruído
%==========================================================================
if strcmp(setup.TYPE.DATA,'bg') || strcmp(setup.TYPE.DATA,'both')
    bg.n.x = setup.PTS;
    bg.A = 5;
    bg.B = 0.4;
    if range == 1;
        load([pwd '\TEST1\TEST1[' setup.TYPE.NAME ']STD[' num2str(setup.MINMAX.STD) '][' setup.TYPE.DATA ']'],'pdf');
        bg.pdf.truth.x = linspace(pdf.xlimit(1),pdf.xlimit(2),bg.n.x);
        [bg.Integral] = PDF_integral(bg,pdf.xlimit(1),pdf.xlimit(2),setup.TYPE.NAME);
    else
        bg.pdf.truth.x = linspace(0,50,bg.n.x);
    end
    bg.pdf.truth.y = gampdf(bg.pdf.truth.x,bg.A,bg.B);
    bg.n.evt = setup.EVT;
    
    bg.evt = random('Gamma',bg.A,bg.B,1,bg.n.evt)';
    %bg.evt = gamrnd(bg.A,bg.B,1,bg.n.evt);
    DATA.bg = bg;
end



end





