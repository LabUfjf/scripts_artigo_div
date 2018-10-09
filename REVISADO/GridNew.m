function [ytruth] = GridNew(sg,x,name)
%==========================================================================
% Objetivo: * Gerar as probabilidades da PDF analítica de acordo com o grid
%==========================================================================
switch name
    case 'Uniform'
        ytruth = pdf(makedist('Uniform','lower',sg.g1.i,'upper',sg.g1.s),x);
    case 'Gaussian'
        ytruth = normpdf(x,sg.g1.mu,sg.g1.std);
    case 'Bimodal'
        ytruth = (normpdf(x,sg.g1.mu,sg.g1.std) + normpdf(x,sg.g2.mu,sg.g2.std))/2;
         case 'Trimodal'
        ytruth = (normpdf(x,sg.g1.mu,sg.g1.std) + normpdf(x,sg.g2.mu,sg.g2.std) + normpdf(x,sg.g3.mu,sg.g3.std))/3;
    case 'Rayleigh'
        ytruth = raylpdf(x,sg.b);
    case 'Logn'
        ytruth = lognpdf(x,sg.mu,sg.std);
    case 'Gamma'
        ytruth = gampdf(x,sg.A,sg.B);
            case 'Laplace'
        ytruth = laplacecdf(x,sg.mu,sg.std);
end

end