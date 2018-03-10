function [ycdf,ind] = make_cdf(sg,xest,type)


%%=========================================================================
%% Uniforme
%%=========================================================================
if strcmp(type,'Uniform')
    pd = makedist('Uniform',sg.g1.i,sg.g1.s);
    ycdf = cdf(pd,xest);
    [~,ind] = unique(ycdf);
end
%%=========================================================================
%% Gaussian
%%=========================================================================
if strcmp(type,'Gaussian')
    pd = makedist('Normal',sg.g1.mu,sg.g1.std);
    ycdf = cdf(pd,xest);
    [~,ind] = unique(ycdf);
end
%%=========================================================================
%% Bimodal
%%=========================================================================
if strcmp(type,'Bimodal')
    pd.g1 = makedist('Normal',sg.g1.mu,sg.g1.std);
    pd.g2 = makedist('Normal',sg.g2.mu,sg.g2.std);
    ycdf1 = cdf(pd.g1,xest);
    ycdf2 = cdf(pd.g2,xest);
    ycdf = (ycdf1+ycdf2)/2;
    [~,ind] = unique(ycdf);
end
%%=========================================================================
%% Rayleigh
%%=========================================================================
if strcmp(type,'Rayleigh')
    pd = makedist('Rayleigh',sg.b);
    ycdf = cdf(pd,xest);
    [~,ind] = unique(ycdf);
end
%%=========================================================================
%% LogNormal
%%=========================================================================
if strcmp(type,'Logn')
    pd = makedist('Lognormal',sg.mu,sg.std);
    ycdf = cdf(pd,xest);
    [~,ind] = unique(ycdf);
end
%%=========================================================================
%% Gamma
%%=========================================================================
if strcmp(type,'Gamma')
    pd = makedist('Gamma',sg.A,sg.B);
    ycdf = cdf(pd,xest);
    [~,ind] = unique(ycdf);
end


end
