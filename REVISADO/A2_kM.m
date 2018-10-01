function [xKr] = A2_kM(kernel)

if strcmp(kernel,'Gaussian');     xKr = 1; end
if strcmp(kernel,'silverman');    xKr = 0; end
if strcmp(kernel,'epanechnikov'); xKr = 1/5; end
if strcmp(kernel,'uniform');      xKr = 1/3; end
if strcmp(kernel,'triangular');   xKr = 1/6; end
if strcmp(kernel,'triweight');    xKr = 1/9; end
if strcmp(kernel,'tricube');      xKr = 35/243; end
if strcmp(kernel,'biweight');     xKr = 1/7; end
if strcmp(kernel,'cosine');       xKr = (-8+pi^2)/pi^2; end

