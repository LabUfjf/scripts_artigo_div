
clear
load f


[setup] = IN('Gaussian','sg','poisson','dist','linear','bypass',1,1e4,1000,1);   % Definir os Parâmetros Iniciais
[DATA] = datasetGenSingle(setup);   
[X.EST,X.GRID,Y.EST,Y.GRID,Y.TRUTH] = Method_ADDNoise(setup,DATA,100);
Q =Y.TRUTH;
sd = [1 round(length(f.poisson)/2) length(f.poisson)];
cl = ['rgbk']

for j = 1:length(sd)
for i=1:700
% P = (Q'+sd(j)*randn(length(Q),1))';
[~,~,Y.EST,P,~] = Method_ADDNoise(setup,DATA,f.poisson(sd(j)));
% P = (Q'+sd(j)*Q'.*randn(length(Q),1))';
MF1(i,:)=((P-Q).^2).*(P+Q);
MF2(i,:)=(P.*Q);
end

subplot(2,2,1);plot(Q,real(mean(MF1)),[':' cl(j)]); hold on; 
subplot(2,2,2);plot(Q,real(mean(MF2)),[':' cl(j)]); hold on; 
subplot(2,2,3:4);plot(Q,real(mean(MF1))./real(mean(MF2)),[':' cl(j)]); hold on; 


end
set(gca,'Yscale','log');
subplot(2,2,1);legend('(P-Q)²(P+Q)[1]','(P-Q)²(P+Q)[2]','(P-Q)²(P+Q)[3]');xlabel('Probability'); ylabel('Amplitude'); grid minor; axis tight
subplot(2,2,2);legend('(PQ)[1]','(PQ)[2]','(PQ)[3]');xlabel('Probability'); ylabel('Amplitude'); grid minor; axis tight
subplot(2,2,3:4);legend('(P-Q)²(P+Q)/(PQ)[1]','(P-Q)²(P+Q)/(PQ)[2]','(P-Q)²(P+Q)/(PQ)[3]');xlabel('Probability'); ylabel('Amplitude'); grid minor; axis tight
