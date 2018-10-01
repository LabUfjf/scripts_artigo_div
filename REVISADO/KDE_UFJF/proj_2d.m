function [x,prob,lambda]=proj_2d(data)
%% TRANSFORMAR DADOS EM MATRIX
% data=cell2mat(data);
%% CALCULAR BINAGEM ÓTIMA PELO DIACONES
bin1=calcnbins(data(1,:),'fd');
bin2=calcnbins(data(2,:),'fd');
[hist2D, binC] = hist3(data',[bin1 bin2]);
%% MARGINAL DA 1D NORMALIZADA AREA=1
[x.v1,prob.v1]=data_normalized((data(1,:)'),bin1);
[x.v2,prob.v2]=data_normalized((data(2,:)'),bin2);
%% CALCULAR PROBABILIDADES DA 2D NORMALIZADA VOLUME = 1
L = binC{1}(2) - binC{1}(1);
B = binC{2}(2) - binC{2}(1);
totalVolume = sum(sum(hist2D.*L*B));
prob.p2D = hist2D/totalVolume;
prob.p2D = prob.p2D';
%% CALCULAR PROJEÇÕES DA 2D
prob.proj.v1=max(prob.p2D);
prob.proj.v2=max(prob.p2D');
%% CALCULAR LAMBDA PELAS PROJEÇÕES E PELA PROBABILIDADE 2D
lambda.p2D=exp((1/length(data))*sum(log(prob.p2D(prob.p2D>0))));
lambda.proj(1)=exp((1/length(data))*sum(log(prob.proj.v1(prob.proj.v1>0))));
lambda.proj(2)=exp((1/length(data))*sum(log(prob.proj.v2(prob.proj.v2>0))));