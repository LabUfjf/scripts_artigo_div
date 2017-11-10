%% TESTE Bias X Variance
% VERIFICAR SE O setup.DIV = 1;

clear variables; close all; clc

doPlot.Shape = 1;
Noise = 'normal';
Nomalization = 'no';


if strcmp(Noise,'normal')
    bin=linspace(1,0,1000);
else
    bin=linspace(100,1000000,1000);
end

nbin = 5500;
nt_max = 100;

for name = {'Gauss','Bimodal','Rayleigh','Logn','Gamma'};
    for test = {'Variance'};
        
        wb = waitbar(0,'Aguarde');
        for nt = 1:nt_max;
            
            [setup] = IN(10000,100000); setup.DIV = 1;
            [sg,~] = datasetGenSingle(setup,name{1});
            
            i = 0;
            for B=bin
                i=i+1;
                xh2 = linspace(min(sg.evt),max(max(sg.evt)),nbin);
                
                [ytruth] = GridNew(sg,xh2,name);
                
                if strcmp(Noise,'normal')
                    AMP = B*max(sg.pdf.truth.y); N = [];
                else
                    N = B;
                end
                
                [signal] = noiseADD(ytruth,ytruth,AMP,N,'normal');
                
                [V] = DFSelect(signal,ytruth,Nomalization);
                
                for div = 1:15
                    A{div}(i,nt) = V(div);
                end
            end
            waitbar(nt/nt_max)
        end
        close(wb)
        pause(1)
        
        for b =1:15
            VCTGAUSS.MEAN(b+1,:) = (mean(real(A{b}')));
            VCTGAUSS.STD(b+1,:) = (std(real(A{b}'))/nt_max);
        end
        
        VCTGAUSS.MEAN(1,:) = bin;
        VCTGAUSS.STD(1,:) = bin;
        VCT = VCTGAUSS;
        DIV = A;
        save(['FULL_DIST[' name{1} ']BIN[' num2str(nbin) ']NOISE[' Noise ']NORM[' Nomalization ']'],'VCT','DIV')
    end
end