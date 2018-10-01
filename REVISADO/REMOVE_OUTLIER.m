%% KNN teste
clear variables;  clc; close all;
%=========================================================================
% TESTANDO MÉTODOS PARA ELIMINAR OUTLIERS
%=========================================================================
norm = 'fit';
inter = 'linear';
errortype = 'none';
mod = 'abs';
in=0;
wb=waitbar(0,'Aguarde');
% for name = {'Uniform','Gaussian','Bimodal','Trimodal','Rayleigh','Logn','Gamma'};
    
for name = {'Bimodal'};
    in=in+1;
    %=========================================================================
    vEVT = linspace(100,100000,25);
%     vEVT = 100000
    nEST = 100;
    nGRID= 10^5;
    nROI = 1;
    for n=1:5
        
        for i = 1:length(vEVT);
            nEVT = round(vEVT(i));
            [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
            [DATA] = datasetGenSingle(setup);
            [OUT] = DimGEN(setup,3);
            L1=length(OUT);
            [OUT]= ADD_OUTLIER(OUT,100);
            L2=length(OUT);
            TRUTH = [zeros(L1,1); ones(L2-L1,1)];
            sd = 4;
            [SET,D] = OUTLIER_HUNTER(OUT, 'Zscore',sd);
            [SET2] = OUTLIER_HUNTER(OUT, 'Std',sd);
            [SET3] = OUTLIER_HUNTER(OUT, 'CDF',sd);
            ISG = (1:L1);
            IBG = (L1+1:L2);
            
            % [yh,xh]=hist(D,200);
            % yh=yh/area2d(xh,yh);
            %
            % [gauss_data] =gaussian_transform(D);
            % [yg,xg]=hist(gauss_data,2000);
            % yg=yg/area2d(xg,yg);
            % hist(gauss_data,300)
%              [f,x]=ecdf(D(ISG));
%             stairs(x,f,'-'); hold on
            % stairs(xh,yh,'-'); hold on
            % stairs(xg,yg,'-r'); hold on
           
%             KT(n,in,i)=kurtosis(D(ISG));
%             SK(n,in,i)=skewness(D(ISG));
            % SG = SET(ISG);
            % BG = SET(IBG);
            
            DEGRAD_ZS(i,n) =  (nEVT\sum((SET(ISG) ~= TRUTH(ISG))))*100;
            DEGRAD_STD(i,n) =  (nEVT\sum((SET2(ISG) ~= TRUTH(ISG))))*100;
            DEGRAD_CDF(i,n) =  (nEVT\sum((SET3(ISG) ~= TRUTH(ISG))))*100;
            
            DETEC_ZS(i,n)= (sum((SET(IBG) == TRUTH(IBG)))/(L2-L1))*100;
            DETEC_STD(i,n)= (sum((SET2(IBG) == TRUTH(IBG)))/(L2-L1))*100;
            DETEC_CDF(i,n)= (sum((SET3(IBG) == TRUTH(IBG)))/(L2-L1))*100;
            
        end
        
    end
    waitbar(in/7)
end
close(wb)
% subplot(1,2,1);plot(vEVT,reshape(mean(KT),7,25),':s','Markersize',4)
% subplot(1,2,2);plot(vEVT,reshape(mean(SK),7,25),':o','Markersize',4)

errorbar(vEVT,mean(DEGRAD_ZS'),std(DEGRAD_ZS'),'v:k','Markersize',3); hold on
errorbar(vEVT,mean(DEGRAD_STD'),std(DEGRAD_STD'),'v:r','Markersize',3)
errorbar(vEVT,mean(DEGRAD_CDF'),std(DEGRAD_CDF'),'v:b','Markersize',3)
errorbar(vEVT,mean(DETEC_ZS'),std(DETEC_ZS'),'^:k','Markersize',3)
errorbar(vEVT,mean(DETEC_STD'),std(DETEC_STD'),'^:r','Markersize',3)
errorbar(vEVT,mean(DETEC_CDF'),std(DETEC_CDF'),'^:b','Markersize',3)
legend('Degradação Z-Score Robusto','Degradação Z-Score','Degradação CDF','Detecção Z-Score Robusto','Detecção Z-Score','Detecção CDF'); axis tight
grid on
set(gca,'GridLineStyle',':');
xlabel('Número de Eventos')
ylabel('(%)')
% % figure
% % bar([DETEC_ZS DETEC_CDF; DEGRAD_ZS DEGRAD_CDF])
% % for i=1
% %
% %
% % sum(SET)
% % sum(SET2)
%
figure
plot3(OUT(1,SET),OUT(2,SET),OUT(3,SET),'ok','Markersize',2); hold on
plot3(OUT(1,SET2),OUT(2,SET2),OUT(3,SET2),'or','Markersize',4); hold on
plot3(OUT(1,SET3),OUT(2,SET3),OUT(3,SET3),'ob','Markersize',6); hold on
plot3(OUT(1,:),OUT(2,:),OUT(3,:),'.','color',[0.65 0.65 0.65],'markersize',1); axis tight

xlabel('Dimensão 1')
ylabel('Dimensão 2')
zlabel('Dimensão 3')
legend('Z-Score Robusto','Z-Score','CDF','Data')

% grid on
% set(gca, 'GridLine',':','FontSize',12,'xscale','log'); axis tight
%  legend('Uniform','Gaussian','Bimodal','Trimodal','Rayleigh','Logn','Gamma')
%  xlabel('D')
%  ylabel('Densidade de Probabilidade')