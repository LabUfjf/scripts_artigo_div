

nest = 100;
method = 'full'
errortype='poisson';



xRoI=cell2mat(sg.RoI.x);
yRoI=cell2mat(sg.RoI.y);

plot(xRoI,yRoI); hold on

Ind= repmat(1:setup.DIV,length(sg.RoI.x{1}),1);
IndRoI= reshape(1:setup.PTS,setup.DIV,setup.PTS/setup.DIV);
% IndRoI= [IndRoI(1,:); IndRoI(end,:)];

xest = linspace(min(xRoI),max(xRoI),nest);
yest = GridNew(sg,xest,name);

Ind=Ind(:);


[signal] = noiseADD(xest,yest,1000,errortype); 


% indReg =(Ind==10);
% for i = 1:10;
%     iM(i,:)=(Ind==i);
% end

ygrid = interp1(xest,signal,xRoI,'linear','extrap');

if strcmp(method,'full')
    MRoI = repmat(yRoI,setup.DIV,1); 
    MRoI(IndRoI') = ygrid(IndRoI');
%     ygrid = yRoI;
%     xRoI = xRoI(IndRoI);
end
% if strcmp(method,'fit')
%     xRoI = xRoI(indReg)
%     ygrid = ygrid;
% end
% % indReg.fit = find(Ind==10);



plot(xRoI,ygrid,'.b')
stairs(xest,signal,':k')

