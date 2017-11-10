%% TESTE Bias X Variance

clear variables; close all; clc

Noise = 'normal';
Nomalization = 'norm';
% load PT_int1000
% for name = {'Gauss','Bimodal','Rayleigh','Logn','Gamma'};
method = 'full';
name = {'Bimodal'};

nt_max = 100;
ip = 0;
for nvar = linspace(0,1,50);
    
    ip = ip+1;
    wb = waitbar(0,'Aguarde');
    for nt = 1:nt_max;
        
        [setup] = IN(10000,1000);
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
            
            [AMP,N,sinal,yfull] = NoiseFix(nvar,1000000,sg,sinal,yfull,Noise);
            
            [noise.dy] = noiseADD(sinal.dy,yfull.dy,AMP,N,Noise);
            [noise.py] = noiseADD(sinal.py,yfull.py,AMP,N,Noise);
            [noise.eq.dy] = noiseADD(sinal.eq.dy,yfull.eq.dy,AMP,N,Noise);
            [noise.eq.py] = noiseADD(sinal.eq.py,yfull.eq.py,AMP,N,Noise);
            
            [noise,signal] = MethodFix(xfull,yfull,xRoI,sinal,noise,method);
            
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
    close(wb)
    
    for div=1:15
    B.dy= (mean(real(A.dy{div}')));
    B.py= (mean(real(A.py{div}')));
    B.eq.dy= (mean(real(A.eq.dy{div}')));
    B.eq.py= (mean(real(A.eq.py{div}')));
    
    C.dy{div}(ip,:) = B.dy;
    C.py{div}(ip,:) = B.py;
    C.eq.dy{div}(ip,:) = B.eq.dy;
    C.eq.py{div}(ip,:) = B.eq.py;
    end
    
end
%
VL={'Bias','Variance','MISE','Linf','Lp','Sorensen','Gower','IP','Harmonic','Cosine','Hellinger','Squared','AddSym','Kullback','Kumar'};
CL=['kkkggrrbbbcmmyk'];
ML=[':::::::::::::::'];

bin = linspace(0,1,setup.DIV);
% X = (1:setup.DIV)*setup.DIV;

% for b =1:15
%         figure(1)
%         subplot(3,5,b); errorbar(bin,(mean(real(A.dy{b}'))),(std(real(A.dy{b}'))/sqrt(nt)),['s' ML(b) CL(b)],'MarkerSize',3); axis tight; grid on; set(gca,'GridLineStyle',':')
%         title([VL{b} '(D)'])
%         xlabel('Max(%)')
%         ylabel('Divergencia')
%
%         figure(2)
%         subplot(3,5,b); errorbar(bin,(mean(real(A.py{b}'))),(std(real(A.py{b}'))/sqrt(nt)),['s' ML(b) CL(b)],'MarkerSize',3); axis tight; grid on; set(gca,'GridLineStyle',':')
%         title([VL{b} '(P)'])
%         xlabel('Max(%)')
%         ylabel('Divergencia')

%     figure(3)
%     subplot(3,5,b); errorbar(bin,(mean(real(A.eq.dy{b}'))),(std(real(A.eq.dy{b}'))/sqrt(nt_max)),['s' ML(b) CL(b)],'MarkerSize',3); axis tight; grid on; set(gca,'GridLineStyle',':')
%     title([VL{b} '(ED)'])
%     xlabel('Max(%)')
%     ylabel('Divergencia')
%
%     figure(4)
%     subplot(3,5,b); errorbar(bin,(mean(real(A.eq.py{b}'))),(std(real(A.eq.py{b}'))/sqrt(nt_max)),['s' ML(b) CL(b)],'MarkerSize',3); axis tight; grid on; set(gca,'GridLineStyle',':')
%     title([VL{b} '(EP)'])
%     xlabel('Max(%)')
%     ylabel('Divergencia')
% end


% figure(1)
% set(gcf, 'Position', get(0, 'Screensize'));
% saveas(gcf,['BOX_ROI_PDF_' name{1} '_NOISE_' Noise '_DY_' Nomalization],'fig')
% figure(2)
% set(gcf, 'Position', get(0, 'Screensize'));
% saveas(gcf,['BOX_ROI_PDF_' name{1} '_NOISE_' Noise '_PY_' Nomalization],'fig')
% figure(3)
% set(gcf, 'Position', get(0, 'Screensize'));
% saveas(gcf,['BOX_ROI_PDF_' name{1} '_NOISE_' Noise '_EQDY_' Nomalization],'fig')
% figure(4)
% set(gcf, 'Position', get(0, 'Screensize'));
% saveas(gcf,['BOX_ROI_PDF_' name{1} '_NOISE_' Noise '_EQPY_' Nomalization],'fig')
% close all

% end