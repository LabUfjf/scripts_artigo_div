%% TESTE Bias X Variance

clear variables; close all; clc

Noise = 'poisson';
Nomalization = 'no';
method = 'full';
name = {'Bimodal'};

load PT_int1000

RoI = 1;
for nDiv  = 1:15;

[xfull,noise,signal] = noise_check(RoI,nDiv,name,'normal',PT_int,method)
subplot(1,2,1);plot(xfull.dy,signal.dy,'k',xfull.dy,noise.dy,'r'); axis tight

 [xfull,noise,signal] = noise_check(RoI,nDiv,name,'poisson',PT_int,method)
subplot(1,2,2);plot(xfull.dy,signal.dy,'k',xfull.dy,noise.dy,'r'); axis tight
pause
close
end