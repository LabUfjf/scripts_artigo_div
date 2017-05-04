%% CHOICE REGION
clear variables; close all; clc

N.EVT = 20000;
[sg,bg,DATA] = datasetGen(N.EVT);

sg.normal.g1

normal


pd = makedist('Normal',sg.normal.g1.mu,sg.normal.g1.std);
ycdf = cdf(pd,sort(DATA.sg(1,:)));


d=diff(sg.gauss.pdf.x.all); d = d(1);
ydiff=diff(sg.gauss.pdf.y.all)/d;



subplot(4,1,1); plot(sg.gauss.pdf.x.all,sg.gauss.pdf.y.all);
subplot(4,1,2); plot(sort(DATA.sg(1,:)),ycdf)
subplot(4,1,3); plot(sg.gauss.pdf.x.all(1:end-1),ydiff);
subplot(4,1,4); plot(sg.gauss.pdf.x.all(1:end-1),abs(ydiff/max(ydiff)));