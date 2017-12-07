

xest=linspace(evtMin,evtMax,1000000);
yest = GridNew(sg,xest,name);
[xi,yi] = polyxpoly(yest,xest,[max(yest)*0.01 max(yest)*0.01],[min(xest) max(xest)]);