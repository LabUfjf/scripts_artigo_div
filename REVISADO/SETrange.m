function [setup] = SETrange(setup)
load f
if strcmp(setup.TYPE.NOISE,'normal')
    setup.RANGE.NOISE = f.norm;
end
if strcmp(setup.TYPE.NOISE,'noisemix')
    setup.RANGE.NOISE = f.poisson;
end
if strcmp(setup.TYPE.NOISE,'poisson')
    setup.RANGE.NOISE = f.poisson;
end

if strcmp(setup.TYPE.NOISE,'none')
    setup.RANGE.NOISE = f.norm;
end

if strcmp(setup.TYPE.NOISE,'biasp')
    setup.RANGE.NOISE = f.poisson;
end

if strcmp(setup.TYPE.NOISE,'biasn')
    setup.RANGE.NOISE = f.norm;
end

end