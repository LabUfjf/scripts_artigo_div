function [xKr] = A5_kM(kernel)

if strcmp(kernel,'Gaussian')     ;xKr = 3; end
if strcmp(kernel,'silverman')    ;xKr = -24; end
if strcmp(kernel,'epanechnikov') ;xKr = 3/35; end
if strcmp(kernel,'uniform')      ;xKr = 1/5; end
if strcmp(kernel,'triangular')   ;xKr = 1/15; end
if strcmp(kernel,'triweight')    ;xKr = 1/33; end
if strcmp(kernel,'tricube')      ;xKr = 1/22; end
if strcmp(kernel,'biweight')     ;xKr = 1/21; end
if strcmp(kernel,'cosine')       ;xKr = (pi^4-48*pi^2+384)/pi^4; end
