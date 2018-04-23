function [indreg,X]= LVector(xpdf,ypdf,div,type)
%==========================================================================
% Objetivo: *Gerar os Índices da RoI de acordo com a requisição
%==========================================================================
[IND] = INDGEN(xpdf,div);

%% => RoI Baseada na distribuição
if strcmp(type,'dist')
    for i = 1:div
        indreg{i}= IND(:,i);
    end
    X = linspace(min(xpdf),max(xpdf),div);
end
%% => RoI Baseada na primeira derivada
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
%% => RoI Baseada na segunda derivada
if strcmp(type,'deriv2')
    h = diff(xpdf);
    deriv = diff(ypdf)./h;
    deriv2 = diff(deriv);
    deriv = [deriv2 deriv2(end) deriv2(end)];
    Mderiv = deriv(IND);
    X = mean(abs(Mderiv));
    [~,ideriv]=sort(X);
    for i = 1:div
        indreg{i}= IND(:,ideriv(i));       
    end  
end
%% => RoI Baseada na probabilidade
if strcmp(type,'prob')
    X = mean(ypdf(IND));
    [~,iprob]=sort(X);
    for i = 1:div
        indreg{i}= IND(:,iprob(i));
    end
end

X=sort(X);

rangeRoI.min = min(xpdf(cell2mat(indreg)));
rangeRoI.max = max(xpdf(cell2mat(indreg)));
rangeRoI.mean = mean(xpdf(cell2mat(indreg)));
save rangeRoI rangeRoI
end
