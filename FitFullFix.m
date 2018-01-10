function [xest,xgrid,yest,ygrid,ytruth,d] = FitFullFix(setup,sg,xsg,ireg,nest,name,itp,method,type,v,errortype)

[xest,d] = GridEst(setup,sg.pdf.truth.x,sg.pdf.truth.y,ireg,type,nest);
yest = GridNew(sg,xest,name);

[M] = ErrorMaxRS(xest,sg.pdf.truth.x,sg.pdf.truth.y);

if strcmp(method,'full')
    xgrid = [];
    ygrid = [];
    for i=1:setup.DIV
        xgrid = [xgrid xsg{i}];
        if i == ireg
            if strcmp(errortype,'var')
                ygrid = [ygrid interp1(xest,yest,xsg{i},itp{1},'extrap')+v*(max(sg.pdf.truth.y))*randn(length(xsg{i}),1)'];
            end
            if strcmp(errortype,'bias')
                ygrid = [ygrid interp1(xest,yest,xsg{i},itp{1},'extrap')+v];
            end
            if strcmp(errortype,'bypass')
                ygrid = [ygrid interp1(xest,yest,xsg{i},itp{1},'extrap')];
            end
            
        else
            ygrid = [ygrid GridNew(sg,xsg{i},name);];
        end
    end
    ytruth = GridNew(sg,xgrid,name);
end

if strcmp(method,'fit')
    xgrid =xsg{ireg};
    ygrid = interp1(xest,yest,xgrid,itp{1},'extrap');
    ytruth = GridNew(sg,xgrid,name);
end




end