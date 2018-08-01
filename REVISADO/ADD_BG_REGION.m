function [y] = ADD_BG_REGION(xest,yest,signal,xgridM,setup)

ygridM = interp1(xest,signal,xgridM,setup.TYPE.INTERP,'extrap');
yestM = interp1(xest,yest,xgridM,setup.TYPE.INTERP,'extrap');

y = ygridM;
y(setup.ROIBG,:)= yestM(setup.ROIBG,:);

end