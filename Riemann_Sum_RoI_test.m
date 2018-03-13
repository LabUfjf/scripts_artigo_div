% RIEMANN SUM TEST
clear variables; close all; clc

nest = 1000;
nt_max = 1000;
% vROI = [5];
vROI = [250];
% for name = {'Gaussian','Bimodal','Rayleigh','Logn','Gamma'};
for name  = {'Gaussian'}
    itp = {'linear'};
    for type = {'prob'}
        %     for type = {'dist','prob','deriv'};
        for errortype = {'poisson'};
            %         for errortype = {'normal','poisson'};
            [setup] = IN(100,100000);
            setup.NAME = name{1};
            iest = 0;
            wb=waitbar(0,'Aguarde...');
            
            for ROI = vROI;
                iest = iest+1;
                setup.DIV = ROI;
                [sg,~] = datasetGenSingle(setup,name{1},type);
                
                [rnoise,xlab] = SETrange(errortype);
                for rn= rnoise(end)
                    for nt = 1:nt_max
                        [MD(nt,:,:)] = DFSelectDx(setup,sg,nest,rn,name,itp,errortype);
                    end
                end
                MD2 = MD;
                %                 size(MD)
                %                 pause
                TESTROI.M{iest} =  reshape(mean(MD),size(MD,2),size(MD,3));
                TESTROI.S{iest} =  reshape(std(MD),size(MD,2),size(MD,3));
                TESTROI.x{iest}=  sg.RoI.Xaxis;
                clear MD
                waitbar(iest/length(vROI));
                
                [xest,xgrid,yest,~,~] = Method_ADDNoise(setup,sg,nest,rn,name,itp,'fit',errortype);
                [KT,SK,PB] = FIND_KURT_SKEW(sg,xgrid,xest,yest,rn,errortype,name);
            end
            close(wb)
        end
    end
end

n = 1;
figure
for d = 1:15;
    mk=['os^v><p'];
    
%     figure
    for i = 1:length(TESTROI.x)
        %     plot(TESTROI.x{i},TESTROI.M{i}(d,:)/max(TESTROI.M{i}(d,:))); hold on
        Xerror = diff(TESTROI.x{i}); Xerror = [Xerror/2 Xerror(end)/2];
        subplot(5,3,d);errorbarxy(TESTROI.x{i},TESTROI.M{i}(d,:),Xerror,TESTROI.S{i}(d,:)/sqrt(nt_max),{['k' mk(i) ':'], 'k', 'k'}); hold on
    end
    axis tight
    grid on
    set(gca,'GridLineStyle',':')
end


% figure
% PB_ROI=interp1(sg.RoI.Xaxis,PB,sg.RoI.Xaxis,'linear');
% PB_TRUTH=interp1(sg.pdf.truth.x,sg.pdf.truth.y,sg.RoI.Xaxis,'linear');
% 
% plot(sg.RoI.Xaxis,PB,'r'); hold on
% plot(sg.pdf.truth.x,sg.pdf.truth.y,'k')
% plot(sg.RoI.Xaxis,(PB_ROI-PB_TRUTH),':k')
% axis tight