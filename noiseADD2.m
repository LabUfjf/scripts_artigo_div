function [noise] = noiseADD2(ypdf,f,noisetype)

if strcmp(noisetype,'gamma');
        noise.all   = noisegamma(ypdf.sg.eq.all,f);
        noise.tail  = noisegamma(ypdf.sg.eq.tail,f);
        noise.deriv = noisegamma(ypdf.sg.eq.deriv,f);
        noise.head  = noisegamma(ypdf.sg.eq.head,f);
end

if strcmp(noisetype,'normal');
        noise.sg.all=f*randn(1,length(ypdf.sg.eq.all));
        noise.sg.tail=f*randn(1,length(ypdf.sg.eq.tail));
        noise.sg.deriv=f*randn(1,length(ypdf.sg.eq.deriv));
        noise.sg.head=f*randn(1,length(ypdf.sg.eq.head));

end

end

