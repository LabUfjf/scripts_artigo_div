function [rnoise,xlab] = SETrange(errortype)
load f
if strcmp(errortype,'normal')
    rnoise = f.norm;
    xlab = 'Var';
else
    rnoise = f.poisson;
    xlab = 'Events';
end
end