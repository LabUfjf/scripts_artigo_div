function [xlimit,A] = stdrange(sg,name,ngrid)

xlimit(1)=mean(sg.evt)-(4*std(sg.evt));
xlimit(2)=mean(sg.evt)+(4*std(sg.evt));

xest=linspace(xlimit(1),xlimit(2),ngrid);
yest = GridNew(sg,xest,name);
A=rsum(xest,yest,'mid');
end