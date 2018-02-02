function [xest,xgrid,yest,ygrid,ytruth] = Method_ADDNoise(setup,sg,nest,f,name,itp,method,errortype)

xRoI=cell2mat(sg.RoI.x);
yRoI=cell2mat(sg.RoI.y);

% IndRoI= reshape(cell2mat(sg.RoI.ind),setup.PTS/setup.DIV,setup.DIV);
IndRoI= reshape(1:setup.PTS,setup.PTS/setup.DIV,setup.DIV);

xest = linspace(min(xRoI),max(xRoI),nest);
yest = GridNew(sg,xest,name);
signal = noiseADD(xest,yest,f,errortype);


xgridM = xRoI(IndRoI)';
ygridM = interp1(xest,signal,xgridM,itp{1},'extrap');

if setup.DIV == 1
    xgrid = sg.pdf.truth.x;
    ygrid = interp1(xest,signal,xgrid,itp{1},'extrap');
    ytruth = sg.pdf.truth.y;
else
    if strcmp(method,'full')
        MyRoI = repmat(yRoI,setup.DIV,1);
        MxRoI = repmat(xRoI,setup.DIV,1);
        for i=1:setup.DIV
            MyRoI(i,IndRoI(:,i)) = ygridM(i,:);
        end
        [~,ind]=sort(xRoI);
        xgrid = MxRoI(:,ind);
        ygrid = MyRoI(:,ind);
        ytruth = GridNew(sg,xgrid,name);
    end
    if strcmp(method,'fit')
        for i=1:setup.DIV
            MyRoI(i,:) = ygridM(i,:);
        end
        xgrid = xRoI(IndRoI)';
        ygrid = MyRoI;
        ytruth = GridNew(sg,xgrid,name);
    end
end

end