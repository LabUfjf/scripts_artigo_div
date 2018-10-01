function [xKr] = A3_kM(kernel)

if strcmp(kernel,'Gaussian')     ;xKr = 1/(2*sqrt(pi)); end
if strcmp(kernel,'silverman')    ;xKr = (3/16)*sqrt(2); end
if strcmp(kernel,'epanechnikov') ;xKr = 3/5; end
if strcmp(kernel,'uniform')      ;xKr = 1/2; end
if strcmp(kernel,'triangular')   ;xKr = 2/3; end
if strcmp(kernel,'triweight')    ;xKr = 350/429; end
if strcmp(kernel,'tricube')      ;xKr = 175/247; end
if strcmp(kernel,'biweight')     ;xKr = 5/7; end
if strcmp(kernel,'cosine')       ;xKr = (1/16)*pi^2; end

