
clear
load f


[setup] = IN('Gaussian','sg','poisson','dist','linear','bypass',1,1e4,1000,1);   % Definir os Parâmetros Iniciais
[DATA] = datasetGenSingle(setup);
[X.EST,X.GRID,Y.EST,Y.GRID,Y.TRUTH] = Method_ADDNoise(setup,DATA,100);
Q =Y.TRUTH;
% subplot(3,1,1);xlabel('Probability'); ylabel('Amplitude'); legend('(P-Q).^2', '(P+Q)')

sd = [1 round(length(f.poisson)/2) length(f.poisson)];
cl = ['rgbk']

for j = 1:length(sd)
    for i=1:700
        
        [~,~,Y.EST,P,~] = Method_ADDNoise(setup,DATA,f.poisson(sd(j)));
        
        MF1(i,:)=(P.^2-Q.^2).^2;
        MF2(i,:)=2*((P.*Q).^(3/2));
    end
    
    subplot(2,2,1);plot(Q,(mean(MF1)),[':' cl(j)]); hold on;
    subplot(2,2,2);plot(Q,(mean(MF2)),[':' cl(j)]); hold on;
    subplot(2,2,3:4);plot(Q,real((mean(MF1))./(mean(MF2))),['-' cl(j)]); hold on;
    
    
end
subplot(2,2,1);legend('(P²-Q²)²[1]','(P²-Q²)²[2]','(P²-Q²)²[3]');xlabel('Probability'); ylabel('Amplitude'); grid minor; axis tight;
subplot(2,2,2);legend('(P²-Q²)²/(2PQ^{3/2})[1]','(P²-Q²)²/(2PQ^{3/2})[2]','(P²-Q²)²/(2PQ^{3/2})[3]');xlabel('Probability'); ylabel('Amplitude');grid minor; axis tight
subplot(2,2,3:4);legend('(P²-Q²)²/(P²-Q²)²/(2PQ^{3/2})[1]','(P²-Q²)²/(P²-Q²)²/(2PQ^{3/2})[2]','(P²-Q²)²/(P²-Q²)²/(2PQ^{3/2})[3]');xlabel('Probability'); ylabel('Amplitude'); grid minor; axis tight

%
% subplot(2,1,2);legend('(P-Q)²/(P+Q)_{STD=0.01}','(P-Q)/(P+Q)_{STD=0.05}','(P-Q)/(P+Q)_{STD=0.1}');xlabel('Probability'); ylabel('Amplitude');
% subplot(2,1,2); grid minor; axis tight
% % subplot(3,1,2);xlabel('Probability'); ylabel('Amplitude'); legend('(\surdNoise_{STD=0.01})-(\surdsignal)','(\surdNoise_{STD=0.05})-(\surdsignal)','(\surdNoise_{STD=0.1})-(\surdsignal)')

%
%
% for j = 1:3
% for i=1:700
% P = (Q'+sd(j)*randn(length(v),1))';
% nx{j}(i,:) =((P-Q).^2)/(P+Q);
% end
%
% subplot(3,1,3);plot(v,mean(nx{j}),[':' cl(j)]); hold on
% end
%
%
% % subplot(3,1,3); plot(v,sqrt(v)./(v),'k'); hold on
% subplot(3,1,3); axis([0.001 0.5 min(min([nx{1} nx{2} nx{3}])) 10])
%
% subplot(3,1,3);xlabel('Probability'); ylabel('Amplitude');legend('\surdNoise_{STD=0.01}/Noise_{STD=0.01}','\surdNoise_{STD=0.05}/Noise_{STD=0.05}','\surdNoise_{STD=0.1}/Noise_{STD=0.1}','\surdsignal/(signal)')