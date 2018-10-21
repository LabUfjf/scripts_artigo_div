function [h] = h_plugin(DATA) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Silverman (1986)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
type = 'Gaussian';
[~,n,DATA]= format_data(DATA);
r = 0; 
h.PI.SV = ((4/3)^(1/5))*(std(DATA)*n^(-1/5)); 
%  h = (4/(n*(d + 2)))^(2/(d + 4)) * std(DATA);
% hsilver =((4/(nd+2))^(1/(nd+4)))*std(DATA)*n^(-1/(nd+4));
% hsilver =((4/(nd+2))^(1/(nd+4)))*std(DATA)*n^(-1/(nd+4));
% Silverman Rule of Thumb- Gaussian Kernel
h.PI.SVM1 = 0.79*diff(prctile(DATA, [25; 75]))*(n^(-1/5)); 
% Silverman Robusto- Gaussian Kernel - Interquartil - bom em caudas longas 
%e assimetricas  mas é ruim em casos bimodais por ser oversmoothed 
h.PI.SVM2 = 0.9*min(std(DATA),diff(prctile(DATA, [25; 75]))/1.34)*(n^(-1/5)); 
% Silverman h adaptativo, Teoricamente o melhor dos dois mundos, é bom até skewness de 1.8
%  para a mistura normal com separação até 3 desvios padrão
% h=n^(-2/(d + 4)) * std(DATA);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % PARK e MARRON (1990)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %-> Aprender rugosidade R, calculo de C
% h = Co*n^(-1/5);
% C0 = (R(K)/(sigma4k*R(f'')))^(1/5);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SHEATHER e JONES (1991)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h.PI.SJ = SJbandwidth(DATA');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Scott(1992)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h.PI.SC = ((243 *(2*r+1)*Rg(kernel_fun_der(type,r)))/(35* A2_kM(type)^2))^(1/(2*r+5)) * std(DATA) * n^(-1/(2*r+5));

end