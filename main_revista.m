clear variables; close all; clc


N.EVT = 20000;
N.DIV = 10;
N.BLOCKS = 20;


[sg,bg,DATA] = datasetGen(N);
[IND,TARGET] = CV(N.EVT+N.EVT,N.BLOCKS);

[opt] = bin_choice(DATA.mix,IND,TARGET,N);


%   [DIV.SG(cvtr,:)] = DFSelect(y.ptr.sg,y.ptst.sg);
%   [DIV.BG(cvtr,:)] = DFSelect(y.ptr.bg,y.ptst.bg);