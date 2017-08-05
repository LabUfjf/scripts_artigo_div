function [M] = DIVCALC(Y)
norm = 'norm'; %normalizar Divergências
nr = length(Y.sg.truth.dy);
nb = length(Y.sg.truth.dy{1});

for i = 1 : nr
    for j = 1 : nb
        
        M.hist.py{j}(i,:) = DFSelect(Y.sg.truth.py{i}{j},Y.sg.hist.py{i}{j},norm);
        M.hist.dy{j}(i,:) = DFSelect(Y.sg.truth.dy{i}{j},Y.sg.hist.dy{i}{j},norm);
        M.ash.py{j}(i,:) = DFSelect(Y.sg.truth.py{i}{j},Y.sg.ash.py{i}{j},norm);
        M.ash.dy{j}(i,:) = DFSelect(Y.sg.truth.dy{i}{j},Y.sg.ash.dy{i}{j},norm);
        M.kde.dy.var{j}(i,:) = DFSelect(Y.sg.truth.dy{i}{j},Y.sg.kde.dy.var{i}{j},norm);
        M.kde.py.var{j}(i,:) = DFSelect(Y.sg.truth.py{i}{j},Y.sg.kde.py.var{i}{j},norm);
        M.kde.dy.fix{j}(i,:) = DFSelect(Y.sg.truth.dy{i}{j},Y.sg.kde.dy.fix{i}{j},norm);
        M.kde.py.fix{j}(i,:) = DFSelect(Y.sg.truth.py{i}{j},Y.sg.kde.py.fix{i}{j},norm);
        
        M.hist.eq.py{j}(i,:) = DFSelect(Y.sg.truth.eq.py{i}{j},Y.sg.hist.eq.py{i}{j},norm);
        M.hist.eq.dy{j}(i,:) = DFSelect(Y.sg.truth.eq.dy{i}{j},Y.sg.hist.eq.dy{i}{j},norm);
        M.ash.eq.py{j}(i,:) = DFSelect(Y.sg.truth.eq.py{i}{j},Y.sg.ash.eq.py{i}{j},norm);
        M.ash.eq.dy{j}(i,:) = DFSelect(Y.sg.truth.eq.dy{i}{j},Y.sg.ash.eq.dy{i}{j},norm);
        M.kde.eq.dy.var{j}(i,:) = DFSelect(Y.sg.truth.eq.dy{i}{j},Y.sg.kde.eq.dy.var{i}{j},norm);
        M.kde.eq.py.var{j}(i,:) = DFSelect(Y.sg.truth.eq.py{i}{j},Y.sg.kde.eq.py.var{i}{j},norm);
        M.kde.eq.dy.fix{j}(i,:) = DFSelect(Y.sg.truth.eq.dy{i}{j},Y.sg.kde.eq.dy.fix{i}{j},norm);
        M.kde.eq.py.fix{j}(i,:) = DFSelect(Y.sg.truth.eq.py{i}{j},Y.sg.kde.eq.py.fix{i}{j},norm);
        
        M.N.py(i) =  length(Y.sg.hist.py{i}{1});
        M.N.dy(i) =  length(Y.sg.hist.dy{i}{1});
        
         M.N.eq.py(i) =  length(Y.sg.hist.eq.py{i}{1});
        M.N.eq.dy(i) =  length(Y.sg.hist.eq.dy{i}{1});
        
    end
end

% for j = 1 :12
%     plot(M1(:,j),'k'); hold on
% plot(M2(:,j),'r')
% pause
% close
% end

end
