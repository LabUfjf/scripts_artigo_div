% TEST LINEARIDADE
clear variables;  clc; close all;
%=========================================================================
% DESCRIÇÃO:
% Esse teste tem como intuito a linearidade entre o valor das divergências
% com "1" RoI e "N" RoIs
%=========================================================================
% PARÂMETROS INICIAIS - ADDSYM
%=========================================================================
norm = 'fit';
nRoI = 50;
nGrid= 1e5;
nEst = 1000;
inter = 'linear';
mod = 'abs';
for errortype = {'normal','poisson','noisemix'};
    
    
    %=========================================================================
    wb = waitbar(0,'Aguarde...');
    for nt = 1:2500
        for NRANGE = 100
            [setup] = IN('Gaussian','sg',errortype,'dist',inter,norm,1,nGrid,nEst,nRoI);   % Definir os Parâmetros Iniciais
            [DATA] = datasetGenSingle(setup);
            [X.EST,X.GRID,Y.EST,Y.GRID,Y.TRUTH] = Method_ADDNoise(setup,DATA,setup.RANGE.NOISE(NRANGE));
            [P,Q,dx] = fixPQ(X.GRID,Y.GRID,Y.TRUTH);
            MN(nt,:,:) = (MATRIXMD(P,Q,dx,mod)')';
        end
        waitbar(nt/2500)
    end
    close(wb)
    
    
    Mmax = reshape(max(MN),15,nRoI);
    M = reshape(mean(MN),15,nRoI);
    M(2,:) = Mmax(2,:);
    MV=reshape(M,15,nRoI);
    SV=reshape(std(MN),15,nRoI);
%     pause
    
    % for i = 1:15
    %     for j=1:100
    %         MESHMN{i}(j,:)=MN{j}(i,:);
    %     end
    % end
    %
    
    %
    for NDIV = 1:15
        figure(1)
        subplot_tight(3, 5, NDIV, [0.06]);errorbar(1:nRoI,MV(NDIV,:),SV(NDIV,:),'ok','markersize',2); hold on;plot(setup.ROIBG,0,'or');stairs(1:nRoI,MV(NDIV,:),':k')
        xlabel('RoI')
        ylabel(setup.TYPE.MD{NDIV})
        grid on
        set(gca,'gridlinestyle',':')
        axis tight
        
        
        figure(2)
        subplot_tight(3, 5, NDIV, [0.06]);stairs(1:nRoI,SV(NDIV,:)./MV(NDIV,:),'o:k','markersize',2); hold on;plot(setup.ROIBG,0,'or');
        xlabel('RoI')
        ylabel(setup.TYPE.MD{NDIV})
        grid on
        set(gca,'gridlinestyle',':')
        axis tight
    end
    
    figure(1)
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    saveas(gcf,[pwd '\MD_STD\MD-ERROR[' errortype{1} ']VAR[' num2str(NRANGE) ']'],'fig')
    
    figure(2)
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    saveas(gcf,[pwd '\MD_STD\STD-ERROR[' errortype{1} ']VAR[' num2str(NRANGE) ']'],'fig')
    close all
%     pause
    % %
    % for NDIV = 1:15
    %     subplot_tight(3, 5, NDIV, [0.05]);mesh(1:nRoI,setup.RANGE.NOISE,MESHMN{NDIV});
    %     xlabel('RoI')
    %     ylabel('Std')
    %     zlabel(setup.TYPE.MD{NDIV})
    %     grid on
    %     set(gca,'gridlinestyle',':')
    %     axis tight
    % end
end

% plot(X.GRID,Y.GRID,'.r',X.GRID,Y.TRUTH,'-k'); axis tight



