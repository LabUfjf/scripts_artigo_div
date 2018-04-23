function [DATA] = M_Normal_Bimodal_Gen(setup,range)

%==========================================================================
% Sinal
%==========================================================================
if strcmp(setup.TYPE.DATA,'sg') || strcmp(setup.TYPE.DATA,'both')
    sg.n.x = setup.PTS;
    sg.g1.mu = 0;
    sg.g1.std = 0.8;
    sg.g2.mu = -1;
    sg.g2.std = 0.25;
    if range == 1;
        load([pwd '\TEST1\TEST1[' setup.TYPE.NAME ']STD[' num2str(setup.MINMAX.STD) '][' setup.TYPE.DATA ']'],'pdf');
        sg.pdf.truth.x = linspace(pdf.xlimit(1),pdf.xlimit(2),sg.n.x);
        [sg.Integral] = PDF_integral(sg,pdf.xlimit(1),pdf.xlimit(2),setup.TYPE.NAME);
    else
        sg.pdf.truth.x = linspace(-10,10,sg.n.x);
    end
    sg.pdf.truth.y = (normpdf(sg.pdf.truth.x,sg.g1.mu,sg.g1.std) + normpdf(sg.pdf.truth.x,sg.g2.mu,sg.g2.std))/2;
    sg.n.evt = setup.EVT;
    A.sg=sg.g1.mu+sg.g1.std*randn(sg.n.evt,1);
    B.sg=sg.g2.mu+sg.g2.std*randn(sg.n.evt,1);
    C.sg=[A.sg; B.sg];
    sg.evt = C.sg(randi(length(C.sg),sg.n.evt,1));
    DATA.sg = sg;
end

%==========================================================================
% Ruído
%==========================================================================
if strcmp(setup.TYPE.DATA,'bg') || strcmp(setup.TYPE.DATA,'both')
    bg.n.x = setup.PTS;
    bg.g1.mu = 0;
    bg.g1.std = 0.25;
    bg.g2.mu = -1;
    bg.g2.std = 1;
    if range == 1;
        load([pwd '\TEST1\TEST1[' setup.TYPE.NAME ']STD[' num2str(setup.MINMAX.STD) '][' setup.TYPE.DATA ']'],'pdf');
        bg.pdf.truth.x = linspace(pdf.xlimit(1),pdf.xlimit(2),bg.n.x);
        [bg.Integral] = PDF_integral(bg,pdf.xlimit(1),pdf.xlimit(2),setup.TYPE.NAME);
    else
        bg.pdf.truth.x = linspace(-10,10,bg.n.x);
    end
    bg.pdf.truth.y = (normpdf(bg.pdf.truth.x,bg.g1.mu,bg.g1.std) + normpdf(bg.pdf.truth.x,bg.g2.mu,bg.g2.std))/2;
    bg.n.evt = setup.EVT;
    A.bg=bg.g1.mu+bg.g1.std*randn(bg.n.evt,1);
    B.bg=bg.g2.mu+bg.g2.std*randn(bg.n.evt,1);
    C.bg=[A.bg; B.bg];
    bg.evt = C.bg(randi(length(C.bg),bg.n.evt,1));
    DATA.bg = bg;
end



end