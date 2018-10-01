%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Silverman (1982)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h = ((4/3)^(1/5))*(std(x)*n^(-1/5)); 
% Silverman Rule of Thumb- Gaussian Kernel
h = 0.79*diff(prctile0(x, [25; 75]))*(n^(-1/5)); 
% Silverman Robusto- Gaussian Kernel - Interquartil - bom em caudas longas 
%e assimetricas  mas é ruim em casos bimodais por ser oversmoothed 
h = 0.9*min(std(x),diff(prctile0(x, [25; 75]))/1.34)*(n^(-1/5)); 
% Silverman h adaptativo, Teoricamente o melhor dos dois mundos, é bom até skewness de 1.8
%  para a mistura normal com separação até 3 desvios padrão
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PARK e MARRON (1990)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-> Aprender rugosidade R, calculo de C
h = Co*n^(-1/5);
C0 = (R(K)/(sigma4k*R(f'')))^(1/5);



