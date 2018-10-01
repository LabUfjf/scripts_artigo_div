function [DATA] = M_Uniforme_Gen(setup,range)
%==========================================================================
% Sinal
%==========================================================================
if strcmp(setup.TYPE.DATA,'sg') || strcmp(setup.TYPE.DATA,'both')
    sg.n.x = setup.PTS;
    sg.g1.i = -2;
    sg.g1.s = 2;
    if range == 1;
        load([pwd '\TEST1\TEST1[' setup.TYPE.NAME ']STD[' num2str(setup.MINMAX.STD) '][' setup.TYPE.DATA ']'],'pdf');
        sg.pdf.truth.x = linspace(pdf.xlimit(1),pdf.xlimit(2),sg.n.x);
        [sg.Integral] = PDF_integral(sg,pdf.xlimit(1),pdf.xlimit(2),setup.TYPE.NAME);
        clear pdf 
    else
        sg.pdf.truth.x = linspace(-5,5,sg.n.x);
    end
   
    sg.pdf.truth.y = pdf(makedist('Uniform','lower',sg.g1.i,'upper',sg.g1.s),sg.pdf.truth.x);    
    sg.n.evt = setup.EVT;
    [sg.evt] = (sg.g1.s-sg.g1.i).*rand(sg.n.evt,1) + sg.g1.i;
    DATA.sg = sg;
end
%==========================================================================
% Ruído
%==========================================================================
if strcmp(setup.TYPE.DATA,'bg') || strcmp(setup.TYPE.DATA,'both')
    bg.n.x = setup.PTS;
    bg.g1.i = -1;
    bg.g1.s = 3;
    if range == 1;
        load([pwd '\TEST1\TEST1[' setup.TYPE.NAME ']STD[' num2str(setup.MINMAX.STD) '][' setup.TYPE.DATA ']'],'pdf');
        bg.pdf.truth.x = linspace(pdf.xlimit(1),pdf.xlimit(2),bg.n.x);        
        [bg.Integral] = PDF_integral(bg,pdf.xlimit(1),pdf.xlimit(2),setup.TYPE.NAME);
        clear pdf 
    else
        bg.pdf.truth.x = linspace(-5,5,bg.n.x);
    end
    bg.pdf.truth.y = pdf(makedist('Uniform','lower',bg.g1.i,'upper',bg.g1.s),bg.pdf.truth.x);
    bg.n.evt = setup.EVT;
    [bg.evt] = (bg.g1.s-bg.g1.i).*rand(bg.n.evt,1) + bg.g1.i;
    DATA.bg = bg;
end

end