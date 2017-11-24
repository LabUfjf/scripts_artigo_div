function [xest,xgrid,yest,ygrid,ytruth] = FitFullFix(setup,sg,xsg,ireg,nest,name,itp,method)


% xest = linspace(xsg{ireg}(1),xsg{ireg}(end),nest);
ind_est = round(linspace(1,length(xsg{ireg}),nest));
xest = xsg{ireg}(ind_est);
yest = GridNew(sg,xest,name);
% plot(xest,yest,'-')
% pause

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
    [~,ind]=sort(xgrid);
    xgrid = xgrid(ind);
    ygrid = ygrid(ind);
    ytruth = GridNew(sg,xgrid,name);
end

if strcmp(method,'fit')
    xgrid =xsg{ireg};
    ygrid = interp1(xest,yest,xgrid,itp{1},'extrap');
    ytruth = GridNew(sg,xgrid,name);
end

end