% TEST LINEARIDADE
clear variables;  clc; close all;
%=========================================================================
% DESCRIÇÃO:
% Esse teste tem como intuito a linearidade entre o valor das divergências
% com "1" RoI e "N" RoIs
%=========================================================================
% PARÂMETROS INICIAIS - ADDSYM
%=========================================================================
norm = 'full';
nt = 10;
nRoI = 50;
nGrid= 1e5;
nEst = 1000;
inter = 'linear';
errortype = 'normal';
mod = 'abs';
%=========================================================================
wb = waitbar(0,'Aguarde...');
for j=1:100
    for i = 1:nt
        [setup] = IN('Gaussian','sg',errortype,'dist',inter,norm,1,nGrid,nEst,1);   % Definir os Parâmetros Iniciais
        [DATA] = datasetGenSingle(setup);
        [X.EST,X.GRID,Y.EST,Y.GRID,Y.TRUTH] = Method_ADDNoise(setup,DATA,setup.RANGE.NOISE(j));
        [P,Q,dx] = fixPQ(X.GRID,Y.GRID,Y.TRUTH);
        M1(i,j,:) = MATRIXMD(P,Q,dx,mod);
        
        [setup] = IN('Gaussian','sg',errortype,'dist',inter,norm,1,nGrid,nEst,nRoI);   % Definir os Parâmetros Iniciais
        [DATA] = datasetGenSingle(setup);
        [X.EST,X.GRID,Y.EST,Y.GRID,Y.TRUTH] = Method_ADDNoise(setup,DATA,setup.RANGE.NOISE(j));
        [P,Q,dx] = fixPQ(X.GRID,Y.GRID,Y.TRUTH);
        MN(i,j,:) = sum(MATRIXMD(P,Q,dx,mod)')';
        MN2 = max(MATRIXMD(P,Q,dx,mod)')';
        MN(i,j,2) = MN2(2);
    end
    waitbar(j/100)
end
close(wb)

M1R=reshape(mean(M1),100,15)';
MNR=reshape(mean(MN),100,15)';

for k = 1:15
    figure(1)
    subplot(3,5,k);plot(M1R(k,:),MNR(k,:),'.k');
    title(setup.TYPE.MD{k})
    xlabel('RoI_{[N=1]}')
    ylabel(['RoI_{[N=' num2str(nRoI) ']}'])
    grid on
    set(gca,'gridlinestyle',':')
    axis tight
    
    figure(2)
    subplot(3,5,k);plot(setup.RANGE.NOISE,MNR(k,:),'.k'); hold on
    subplot(3,5,k);plot(setup.RANGE.NOISE,M1R(k,:),'ob');
    subplot(3,5,k);plot(setup.RANGE.NOISE,M1R(k,:)-MNR(k,:),'+r');
    if k == 15
        legend(['RoI_{[N=' num2str(nRoI) ']}'],'RoI_{[N=1]}',['RoI_{[N=1]}-RoI_{[N=' num2str(nRoI) ']}'],'Location','NorthWest')
    end
    xlabel('Variance')
    ylabel('Value')
    title(setup.TYPE.MD{k})
    grid on
    set(gca,'gridlinestyle',':')
    axis tight
end