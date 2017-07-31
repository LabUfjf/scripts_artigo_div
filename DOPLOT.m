function []= DOPLOT(A,B,data,tag)

% for i=1:12
%     figure(1)
%     subplot(3,4,i);plot(M.hist.py{1}(:,i),'k'); hold on
%     subplot(3,4,i);plot(M.hist.dy{1}(:,i),'r')
%     subplot(3,4,i);plot(M.hist.eq.py{1}(:,i),':k'); hold on
%     subplot(3,4,i);plot(M.hist.eq.dy{1}(:,i),':r')
% end
%
% figure(2)
% plot(M.N.py,'k'); hold on
% plot(M.N.dy,'r')
% plot(M.N.eq.py,':k'); hold on
% plot(M.N.eq.dy,':r')
name = {'LP-LInf','LP-L2 Norm','L1-Sorensen','L1-Gower','IP-Innerproduct','IP-Harmonic','IP-Cosine','SQ-Hellinger','L2-Squared','L2-AddSym','SH-Kullback','CO-Kumar'};

for i=1:12
    for j=1:20;
        MT.hist{i}(:,j)= A{j}(:,i);      
        MTeq.hist{i}(:,j)= B{j}(:,i);
    end
    
    figure(1)
   
    subplot(3,4,i); mesh(data.COMP.bin,(1:size(A{1},1))/size(A{1},1),MT.hist{i})
    xlabel('Pts');   ylabel('RoI');   zlabel('Div'); title(['[' tag ']' name{i}]);
    
    figure(2)
    subplot(3,4,i); mesh(data.COMP.bin,(1:size(B{1},1))/size(B{1},1),MTeq.hist{i})
    xlabel('Pts');   ylabel('RoI');   zlabel('Div');  title(['[' tag '(Eq)]' name{i}]);
end



end