clear variables; close all; clc;
load f
load rangeRoI
load modelfit
%=========================================================================
% PARÂMETROS INICIAIS - HARMONIC
%=========================================================================
DIV = 'HARMONIC';
name = 'Gaussian';
nt = 100;
nRoI = 50;
nGrid= 1e5;
nEst = 1000;
for errortype = {'normal','poisson','noisemix'};
    disp(['CHECKPOINT[errortype]'])
    for norm = {'full','fit'};
        disp(['CHECKPOINT[norm]'])
        for mod = {'real','abs'};
            disp(['CHECKPOINT[mod]'])
            for inter = {'linear','nearest'};
                disp(['CHECKPOINT[inter]'])
                %=========================================================================
                
                [setup] = IN(name,'sg',errortype{1},'dist',inter{1},norm{1},1,nGrid,nEst,nRoI);   % Definir os Parâmetros Iniciais
                [DATA] = datasetGenSingle(setup);
                [~,~,~,~,Q] = Method_ADDNoise(setup,DATA,setup.RANGE.NOISE(1));
                sd = [1 round(length(setup.RANGE.NOISE)/2) length(setup.RANGE.NOISE)];
                cl = 'rgbk';
%                 
%                 %=========================================================================
%                 %% DEBUG ROI
%                 %=========================================================================
%                 F1(nt,size(Q,1),size(Q,2))=0;
%                 F2(nt,size(Q,1),size(Q,2))=0;
%                 F3(nt,size(Q,1),size(Q,2))=0;
%                 
%                 
%                 for j =  length(sd):-1:1
%                     disp(['CHECKPOINT[sd]'])
%                     wb = waitbar(0,['Agaurde SD[' num2str(j) ']']);
%                     for i=1:nt
%                         [X.EST,X.GRID,Y.EST,P,Q] = Method_ADDNoise(setup,DATA,setup.RANGE.NOISE(sd(j)));
%                         d=diff((X.GRID')); d=d(1);
%                         %=========================================================================
%                         V0 = (P.*Q); % FUNÇÃO A
%                         V0(isnan(V0)|isinf(V0))=0;
%                         F1(i,:,:)=ar(V0,mod{1});
%                         %=========================================================================
%                         V1=(P+Q);   % FUNÇÃO B
%                         V1(isnan(V1)|isinf(V1))=0;
%                         F2(i,:,:)=ar(V1,mod{1});
%                         %=========================================================================
%                         V2=ar(F1(i,:,:)./F2(i,:,:),mod{1});  % JUNÇÃO DAS FUNÇÕES A E B
%                         V2(isnan(V2)|isinf(V2))=0;
%                         F3(i,:,:)=V2*d;
%                         %=========================================================================
%                         waitbar(i/nt);
%                     end
%                     close(wb);
%                     MF1 = reshape(mean(F1),size(F1,2),size(F1,3))';
%                     MF2 = reshape(mean(F2),size(F2,2),size(F2,3))';
%                     MF3 = reshape(mean(F3),size(F3,2),size(F3,3))';
%                     
%                     plotLOG(rangeRoI.mean,MF1,cl(j),1,1)
%                     plotLOG(rangeRoI.mean,MF2,cl(j),3,1)
%                     plotLOG(rangeRoI.mean,MF3,cl(j),5,1)
%                 end
%                 
%                 subplot(3,2,1);legend({'E1[3]','E1[2]','E1[1]'});xlabel('Data'); ylabel('Amplitude'); grid minor; axis tight;
%                 subplot(3,2,3);legend({'E2[3]','E2[2]','E2[1]'});xlabel('Data'); ylabel('Amplitude'); grid minor; axis tight;
%                 subplot(3,2,5);legend({'E3[3]','E3[2]','E3[1]'});xlabel('Data'); ylabel('Amplitude'); grid minor; axis tight;
%                 
%                 subplot(3,2,2);legend({'E1[3]','E1[2]','E1[1]'});xlabel('Data'); ylabel('log(Amplitude)'); grid minor; axis tight;
%                 subplot(3,2,4);legend({'E2[3]','E2[2]','E2[1]'});xlabel('Data'); ylabel('log(Amplitude)'); grid minor; axis tight;
%                 subplot(3,2,6);legend({'E3[3]','E3[2]','E3[1]'});xlabel('Data'); ylabel('log(Amplitude)'); grid minor; axis tight;
%                 set(gcf, 'Position', get(0, 'Screensize'));
%                 saveas(gcf,[pwd '\DEBUG\' DIV '\DATA-DIV[' DIV '][' name ']NOISE[' num2str(errortype{1}) ']NORM[' num2str(norm{1}) ']INT[' num2str(inter{1}) ']MOD[' num2str(mod{1}) ']'],'png')
%                 saveas(gcf,[pwd '\DEBUG\' DIV '\DATA-DIV[' DIV '][' name ']NOISE[' num2str(errortype{1}) ']NORM[' num2str(norm{1}) ']INT[' num2str(inter{1}) ']MOD[' num2str(mod{1}) ']'],'fig')
%                 close(1)
%                 
%                 clear P Q F1 F2 F3 V1 V2 V3 MF1 MF2 MF3
                %=========================================================================
                %% DEBUG ARTIFICIAL
                %=========================================================================
                
                [Qx,Q] = probDEBUG(DATA);
                
                for j =  length(sd):-1:1
                    disp(['CHECKPOINT[prob]'])
                    wb = waitbar(0,['Agaurde SD[' num2str(j) ']']);
                    for i=1:nt
                        if strcmp(errortype{1},'normal')
                            P =  Q + setup.RANGE.NOISE(sd(j))*max(Q)*randn(1,length(Q));
                        else
                            ind=find(f.poisson==setup.RANGE.NOISE(sd(j)));
                            P =  Q + modelfit{ind}(Qx)'.*randn(1,length(Q));
                        end
                        %=========================================================================
                        V0 = (P.*Q);
                        V0(isnan(V0)|isinf(V0))=0;
                        F1(i,:)=ar(V0,mod{1});
                        %=========================================================================
                        V1=(P+Q);
                        V1(isnan(V1)|isinf(V1))=0;
                        F2(i,:)=ar(V1,mod{1});
                        %=========================================================================
                        V2=ar(F1(i,:)./F2(i,:),mod{1});
                        V2(isnan(V2)|isinf(V2))=0;
                        F3(i,:)=V2;
                        %=========================================================================
                        waitbar(i/nt);
                             iNAN = 0;
                        if sum(isnan(V0))+sum(isnan(V1))+sum(isnan(V2))>0
                            save([DIV '_NAN'],'iNAN')
                        end
                    end
                    close(wb)
                    plotLOG(Q,F1,cl(j),1,2)
                    plotLOG(Q,F2,cl(j),3,2)
                    plotLOG(Q,F3,cl(j),5,2)
                end
                
                subplot(3,2,1);legend({'E1[3]','E1[2]','E1[1]'});xlabel('Probability'); ylabel('Amplitude'); grid minor; axis tight;
                subplot(3,2,3);legend({'E2[3]','E2[2]','E2[1]'});xlabel('Probability'); ylabel('Amplitude'); grid minor; axis tight;
                subplot(3,2,5);legend({'E3[3]','E3[2]','E3[1]'});xlabel('Probability'); ylabel('Amplitude'); grid minor; axis tight;
                
                subplot(3,2,2);legend({'E1[3]','E1[2]','E1[1]'});xlabel('Probability'); ylabel('log(Amplitude)'); grid minor; axis tight;
                subplot(3,2,4);legend({'E2[3]','E2[2]','E2[1]'});xlabel('Probability'); ylabel('log(Amplitude)'); grid minor; axis tight;
                subplot(3,2,6);legend({'E3[3]','E3[2]','E3[1]'});xlabel('Probability'); ylabel('log(Amplitude)'); grid minor; axis tight;
                set(gcf, 'Position', get(0, 'Screensize'));
                saveas(gcf,[pwd '\DEBUG\' DIV '\PROB-DIV[' DIV '][' name ']NOISE[' num2str(errortype{1}) ']NORM[' num2str(norm{1}) ']INT[' num2str(inter{1}) ']MOD[' num2str(mod{1}) ']'],'png')
                saveas(gcf,[pwd '\DEBUG\' DIV '\PROB-DIV[' DIV '][' name ']NOISE[' num2str(errortype{1}) ']NORM[' num2str(norm{1}) ']INT[' num2str(inter{1}) ']MOD[' num2str(mod{1}) ']'],'fig')
                close(2)
                clear P Q F1 F2 F3 V1 V2 V3
            end
        end
    end
end