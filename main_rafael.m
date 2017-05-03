clear variables; close all; clc
N.EVT = 20000;
N.BLOCKS = 20;
N.bins = 10:2:1000;

[sg,bg,DATA] = dataGen2(N.EVT);

[IND,TARGET] = CV(N.EVT+N.EVT,N.BLOCKS);

[DIV.hist] = calcDivHist2(DATA,IND,TARGET,sg,bg,N);
[DIV.ash] = calcDivAsh2(DATA,IND,TARGET,sg,bg,N);
[DIV.KDE] = calcDivKDE2(DATA,IND,TARGET,sg,bg,N);
% [DIV.PDF] = calcDivPDFNOISE(DATA,sg,bg,N);

% [NORM] = DivNorm(DIV);
% [NORM.PDF] = DivNorm2(DIV.PDF);
[NORM.hist] = DivNorm2(DIV.hist);
[NORM.ash] = DivNorm2(DIV.ash);
[NORM.KDE.VAR] = DivNorm2(DIV.KDE.VAR);
[NORM.KDE.FIX] = DivNorm2(DIV.KDE.FIX);
% plotDIV(DIV.hist.SG,1)


TEST=DIV.KDE.SG.VAR;

plotDIV(DIV.KDE.SG.VAR,1)

for i=1
    figure(i)
    subplot(2,2,1)
    barStacked(DIV.hist.SG,i); title('Normalized Histogram')
    ylabel('Absolut Value')
    subplot(2,2,2)
    barStacked(DIV.ash.SG,i); title('Normalized Average Shifetd Histogram')
    ylabel('Absolut Value')
    subplot(2,2,3)
    barStacked(DIV.KDE.FIX.SG,i); title('KDE with Fixed Bandwidth')
    ylabel('Absolut Value')
    subplot(2,2,4)
    barStacked(DIV.KDE.VAR.SG,i); title('KDE with Variable Bandwidth')
    ylabel('Absolut Value')
end

for j=1
    figure(i+j)
    subplot(2,2,1)
    barStacked(NORM.hist.SG,j); title('Normalized Histogram')
    ylabel('Normalized Value')
    subplot(2,2,2)
    barStacked(NORM.ash.SG,j); title('Normalized Average Shifetd Histogram')
    ylabel('Normalized Value')
    subplot(2,2,3)
    barStacked(NORM.KDE.FIX.SG,j); title('KDE with Fixed Bandwidth')
    ylabel('Normalized Value')
    subplot(2,2,4)
    barStacked(NORM.KDE.VAR.SG,j); title('KDE with Variable Bandwidth')
    ylabel('Normalized Value')
end

nv=1;
figure
barStacked(NORM.PDF.SG,nv); title('Probability Density Function')
figure
barStacked(NORM.PDF.FULL.SG,nv); title('Probability Density Function FULL')
