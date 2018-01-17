function [noise] = noiseADD(xpdf,ypdf,f,noisetype)

if strcmp(noisetype,'normal');
    noise=ypdf+f*randn(1,length(ypdf));
end

if strcmp(noisetype,'poisson');
    [noise] = PoissonADD(ypdf,ypdf,f);
    noise = noise/area2d(xpdf,noise);
end

end

