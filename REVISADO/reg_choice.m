function [x,y,Xaxis,ind] = reg_choice(xpdf,ypdf,div,type)
%==========================================================================
% Objetivo: *Gerar as Regi�es de Interesse
%==========================================================================
if ~strcmp(type,'bypass')
    if div ==1
        i=1;
        x{i} = xpdf;
        y{i} = ypdf;
        Xaxis = xpdf;
        ind = 1:length(xpdf);
    else
        [ind,Xaxis]= LVector(xpdf,ypdf,div,type);
        for i = 1:div
            x{i} = xpdf(ind{i});
            y{i} = ypdf(ind{i});            
        end
    end
end

end



