function [xfull] = xRoIfull(setup,sg)
xfull.dy = [];
xfull.py = [];
xfull.eq.dy = [];
xfull.eq.py = [];

for RoI=1:setup.DIV   
    xfull.dy = [xfull.dy sg.RoI.x.dy{RoI}];
    xfull.py = [xfull.py sg.RoI.x.py{RoI}];
    xfull.eq.dy = [xfull.eq.dy sg.RoI.x.eq.dy{RoI}];
    xfull.eq.py = [xfull.eq.py sg.RoI.x.eq.py{RoI}];
end

xfull.dy = sort(xfull.dy);
xfull.py = sort(xfull.py);
xfull.eq.dy = sort(xfull.eq.dy);
xfull.eq.py = sort(xfull.eq.py);