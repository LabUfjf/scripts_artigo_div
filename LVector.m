function [indreg,X]= LVector(xpdf,ypdf,div,type)

% xpdf=sg.pdf.truth.x;
% ypdf=sg.pdf.truth.y;
% div = 20;

N = length(xpdf);
IND = reshape(1:N,round(N/div),div);

if strcmp(type,'dist')
    for i = 1:div
        indreg{i}= IND(:,i);
    end
    X = linspace(min(xpdf),max(xpdf),div);
end

if strcmp(type,'deriv')
    h = diff(xpdf);
    deriv = diff(ypdf)./h;
    deriv = [deriv deriv(end)];
    Mderiv = deriv(IND);
    X = mean(abs(Mderiv));
    [~,ideriv]=sort(X);
    for i = 1:div
        indreg{i}= IND(:,ideriv(i));       
    end  
end

if strcmp(type,'prob')
    X = mean(ypdf(IND));
    [~,iprob]=sort(X);
    for i = 1:div
        indreg{i}= IND(:,iprob(i));
    end
end

X=sort(X);




end
