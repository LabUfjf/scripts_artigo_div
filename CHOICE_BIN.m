%% BIN CHOICE
clear variables; close all; clc

N.EVT = 20000;

[sg,bg,DATA] = datasetGen(N.EVT);




datastep = DATA.sg(1,:)
[yh,xh]=hist(DATA.sg(1,:),100);