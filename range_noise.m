%% TESTE Bias X Variance
% VERIFICAR SE O setup.DIV = 1;

clear variables; close all; clc

doPlot.Shape = 1;
Noise = 'normal';
Nomalization = 'no';

if strcmp(Noise,'normal')
    bin=linspace(1,0,1000);
else
    bin=linspace(5500,1000000,1000);
end

nbin = 5500;
nt_max = 50;

for name = {'Gauss','Bimodal','Rayleigh','Logn','Gamma'};
    % for name = {'Gauss'};
    wb = waitbar(0,'Aguarde');
    for nt = 1:nt_max;
        
        [setup] = IN(10000,100000); %setup.DIV = 1;
        [sg,~] = datasetGenSingle(setup,name{1});
        
        i = 0;
        for B=bin
            i=i+1;
            
            xh2 = linspace(min(sg.evt),max(max(sg.evt)),nbin);
            %           xh2 = linspace(min(sg.pdf.truth.x),max(sg.pdf.truth.x),nbin);
            [ytruth] = GridNew(sg,xh2,name);
            
            if strcmp(Noise,'normal')
                AMP = B*max(sg.pdf.truth.y); N = [];
            else
                N = B; AMP = [];
            end
            
            [signal] = noiseADD(ytruth,ytruth,AMP,N,Noise);
            
            if strcmp(Noise,'poisson')
                signal = signal/area2d(xh2,signal);
                ytruth = ytruth/area2d(xh2,ytruth);
            end
            
            plot(signal); hold on
            plot(ytruth)
            pause
            [V] = DFSelect(signal,ytruth,Nomalization);
            
            for div = 1:15
                A{div}(i,nt) = V(div);
            end
        end
        
        waitbar(nt/nt_max)
    end
    
    for b =1:15
        DIV.MEAN(b+1,:) = (mean(real(A{b}')));
        DIV.STD(b+1,:) = (std(real(A{b}'))/nt_max);
    end
    
    close(wb)
    
    DIV.MEAN(1,:) = bin;
    DIV.STD(1,:) = bin;
    save(['FULL_DIST[' name{1} ']BIN[' num2str(nbin) ']NOISE[' Noise ']NORM[' Nomalization ']'],'DIV')
    % save(['ERROR_MAX[' name{1} ']BIN[' num2str(nbin) ']NOISE[' Noise ']NORM[' Nomalization ']'],'INFO')
    
end

% plot(bin,(DIV.MEAN(4,:)),'.:')