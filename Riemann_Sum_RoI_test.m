% RIEMANN SUM TEST
clear variables; close all; clc

nest = 1000;
nt_max = 50;

% for name = {'Gaussian','Bimodal','Rayleigh','Logn','Gamma'};
for name  = {'Gaussian'}
    itp = {'linear'};
    for type = {'dist'}
        %     for type = {'dist','prob','deriv'};
        for errortype = {'normal'};
            %         for errortype = {'normal','poisson'};
            
            
            [setup] = IN(100,100000);
            setup.NAME = name{1};
            iest = 0;
            for ROI = [10 25 50 100]
                iest = iest+1;
                setup.DIV = ROI;
                [sg,~] = datasetGenSingle(setup,name{1},type);
                
                [rnoise,xlab] = SETrange(errortype);
                for rn= rnoise(1)
                    for nt = 1:nt_max
                        MD(nt,:,:) = DFSelectDx(setup,sg,nest,rn,name,itp,errortype);
                    end
                end
                MD2 = MD;
                %                 size(MD)
                %                 pause
                TESTROI.M{iest} =  reshape(mean(MD),size(MD,2),size(MD,3));
                TESTROI.x{iest}=sg.RoI.Xaxis;
                clear MD
            end
        end
    end
end