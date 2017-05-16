clear variables; close all; clc


N.EVT = 40000;
N.DIV = 10;
N.BLOCKS = 20;


[sg,bg,DATA] = datasetGen(N);
% [IND,TARGET] = CV(N.EVT+N.EVT,N.BLOCKS);

% [opt] = bin_choice(DATA.mix,IND,TARGET,N);

TH = 0.1;
[le,ld] = tail_choice_pdf(sg.normal.pdf.x.all,sg.normal.pdf.y.all,TH);
[le.data,ld.data,T] = tail_choice_data(DATA.sg(2,:),TH/2);
plot(le.data,0,'sc',ld.data,0,'sc','DisplayName','Data')
legend show
%   [DIV.SG(cvtr,:)] = DFSelect(y.ptr.sg,y.ptst.sg);
%   [DIV.BG(cvtr,:)] = DFSelect(y.ptr.bg,y.ptst.bg);