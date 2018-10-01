function [pdf,X,h] = KDEflex(data,nPoint,h,METHOD)

KFUNCTION = 'Gaussian';

[nd,n,data]= format_data(data);

if isempty(h)
h =((4/(nd+2))^(1/(nd+4)))*std(data)*n^(-1/(nd+4)); % cálculo do h("rule-of-thumb") ótimo pelo AMISE
end
X = linspace(min(data),max(data),nPoint);
if nd ==1
[pdf,X] = fastModule(data,nPoint,h,KFUNCTION,METHOD);
else
end
end

function [nd,n,data]= format_data(data)

[nd,n] = size(data);

if nd>n
    data = data';
    [nd,n] = size(data);
end

end


