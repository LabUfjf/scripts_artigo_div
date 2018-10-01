function[xKr] = A4_kM(kernel)

if strcmp(kernel,'Gaussian')     ;xKr = 3/(8*sqrt(pi)); end
if strcmp(kernel,'silverman')    ;xKr = (1/16)*sqrt(2); end
if strcmp(kernel,'epanechnikov') ;xKr = 9/2; end
if strcmp(kernel,'uniform')      ;xKr = 0; end
if strcmp(kernel,'triangular')   ;xKr = 0; end
if strcmp(kernel,'triweight')    ;xKr = 35; end
if strcmp(kernel,'tricube')      ;xKr = 7840/243; end
if strcmp(kernel,'biweight')     ;xKr = 22.5; end
if strcmp(kernel,'cosine')       ;xKr = (1/256)*pi^6; end


