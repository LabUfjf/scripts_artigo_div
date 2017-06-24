clear variables; close all; clc


N.EVT = 100000;
N.DIV = 10;
N.BLOCKS = 20;


[sg,bg,DATA] = datasetGen(N);
% [IND,TARGET] = CV(N.EVT+N.EVT,N.BLOCKS);
% [opt] = bin_choice(DATA.mix,IND,TARGET,N);

% M.sg=[sg.gauss.evt ; ...
%     sg.normal.evt ; ...
%    sg.rayleigh.evt ; ...
%    sg.logn.evt ; ...
%    sg.gamma.evt];

DATASET = DATA.sg(3,:);

TH = 1;

[le,ld] = tail_choice_pdf(sg.rayleigh.pdf.x.all,sg.rayleigh.pdf.y.all,TH);
hold on
[le,ld] = tail_choice_data(DATASET,TH);
% legend show


[pe,pd,gridx] = cdfdata(DATASET,0.1,100)
% [pe,pd,gridx] = cdfdata(el_fcCand2_rhad,0.1,100)
% [le.data,ld.data,T] = tail_choice_data(DATA.sg(1,:));

plot(pe,0,'sc',pd,0,'sc','DisplayName','CDF')
legend show
% figure
% plot(T.v)
%   [DIV.SG(cvtr,:)] = DFSelect(y.ptr.sg,y.ptst.sg);
%   [DIV.BG(cvtr,:)] = DFSelect(y.ptr.bg,y.ptst.bg);


% [pe,pd,gridx] = cdfdata(DATASET,TH,100)

% testar variaveis 6 - eratio ; jato (test)
                 % 1 - rhad ; both
                 % 3 - elétron