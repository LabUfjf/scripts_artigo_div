function [V] = MINMAX_methods(V,sg,name,AR,ngrid,nt)

[V.xlimit.pdf(nt,:),V.A.pdf(nt)] = cdfpdf(sg,name,1-AR,ngrid);
[V.xlimit.data(nt,:),V.A.data(nt)]  =  cdfdata(sg,name,1-AR,ngrid);
% [V.xlimit.std(nt,:),V.A.std(nt)] = stdrange(sg,name,ngrid,4);

end