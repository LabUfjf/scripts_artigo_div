function [xest,xgrid,yest,ygrid,ytruth,d] = FitFullFix(setup,sg,xsg,ireg,nest,name,itp,method,type)

[xest,d] = GridEst(setup,sg.pdf.truth.x,sg.pdf.truth.y,ireg,type,nest);
yest = GridNew(sg,xest,name);

[M] = ErrorMaxRS(xest,sg.pdf.truth.x,sg.pdf.truth.y);

if strcmp(method,'full')
    xgrid = [];
    ygrid = [];
    for i=1:setup.DIV
        xgrid = [xgrid xsg{i}];
        if i == ireg
            ygrid = [ygrid interp1(xest,yest,xsg{i},itp{1},'extrap')];
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