

nest = 100;
method = 'fit';
errortype='poisson';

xRoI=cell2mat(sg.RoI.x);
yRoI=cell2mat(sg.RoI.y);

Ind= repmat(1:setup.DIV,length(sg.RoI.x{1}),1); Ind=Ind(:);
IndRoI= reshape(1:setup.PTS,setup.PTS/setup.DIV,setup.DIV);

xest = linspace(min(xRoI),max(xRoI),nest);
yest = GridNew(sg,xest,name);

[signal] = noiseADD(xest,yest,f,errortype);

ygrid = interp1(xest,signal,xRoI,'linear','extrap');
ygridM = ygrid(IndRoI)';


if strcmp(method,'full')
    MRoI = repmat(yRoI,setup.DIV,1);
    for i=1:setup.DIV
        MRoI(i,IndRoI(:,i)) = ygridM(i,:);
    end
end

if strcmp(method,'fit')
    for i=1:setup.DIV
        MRoI(i,:) = ygridM(i,:);
    end
end



