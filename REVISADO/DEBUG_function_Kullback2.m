
clear
load f
errortype = 'normal';

[setup] = IN('Gaussian','sg',errortype,'dist','linear','fit',1,1e4,1000,100);   % Definir os Parâmetros Iniciais
[DATA] = datasetGenSingle(setup);


sd = [1 round(length(setup.RANGE.NOISE)/2) length(setup.RANGE.NOISE)];
cl = ['rgbk']


for j = 1:length(sd)
    for i=1:700
        [~,X.GRID,Y.EST,P,Q] = Method_ADDNoise(setup,DATA,setup.RANGE.NOISE(sd(j)));
        d=diff((X.GRID')); d=d(1);
        F1(i,:,:)=P;
        
        V1=real(log(real(P./Q)));
        V1(isnan(V1)|isinf(V1))=0;
        F2(i,:,:)=V1;
        
        V2=real(F1(i,:,:).*F2(i,:,:));
        V2(isnan(V2)|isinf(V2))=0;
        F3(i,:,:)=V2;
    end
    
    MF1 = reshape(mean(F1),size(F1,2),size(F1,3))';
    MF2 = reshape(mean(F2),size(F2,2),size(F2,3))';
    MF3 = reshape(mean(F3),size(F3,2),size(F3,3))';
    
shadedErrorBar(mean(X.GRID'),mean(MF1),std(MF1));
    subplot(3,2,1);plot(mean(X.GRID'),(mean(MF1)),['.:' cl(j)]); hold on;
    subplot(3,2,2);plot(mean(X.GRID'),(mean(MF2)),['.:' cl(j)]); hold on;
    subplot(3,2,3:4);plot(mean(X.GRID'),(mean(MF3)),['.:' cl(j)]); hold on;
    subplot(3,2,5:6);plot(mean(X.GRID'),(sum(MF3*d)),['*:' cl(j)]); hold on;
    
end

% set(gca,'Yscale','log');
subplot(3,2,1);legend('P[1]','P[2]','P[3]');xlabel('data'); ylabel('Amplitude'); grid minor; axis tight;
subplot(3,2,2);legend('log(P/Q)[1]','log(P/Q)[2]','log(P/Q)[3]');xlabel('data'); ylabel('Amplitude');grid minor; axis tight
subplot(3,2,3:4);legend('Plog(P/Q)[1]','Plog(P/Q)[2]','Plog(P/Q)[3]'); ylabel('Amplitude'); grid minor; axis tight
subplot(3,2,5:6);legend('Area[1]','Area[2]','Area[3]');xlabel('data'); ylabel('Área'); grid minor; axis tight

