clear variables; close all; clc
name = {'Gaussian'};
type = 'bypass';
[setup] = IN(100000,100000); setup.DIV = 1; setup.NAME = name{1};
[sg,~] = datasetGenSingle(setup,name{1},type);


m = 0;
xi = sort(sg.evt)+m;
xpdf=sg.pdf.truth.x+m;
ypdf = sg.pdf.truth.y;
fxi = interp1(xpdf,ypdf,xi,'nearest','extrap');
d2 = diff(xi);
d3=diff(xpdf);


M=sum(xpdf.*ypdf)/sum(ypdf);
M2=sum(xi(1:end-1).*fxi(1:end-1).*d2);
M3= sum(xpdf.*ypdf*d3(1));
M4 = sum(xpdf/length(xpdf));

V = sum(ypdf/sum(ypdf).*(xpdf.^2)-M^2);
V2 = sum(fxi(1:end-1).*d2.*(xi(1:end-1).^2))-M2^2;
V3 = sum((xpdf.^2).*ypdf*d3(1))-M3^2;
V4 = var(xi);

% [M M2 M3 M4]
[V V2 V3 V4]



