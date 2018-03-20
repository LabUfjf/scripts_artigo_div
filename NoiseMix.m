
function [modelfit] = NoiseMix(xest,yest,rn)

nt = 100;

for i = 1:nt
    [noiseN] = PoissonADD(yest,yest,rn);
    noiseP(i,:) = noiseN/(area2d(xest,noiseN));
end

modelfit = fit(xest',std(noiseP)','smoothingspline','smoothingparam',0.9999);
% plot(modelfit,xest',std(noiseP)');

% pause

% filename = ['NOISEMIX[' name{1} ']'];
% save(filename, 'modelfit') 
% pause
end