function [noise] = noiseADD(ypdf,yfull,f,N,noisetype)

if strcmp(noisetype,'normal');
        noise=ypdf+f*randn(1,length(ypdf));
end

if strcmp(noisetype,'poisson');
[noise] = PoissonADD(ypdf,yfull,N);
end

end

