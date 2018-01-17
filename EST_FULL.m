function [xfull,yfull] = EST_FULL(setup,sg,nest,type,name)

xfull = [];
yfull = [];

for ireg=1:setup.DIV
[xest,~] = GridEst(setup,sg.pdf.truth.x,sg.pdf.truth.y,ireg,type,round(nest/setup.DIV)+1);
xest=xest(1:end-1);
yest = GridNew(sg,xest,name);
xfull = [xfull xest];
yfull = [yfull yest];
end
[~,i]=sort(xfull);
xfull = xfull(i);
yfull = yfull(i);
end