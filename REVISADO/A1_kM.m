function [xKr] = A1_kM(kernel)
        
if strcmp(kernel,'Gaussian');     xKr = 1/(2*sqrt(pi)); end
if strcmp(kernel,'silverman');    xKr = (5/32)*sqrt(2); end
if strcmp(kernel,'epanechnikov'); xKr = 9/70; end
if strcmp(kernel,'uniform');      xKr = 1/6; end
if strcmp(kernel,'triangular');   xKr = 7/60; end
if strcmp(kernel,'triweight');    xKr = 245/2574; end
if strcmp(kernel,'tricube');      xKr = 4291/39366; end
if strcmp(kernel,'biweight');     xKr = 25/231; end
if strcmp(kernel,'cosine');       xKr = 1/8; end
