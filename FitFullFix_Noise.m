function [xest,xgrid,yest,ygrid,ytruth,d] = FitFullFix_Noise(setup,sg,xsg,ireg,nest,name,itp,method,type,v,errortype,nt)

[xest,d] = GridEst(setup,sg.pdf.truth.x,sg.pdf.truth.y,ireg,type,round(nest/setup.DIV)+1);
xest=xest(1:end-1);
yest = GridNew(sg,xest,name);

xRoI=cell2mat(sg.RoI.x);
yRoI=cell2mat(sg.RoI.y);
repmat(1:setup.DIV,length(sg.RoI.x{1}),1)
% [M] = ErrorMaxRS(xest,sg.pdf.truth.x,sg.pdf.truth.y);

if strcmp(method,'full')
    xgrid = [];
    ygrid = [];
    for i=1:setup.DIV
        xgrid = [xgrid xsg{i}];
        if i == ireg
            
            if strcmp(errortype,'var')
                ygrid = [ygrid interp1(xest,yest,xsg{i},itp{1},'extrap')+v*(max(sg.pdf.truth.y))*randn(length(xsg{i}),1)'];
            end
            
            if strcmp(errortype,'normal')
                [xfull,yfull] = EST_FULL(setup,sg,nest,type,name);
                [signal] = noiseADD(yfull,yfull,v,[],'normal',nt);
                ygrid = [ygrid interp1(xfull',signal',xsg{i},itp{1},'extrap')];
                %                 1
            end
            
            if strcmp(errortype,'poisson')
                [xfull,yfull] = EST_FULL(setup,sg,nest,type,name);
                [signal] = noiseADD(yfull,yfull,[],v,'poisson',nt); signal = signal/area2d(xfull,signal);
                ygrid = [ygrid interp1(xfull,signal,xsg{i},itp{1},'extrap')];
            end
            
            if strcmp(errortype,'bias')
                ygrid = [ygrid interp1(xest,yest,xsg{i},itp{1},'extrap')+v];
            end
            
            if strcmp(errortype,'bypass')
                ygrid = [ygrid interp1(xest,yest,xsg{i},itp{1},'extrap')];
            end
            
        else
            %               A = repmat(GridNew(sg,xsg{i},name),nt,1);
            %               gridx= xsg{i};
            %               save teste xfull yfull gridx signal ygrid A
            %               pause
            ygrid = [ygrid repmat(GridNew(sg,xsg{i},name),nt,1)'];
        end
    end
    ytruth = GridNew(sg,xgrid,name);
end

if strcmp(method,'fit')
    ygrid = [];
    xgrid =xsg{ireg};
    if strcmp(errortype,'var')
        ygrid = [ygrid interp1(xest,yest,xgrid,itp{1},'extrap')+v*(max(xgrid))*randn(length(xgrid),1)'];
    end
    if strcmp(errortype,'normal')
        [signal] = noiseADD(GridNew(sg,xgrid,name),GridNew(sg,xgrid,name),[],v,'normal',nt);
        ygrid = [ygrid interp1(xgrid,signal,xgrid,itp{1},'extrap')];
    end
    if strcmp(errortype,'poisson')
        [xfull,yfull] = EST_FULL(setup,sg,nest,type,name);
        [signal] = noiseADD(yfull,yfull,[],v,'poisson'); signal = signal/area2d(xfull,signal);
        ygrid = [ygrid interp1(xfull,signal,xgrid,itp{1},'extrap')];
    end
    if strcmp(errortype,'bias')
        ygrid = [ygrid interp1(xest,yest,xgrid,itp{1},'extrap')+v];
    end
    if strcmp(errortype,'bypass')
        ygrid = [ygrid interp1(xest,yest,xgrid,itp{1},'extrap')];
    end
    ytruth = GridNew(sg,xgrid,name);
end




end