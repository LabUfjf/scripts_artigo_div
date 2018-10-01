function [K] = kernel_function(x,type,kind)
if strcmp(kind,'syms')    
syms x
end
switch type
    case 'Gaussian'
        K=(1/sqrt(2*pi))*exp(-((x.^2)/2)); %[-inf,inf]
    case 'Epanechnikov'
        K=(3/4)*(1-(x.^2));%[|x|<=1]
    case 'Uniform' 
        K=(1/2); %[|x|<=1]
    case 'Triangular'
        K=1-abs(x); %[|x|<=1]
    case 'Triweight'
        K=(35/32)*(1-(x.^2)).^3; %[|x|<=1]
    case 'Tricube'
        K=(70/81)*(1-abs(x.^3)); %[|x|<=1]
    case 'Biweight'
        K=(15/16)*(1-(x.^2)); %[|x|<=1]
    case 'Cosine'
        K=(pi/4)*cos((pi/2).*x); %[|x|<=1]
end

end