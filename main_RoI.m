%% TESTE Bias X Variance

clear variables; close all; clc

Noise = 'poisson';
Nomalization = 'no';
method = 'full';
% load PT_int1000
for name = {'Gauss','Bimodal','Rayleigh','Logn','Gamma'};
    % name = {'Bimodal'};
    wb = waitbar(0,'Aguarde');
    nt_max = 100;
    nbin = 5500;
    load(['VAR_MEAN[' name{1} ']BIN[' num2str(5500) ']NORM[' Nomalization ']'],'VAR_MEAN')
    
    for nt = 1:nt_max;
        
        [setup] = IN(10000,nbin);
        [sg,~] = datasetGenSingle(setup,name{1});
        i = 0;
        
        for RoI=1:setup.DIV
            i=i+1;
            
            xRoI.dy = sg.RoI.x.dy{RoI};
            xRoI.py = sg.RoI.x.py{RoI};
            xRoI.eq.dy = sg.RoI.x.eq.dy{RoI};
            xRoI.eq.py = sg.RoI.x.eq.py{RoI};
            
            [xfull] = xRoIfull(setup,sg);
            [yfull]= yGen(xfull,sg,name);
            [sinal]= yGen(xRoI,sg,name);
            
            [AMP,N,sinal,yfull] = NoiseFix(VAR_MEAN(1),VAR_MEAN(2),sg,sinal,yfull,Noise);
            
            [noise.dy] = noiseADD(sinal.dy,yfull.dy,AMP,N,Noise);
            [noise.py] = noiseADD(sinal.py,yfull.py,AMP,N,Noise);
            [noise.eq.dy] = noiseADD(sinal.eq.dy,yfull.eq.dy,AMP,N,Noise);
            [noise.eq.py] = noiseADD(sinal.eq.py,yfull.eq.py,AMP,N,Noise);
            
            [noise,signal] = MethodFix(xfull,yfull,xRoI,sinal,noise,method);
            
            signal.dy = signal.dy/area2d(xfull.dy,yfull.dy);
            signal.py = signal.py/area2d(xfull.py,yfull.py);
            signal.eq.dy = signal.eq.dy/area2d(xfull.eq.dy,yfull.eq.dy);
            signal.eq.py = signal.eq.py/area2d(xfull.eq.py,yfull.eq.py);
            
            noise.dy = noise.dy/area2d(xfull.dy,yfull.dy);
            noise.py = noise.py/area2d(xfull.py,yfull.py);
            noise.eq.dy = noise.eq.dy/area2d(xfull.eq.dy,yfull.eq.dy);
            noise.eq.py = noise.eq.py/area2d(xfull.eq.py,yfull.eq.py);
            %         plot(signal.dy);
            %         hold on
            %         plot(noise.dy);
            %         pause
            for div = 1:15
                
                [V.dy] = DFSelect(noise.dy,signal.dy,Nomalization);
                [V.py] = DFSelect(noise.py,signal.py,Nomalization);
                [V.eq.dy] = DFSelect(noise.eq.dy,signal.eq.dy,Nomalization);
                [V.eq.py] = DFSelect(noise.eq.py,signal.eq.py,Nomalization);
                
                A.dy{div}(RoI,nt) = V.dy(div);
                A.py{div}(RoI,nt) = V.py(div);
                A.eq.dy{div}(RoI,nt) = V.eq.dy(div);
                A.eq.py{div}(RoI,nt) = V.eq.py(div);
                
            end
            
            NRoI.dy(RoI)=  length(xRoI.dy);
            NRoI.py(RoI)=  length(xRoI.py);
            NRoI.eq.dy(RoI)=  length(xRoI.eq.dy);
            NRoI.eq.py(RoI)=  length(xRoI.eq.py);
        end
        
        waitbar(nt/nt_max)
    end
  
    
    VL={'Bias','Variance','MISE','Linf','Lp','Sorensen','Gower','IP','Harmonic','Cosine','Hellinger','Squared','AddSym','Kullback','Kumar'};
    CL=['kkkggrrbbbkggrb'];
    ML=[':::::::::::::::'];
    
    bin = linspace(0,1,setup.DIV+1);
    d=diff(bin); d=d(1)/2;
    
    for b =1:15
        
        figure(1)
        M.dy = (mean(real(A.eq.dy{b}')));
        S.dy = (std(real(A.eq.dy{b}'))/sqrt(nt_max));
        subplot(3,5,b); errorbar(bin(1:end-1)+d,M.dy,S.dy,['s' ML(b)  CL(b)],'MarkerSize',3); axis tight; grid on; set(gca,'GridLineStyle',':'); hold on;
        subplot(3,5,b); plot([bin; bin],[ones(length(bin),1)*min(M.dy-S.dy) ones(length(bin),1)*max(M.dy+S.dy)]',':k'); axis tight;
        title([VL{b} '(D)'])
        xlabel('Max(%)')
        ylabel('Divergencia')
        
        
        figure(2)
        M.py = (mean(real(A.py{b}')));
        S.py = (std(real(A.py{b}'))/sqrt(nt_max));
        subplot(3,5,b); errorbar(bin(1:end-1)+d,M.py,S.py,['s' ML(b)  CL(b)],'MarkerSize',3); axis tight; grid on; set(gca,'GridLineStyle',':'); hold on;
        subplot(3,5,b); plot([bin; bin],[ones(length(bin),1)*min(M.py-S.py) ones(length(bin),1)*max(M.py+S.py)]',':k'); axis tight;
        title([VL{b} '(P)'])
        xlabel('Max(%)')
        ylabel('Divergencia')
        
        figure(3)
        M.eq.dy = (mean(real(A.eq.dy{b}')));
        S.eq.dy = (std(real(A.eq.dy{b}'))/sqrt(nt_max));
        subplot(3,5,b); errorbar(bin(1:end-1)+d,M.eq.dy,S.eq.dy,['s' ML(b)  CL(b)],'MarkerSize',3); axis tight; grid on; set(gca,'GridLineStyle',':'); hold on;
        subplot(3,5,b); plot([bin; bin],[ones(length(bin),1)*min(M.eq.dy-S.eq.dy) ones(length(bin),1)*max(M.eq.dy+S.eq.dy)]',':k'); axis tight;
        title([VL{b} '(ED)'])
        xlabel('Max(%)')
        ylabel('Divergencia')
        
        figure(4)
        M.eq.py = (mean(real(A.eq.py{b}')));
        S.eq.py = (std(real(A.eq.py{b}'))/sqrt(nt_max));
        subplot(3,5,b); errorbar(bin(1:end-1)+d,M.eq.py,S.eq.py,['s' ML(b)  CL(b)],'MarkerSize',3); axis tight; grid on; set(gca,'GridLineStyle',':'); hold on;
        subplot(3,5,b); plot([bin; bin],[ones(length(bin),1)*min(M.eq.py-S.eq.py) ones(length(bin),1)*max(M.eq.py+S.eq.py)]',':k'); axis tight;
        title([VL{b} '(EP)'])
        xlabel('Max(%)')
        ylabel('Divergencia')
        
    end
    
    figure(5)
    plot(bin(1:end-1)+d,NRoI.dy,'or');hold on
    plot(bin(1:end-1)+d,NRoI.py,'pr');
    plot(bin(1:end-1)+d,NRoI.eq.dy,'sk');
    plot(bin(1:end-1)+d,NRoI.eq.py,'+k');
    plot([bin; bin],[zeros(1,length(bin)); max([NRoI.dy NRoI.py NRoI.eq.dy NRoI.eq.py])*ones(1,length(bin))],':k'); axis tight
    legend('D','P','ED','EP')
    
    figure(1)
    set(gcf, 'Position', get(0, 'Screensize'));
    saveas(gcf,['BOX_ROI_PDF_' name{1} '_NOISE_' Noise '_DY_' Nomalization '_' method],'fig')
    figure(2)
    set(gcf, 'Position', get(0, 'Screensize'));
    saveas(gcf,['BOX_ROI_PDF_' name{1} '_NOISE_' Noise '_PY_' Nomalization '_' method],'fig')
    figure(3)
    set(gcf, 'Position', get(0, 'Screensize'));
    saveas(gcf,['BOX_ROI_PDF_' name{1} '_NOISE_' Noise '_EQDY_' Nomalization '_' method],'fig')
    figure(4)
    set(gcf, 'Position', get(0, 'Screensize'));
    saveas(gcf,['BOX_ROI_PDF_' name{1} '_NOISE_' Noise '_EQPY_' Nomalization '_' method],'fig')
    figure(5)
    % set(gcf, 'Position', get(0, 'Screensize'));
    saveas(gcf,['NEVT_ROI_PDF_' name{1} '_NOISE_' Noise '_' Nomalization '_' method],'fig')
    close all
    close(wb)  
end