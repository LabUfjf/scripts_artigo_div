function [modelfit] = NoiseMix(xest,yest,rn)
%==========================================================================
% Objetivo: * Emular ruído de Poisson utilizando uma gaussiana
%==========================================================================
nt = 1000;
for i = 1:nt
    [noiseN] = PoissonADD(yest,yest,rn);
    noiseP(i,:) = noiseN/(area2d(xest,noiseN));
end

% save xest noiseP
% modelfit = fit(xest',std(noiseP)','smoothingspline','smoothingparam',0.9999);
% % plot(modelfit,xest',std(noiseP)');
% % pause
% filename = ['NOISEMIX[Gaussian]'];
% save(filename, 'modelfit') 
% pause
% save modelfit modelfit
end