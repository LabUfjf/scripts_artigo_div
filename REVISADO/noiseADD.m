function [noise] = noiseADD(xpdf,ypdf,fc,noisetype)
%==========================================================================
% Objetivo: * Criar Diferentes tipos de Ruído
%==========================================================================
load f

if strcmp(noisetype,'normal');
    noise=ypdf+(fc*max(ypdf))*randn(1,length(ypdf));
end

if strcmp(noisetype,'poisson');
    [noise] = PoissonADD(ypdf,ypdf,fc);
    noise = noise/(area2d(xpdf,noise));
end

if strcmp(noisetype,'noisemix');
    load modelfit
    %     modelfit=NoiseMix(xpdf,ypdf,fc);
    ind=find(f.poisson==fc);
    noise = ypdf+(modelfit{ind}(xpdf)'.*randn(1,length(ypdf)));
    %     noise = ypdf+((ypdf/max(ypdf))*(f*max(ypdf))).*randn(1,length(ypdf));
end

if strcmp(noisetype,'biasn');
    noise = ypdf+(fc*max(ypdf));
end

if strcmp(noisetype,'biasp');
    load modelfit
    ind=find(f.poisson==fc);
    noise = ypdf+(modelfit{ind}(xpdf)');
end

if strcmp(noisetype,'none');
    noise = ypdf;
end



end

