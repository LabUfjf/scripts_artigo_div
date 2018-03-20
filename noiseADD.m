function [noise] = noiseADD(xpdf,ypdf,f,noisetype)



if strcmp(noisetype,'normal');
    noise=ypdf+(f*max(ypdf))*randn(1,length(ypdf));
end

if strcmp(noisetype,'poisson');
    [noise] = PoissonADD(ypdf,ypdf,f);
    noise = noise/(area2d(xpdf,noise));
end

if strcmp(noisetype,'noisemix');
    modelfit=NoiseMix(xpdf,ypdf,f);    
    noise = ypdf+modelfit(xpdf)'.*randn(1,length(ypdf));    
%     plot(noise)
%     pause    
end

if strcmp(noisetype,'no');
    noise = ypdf;
end

end

