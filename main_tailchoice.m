clear variables; close all; clc

for i = 1:1000;
    
    
    M.mix=[sg.gauss.evt bg.gauss.evt; ...
    sg.normal.evt bg.normal.evt; ...
   sg.rayleigh.evt bg.rayleigh.evt; ...
   sg.logn.evt bg.logn.evt; ...
   sg.gamma.evt bg.gamma.evt];
    
    
    N.EVT = 1000;
    [sg,bg,DATA] = datasetGen(N);
    DATASET = DATA.sg(1,:);
    [TH] = THchoice(3);
    
    [le,ld] = tail_choice_pdf(sg.gauss.pdf.x.all,sg.gauss.pdf.y.all,TH);
    [le,ld] = tail_choice_data(DATASET,TH);
    [le.cdf,ld.cdf,gridx] = cdfdata(DATASET,TH,200);
    
    LE(1,i)=le.py;
    LE(2,i)=le.n;
    LE(3,i)=le.cdf;
    
    LD(1,i)=ld.py;
    LD(2,i)=ld.n;
    LD(3,i)=ld.cdf;
    
    
end