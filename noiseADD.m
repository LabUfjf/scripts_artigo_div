function [noise] = noiseADD(ypdf,f,noisetype)

if strcmp(noisetype,'gamma');
        noise   = noisegamma(ypdf,f);
end

if strcmp(noisetype,'normal');
        noise=f*randn(1,length(ypdf));
end

end

