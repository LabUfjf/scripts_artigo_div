function [Y,data] = DIVFIX(data)

interp = 'nearest';

data = rmfield(data,'pdf');
data = rmfield(data,'evt');
data = rmfield(data,'nPoint');
% data = rmfield(data,'Div');

% REGION SELECTION
nr = length(data.RoI.x.dy);
nb = length(data.COMP.bin);

for i = 1:nr
    for j = 1:nb
    Y.truth.dy{i}{j} = interp1(data.COMP.x,data.COMP.truth.y{j},data.RoI.x.dy{i},interp,'extrap');
    Y.truth.py{i}{j} = interp1(data.COMP.x,data.COMP.truth.y{j},data.RoI.x.py{i},interp,'extrap');
    Y.truth.eq.dy{i}{j} = interp1(data.COMP.x,data.COMP.truth.y{j},data.RoI.x.eq.dy{i},interp,'extrap');
    Y.truth.eq.py{i}{j} = interp1(data.COMP.x,data.COMP.truth.y{j},data.RoI.x.eq.py{i},interp,'extrap');
    
    Y.hist.dy{i}{j} = interp1(data.COMP.x,data.COMP.hist.y{j},data.RoI.x.dy{i},interp,'extrap');
    Y.hist.py{i}{j} = interp1(data.COMP.x,data.COMP.hist.y{j},data.RoI.x.py{i},interp,'extrap');
    Y.hist.eq.dy{i}{j} = interp1(data.COMP.x,data.COMP.hist.y{j},data.RoI.x.eq.dy{i},interp,'extrap');
    Y.hist.eq.py{i}{j} = interp1(data.COMP.x,data.COMP.hist.y{j},data.RoI.x.eq.py{i},interp,'extrap');
    
    Y.ash.dy{i}{j} = interp1(data.COMP.x,data.COMP.ash.y{j},data.RoI.x.dy{i},interp,'extrap');
    Y.ash.py{i}{j} = interp1(data.COMP.x,data.COMP.ash.y{j},data.RoI.x.py{i},interp,'extrap');
    Y.ash.eq.dy{i}{j} = interp1(data.COMP.x,data.COMP.ash.y{j},data.RoI.x.eq.dy{i},interp,'extrap');
    Y.ash.eq.py{i}{j} = interp1(data.COMP.x,data.COMP.ash.y{j},data.RoI.x.eq.py{i},interp,'extrap');
    
    Y.kde.dy.fix{i}{j} = interp1(data.COMP.x,data.COMP.kde.y.fix{j},data.RoI.x.dy{i},interp,'extrap');
    Y.kde.py.fix{i}{j} = interp1(data.COMP.x,data.COMP.kde.y.fix{j},data.RoI.x.py{i},interp,'extrap');
    Y.kde.eq.dy.fix{i}{j} = interp1(data.COMP.x,data.COMP.kde.y.fix{j},data.RoI.x.eq.dy{i},interp,'extrap');
    Y.kde.eq.py.fix{i}{j} = interp1(data.COMP.x,data.COMP.kde.y.fix{j},data.RoI.x.eq.py{i},interp,'extrap');
    
    Y.kde.dy.var{i}{j} = interp1(data.COMP.x,data.COMP.kde.y.var{j},data.RoI.x.dy{i},interp,'extrap');
    Y.kde.py.var{i}{j} = interp1(data.COMP.x,data.COMP.kde.y.var{j},data.RoI.x.py{i},interp,'extrap');
    Y.kde.eq.dy.var{i}{j} = interp1(data.COMP.x,data.COMP.kde.y.var{j},data.RoI.x.eq.dy{i},interp,'extrap');
    Y.kde.eq.py.var{i}{j} = interp1(data.COMP.x,data.COMP.kde.y.var{j},data.RoI.x.eq.py{i},interp,'extrap');
    end
end

end