function [V] = MINMAX_methods(sg,name,AR,ngrid,nt)

[V.xlimit.pdf(nt,:),V.A.pdf(nt)] = cdfpdf(sg,name,1-AR,ngrid);
% [V.xlimit.data(nt,:),V.A.data(nt)]  =  cdfdata(sg,name,1-AR,ngrid);

end