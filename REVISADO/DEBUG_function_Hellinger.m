clear variables; close all; clc;
load f
load rangeRoI

%=========================================================================
% PARÂMETROS INICIAIS - HELLINGER
%=========================================================================
errortype = 'poisson';
norm = 'fit';
nt = 100;
nRoI = 100;
nGrid= 1e4;
nEst = 1000;
%=========================================================================

[setup] = IN('Gaussian','sg',errortype,'dist','linear',norm,1,nGrid,nEst,nRoI);   % Definir os Parâmetros Iniciais
setup.MINMAX.STD = 3;
[DATA] = datasetGenSingle(setup);
[~,~,~,~,Q] = Method_ADDNoise(setup,DATA,setup.RANGE.NOISE(1));
sd = [1 round(length(setup.RANGE.NOISE)/2) length(setup.RANGE.NOISE)];
cl = 'rgbk';

%=========================================================================
%% DEBUG ROI
%=========================================================================
F1(nt,size(Q,1),size(Q,2))=0;
F2(nt,size(Q,1),size(Q,2))=0;
F3(nt,size(Q,1),size(Q,2))=0;

for j = 1:length(sd)
    wb = waitbar(0,['Agaurde SD[' num2str(j) ']']);
    for i=1:nt
        [X.EST,X.GRID,Y.EST,P,Q] = Method_ADDNoise(setup,DATA,setup.RANGE.NOISE(sd(j)));
        d=diff((X.GRID')); d=d(1);
        %=========================================================================
        V0 = sqrt(P); % FUNÇÃO A           
        V0(isnan(V0)|isinf(V0))=0;
        F1(i,:,:)=real(V0);
        %=========================================================================
        V1=sqrt(Q);   % FUNÇÃO B
        V1(isnan(V1)|isinf(V1))=0;
        F2(i,:,:)=real(V1);
        %=========================================================================
        V2=sqrt((1/2)*real(F1(i,:,:)-F2(i,:,:)).^2);  % JUNÇÃO DAS FUNÇÕES A E B
        V2(isnan(V2)|isinf(V2))=0;
        F3(i,:,:)=V2;
        %=========================================================================
        waitbar(i/nt);
    end
    close(wb);
    MF1 = reshape(mean(F1),size(F1,2),size(F1,3))';
    MF2 = reshape(mean(F2),size(F2,2),size(F2,3))';
    MF3 = reshape(mean(F3),size(F3,2),size(F3,3))';
    
    subplot(3,2,1);plot(rangeRoI.mean,mean(MF1),['.:' cl(j)]); hold on;
    subplot(3,2,2);plot(rangeRoI.mean,mean(MF2),['.:' cl(j)]); hold on;
    subplot(3,2,3:4);plot(rangeRoI.mean,mean(MF3),['.:' cl(j)]); hold on;
    subplot(3,2,5:6);errorbar(rangeRoI.mean,2*sum(MF3*d),std(MF3*d),['*:' cl(j)]); hold on;
end

subplot(3,2,1);legend('\surdP[1]','\surdP[2]','\surdP[3]');xlabel('data'); ylabel('Amplitude'); grid minor; axis tight;
subplot(3,2,2);legend('\surdQ[1]','\surdQ[2]','\surdQ[3]');xlabel('data'); ylabel('Amplitude');grid minor; axis tight
subplot(3,2,3:4);legend('\surd((1/2)(\surdP-\surdQ)²)[1]','\surd((1/2)(\surdP-\surdQ)²)[2]','\surd((1/2)(\surdP-\surdQ)²)[3]'); ylabel('Amplitude'); grid minor; axis tight
subplot(3,2,5:6);legend('Area[1]','Area[2]','Area[3]');xlabel('data'); ylabel('Área'); grid minor; axis tight
set(gcf,'units','points','position',[10,10,550,400])
clear P Q F1 F2 F3 V1 V2 V3
%=========================================================================
%% DEBUG ARTIFICIAL
%=========================================================================

Q = linspace(0,0.5,1000);

figure
for j =  1:length(sd)
    wb = waitbar(0,['Agaurde SD[' num2str(j) ']']);
    for i=1:nt
        if strcmp(errortype,'normal')
            P =  Q + setup.RANGE.NOISE(sd(j))*randn(1,length(Q));
        else
            P =  Q + (Q/max(Q)).*f.norm(sd(j)).*randn(1,length(Q));
            P(P<0) = 0;
        end
        %=========================================================================
        V0 = sqrt(P);
        V0(isnan(V0)|isinf(V0))=0;
        F1(i,:)=real(V0);
        %=========================================================================
        V1=sqrt(Q);
        V1(isnan(V1)|isinf(V1))=0;
        F2(i,:)=real(V1);
        %=========================================================================
        V2=sqrt((1/2)*real(F1(i,:)-F2(i,:)).^2);
        V2(isnan(V2)|isinf(V2))=0;
        F3(i,:)=V2;
        %=========================================================================
        waitbar(i/nt);
    end
    close(wb)
    
    subplot(2,1,1);plot(Q,mean(F1),['-' cl(j)]); hold on; %set(gca,'Yscale','log');
    subplot(2,1,1);plot(Q,mean(F2),['--' cl(j)]); axis tight;
    subplot(2,1,2); plot(Q,mean(F3),['.:' cl(j)]); hold on;   axis tight; grid on;% set(gca,'gridlinestyle',':','Yscale','log');
end

subplot(2,1,1);plot(Q,max(F1),':','color',[0.5 0.5 0.5]);hold on;
subplot(2,1,1);plot(Q,min(F1),':','color',[0.5 0.5 0.5]);hold on;
subplot(2,1,1);plot(Q,max(F2),':','color',[0.5 0.5 0.5]);hold on;
subplot(2,1,1);plot(Q,min(F2),':','color',[0.5 0.5 0.5]);hold on;axis tight;

subplot(2,1,1); legend({'\surdP[1]','\surdQ[1]','\surdP[2]','\surdQ[2]','\surdP[3]','\surdQ[3]','Max/Min'},'Location','best');xlabel('Probability'); ylabel('Amplitude')
subplot(2,1,2); legend({'\surd((1/2)(\surdP-\surdQ)²)[1]','\surd((1/2)(\surdP-\surdQ)²)[2]','\surd((1/2)(\surdP-\surdQ)²)[3]'},'Location','best'); xlabel('Probability'); ylabel('Amplitude')

set(gcf,'units','points','position',[10,10,550,400])