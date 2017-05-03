function [noise] = noiseADD(ypdf,f,noisetype)

if strcmp(noisetype,'gamma');
        noise.all   = noisegamma(ypdf.sg.eq.all,f);
        noise.tail  = noisegamma(ypdf.sg.eq.tail,f);
        noise.deriv = noisegamma(ypdf.sg.eq.deriv,f);
        noise.head  = noisegamma(ypdf.sg.eq.head,f);

        noise.bg.all   = noisegamma(ypdf.bg.eq.all,f);
        noise.bg.tail  = noisegamma(ypdf.bg.eq.tail,f);
        noise.bg.deriv = noisegamma(ypdf.bg.eq.deriv,f);
        noise.bg.head  = noisegamma(ypdf.bg.eq.head,f);
end

if strcmp(noisetype,'normal');
        noise.sg.all=f*randn(1,length(ypdf.sg.eq.all));
        noise.sg.tail=f*randn(1,length(ypdf.sg.eq.tail));
        noise.sg.deriv=f*randn(1,length(ypdf.sg.eq.deriv));
        noise.sg.head=f*randn(1,length(ypdf.sg.eq.head));

        noise.bg.all=f*randn(1,length(ypdf.bg.eq.all));
        noise.bg.tail=f*randn(1,length(ypdf.bg.eq.tail));
        noise.bg.deriv=f*randn(1,length(ypdf.bg.eq.deriv));
        noise.bg.head=f*randn(1,length(ypdf.bg.eq.head));
end

end

