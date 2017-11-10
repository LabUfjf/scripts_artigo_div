%% TESTE Bias X Variance

clear variables; close all; clc

Noise = 'Poisson';
Nomalization = 'no';
load PT_int1000
% for name = {'Gauss','Bimodal','Rayleigh','Logn','Gamma'};

name = {'Bimodal'};
wb = waitbar(0,'Aguarde');
% N=10000;
for nt = 1:50;
    
    [setup] = IN(1000);
    [sg,~] = datasetGenSingle(setup,name{1});
    
    i = 0;
    for RoI=1:setup.DIV
        
        i=i+1;
        xRoI.dy = sg.RoI.x.dy{RoI};
        xRoI.py = sg.RoI.x.py{RoI};
        xRoI.eq.dy = sg.RoI.x.eq.dy{RoI};
        xRoI.eq.py = sg.RoI.x.eq.py{RoI};
        
        switch name{1}
            case 'Gauss'
                sinal.dy = [normpdf(xRoI.dy,sg.g1.mu,sg.g1.std)];
                sinal.py = [normpdf(xRoI.py,sg.g1.mu,sg.g1.std)];
                sinal.eq.dy = [normpdf(xRoI.eq.dy,sg.g1.mu,sg.g1.std)];
                sinal.eq.py = [normpdf(xRoI.eq.py,sg.g1.mu,sg.g1.std)];
            case 'Bimodal'
                sinal.dy = [normpdf(xRoI.dy,sg.g1.mu,sg.g1.std) + normpdf(xRoI.dy,sg.g2.mu,sg.g2.std)]/2;
                sinal.py = [normpdf(xRoI.py,sg.g1.mu,sg.g1.std) + normpdf(xRoI.py,sg.g2.mu,sg.g2.std)]/2;
                sinal.eq.dy = [normpdf(xRoI.eq.dy,sg.g1.mu,sg.g1.std) + normpdf(xRoI.eq.dy,sg.g2.mu,sg.g2.std)]/2;
                sinal.eq.py = [normpdf(xRoI.eq.py,sg.g1.mu,sg.g1.std) + normpdf(xRoI.eq.py,sg.g2.mu,sg.g2.std)]/2;
            case 'Rayleigh'
                sinal.dy = raylpdf(xRoI.dy,sg.b);
                sinal.py = raylpdf(xRoI.py,sg.b);
                sinal.eq.dy = raylpdf(xRoI.eq.dy,sg.b);
                sinal.eq.py = raylpdf(xRoI.eq.py,sg.b);
            case 'Logn'
                sinal.dy = lognpdf(xRoI.dy,sg.mu,sg.std);
                sinal.py = lognpdf(xRoI.py,sg.mu,sg.std);
                sinal.eq.dy = lognpdf(xRoI.eq.dy,sg.mu,sg.std);
                sinal.eq.py = lognpdf(xRoI.eq.py,sg.mu,sg.std);
            case 'Gamma'
                sinal.dy = gampdf(xRoI.dy,sg.A,sg.B);
                sinal.py = gampdf(xRoI.py,sg.A,sg.B);
                sinal.eq.dy = gampdf(xRoI.eq.dy,sg.A,sg.B);
                sinal.eq.py = gampdf(xRoI.eq.py,sg.A,sg.B);
        end
        
        for div = 1:15
            N=round(PT_int(div,2));
            
            sgbg.dy = PoissonADD(sinal.dy,N);
            sgbg.py = PoissonADD(sinal.py,N);
            sgbg.eq.dy = PoissonADD(sinal.eq.dy,N);
            sgbg.eq.py = PoissonADD(sinal.eq.py,N);
            
            
            [V.dy] = DFSelect(sgbg.dy,sinal.dy,Nomalization);
            [V.py] = DFSelect(sgbg.py,sinal.py,Nomalization);
            [V.eq.dy] = DFSelect(sgbg.eq.dy,sinal.eq.dy,Nomalization);
            [V.eq.py] = DFSelect(sgbg.eq.py,sinal.eq.py,Nomalization);
            
            
            A.dy{div}(RoI,nt) = V.dy(div);
            A.py{div}(RoI,nt) = V.py(div);
            A.eq.dy{div}(RoI,nt) = V.eq.dy(div);
            A.eq.py{div}(RoI,nt) = V.eq.py(div);
        end
        
    end
    waitbar(nt/50)
end
close(wb)

VL={'Bias','Variance','MISE','Linf','Lp','Sorensen','Gower','IP','Harmonic','Cosine','Hellinger','Squared','AddSym','Kullback','Kumar'};
CL=['kkkggrrbbbcmmyk'];
ML=[':::::::::::::::'];

bin = linspace(0,1,setup.DIV);
% X = (1:setup.DIV)*setup.DIV;
for b =1:15
    figure(1)
    %     subplot(3,5,b); plot(bin,(mean(A.dy{b}')),['s' ML(b) CL(b)],'MarkerSize',3); axis tight; grid on; set(gca,'GridLineStyle',':')
    subplot(3,5,b); errorbar(bin,(mean(A.dy{b}')),(std(A.dy{b}')),['s' ML(b) CL(b)],'MarkerSize',3); axis tight; grid on; set(gca,'GridLineStyle',':')
    %     subplot(3,5,b);boxplot(real(A.dy{b}'),X,'colors',CL(b)); axis tight; grid on; set(gca,'GridLineStyle',':');
    title([VL{b} '(D)'])
    xlabel('Max(%)')
    ylabel('Divergencia')
    
    figure(2)
    %     subplot(3,5,b); plot(bin,(mean(A.py{b}')),['s' ML(b) CL(b)],'MarkerSize',3); axis tight; grid on; set(gca,'GridLineStyle',':')
    %         subplot(3,5,b); plot(bin,(mean(A.py{b}')),(std(A.py{b}')),['s' ML(b) CL(b)],'MarkerSize',3); axis tight; grid on; set(gca,'GridLineStyle',':')
    subplot(3,5,b); errorbar(bin,(mean(A.py{b}')),(std(A.py{b}')),['s' ML(b) CL(b)],'MarkerSize',3); axis tight; grid on; set(gca,'GridLineStyle',':')
    %     subplot(3,5,b);boxplot(real(A.py{b}'),X,'colors',CL(b)); axis tight; grid on; set(gca,'GridLineStyle',':');
    title([VL{b} '(P)'])
    xlabel('Max(%)')
    ylabel('Divergencia')
    
    figure(3)
    %     subplot(3,5,b); plot(bin,(mean(A.eq.dy{b}')),['s' ML(b) CL(b)],'MarkerSize',3); axis tight; grid on; set(gca,'GridLineStyle',':')
    subplot(3,5,b); errorbar(bin,(mean(A.eq.dy{b}')),(std(A.eq.dy{b}')),['s' ML(b) CL(b)],'MarkerSize',3); axis tight; grid on; set(gca,'GridLineStyle',':')
    %     subplot(3,5,b);boxplot(real(A.eq.dy{b}'),X,'colors',CL(b)); axis tight; grid on; set(gca,'GridLineStyle',':');
    title([VL{b} '(ED)'])
    xlabel('Max(%)')
    ylabel('Divergencia')
    
    figure(4)
    %     subplot(3,5,b); plot(bin,(mean(A.eq.py{b}')),['s' ML(b) CL(b)],'MarkerSize',3); axis tight; grid on; set(gca,'GridLineStyle',':')
    subplot(3,5,b); errorbar(bin,(mean(A.eq.py{b}')),(std(A.eq.py{b}')),['s' ML(b) CL(b)],'MarkerSize',3); axis tight; grid on; set(gca,'GridLineStyle',':')
    %     subplot(3,5,b);boxplot(real(A.eq.py{b}'),X,'colors',CL(b)); axis tight; grid on; set(gca,'GridLineStyle',':');
    title([VL{b} '(EP)'])
    xlabel('Max(%)')
    ylabel('Divergencia')
end

figure(1)
set(gcf, 'Position', get(0, 'Screensize'));
saveas(gcf,['BOX_ROI_PDF_' name{1} '_NOISE_' Noise '_DY_' Nomalization],'fig')
figure(2)
set(gcf, 'Position', get(0, 'Screensize'));
saveas(gcf,['BOX_ROI_PDF_' name{1} '_NOISE_' Noise '_PY_' Nomalization],'fig')
figure(3)
set(gcf, 'Position', get(0, 'Screensize'));
saveas(gcf,['BOX_ROI_PDF_' name{1} '_NOISE_' Noise '_EQDY_' Nomalization],'fig')
figure(4)
set(gcf, 'Position', get(0, 'Screensize'));
saveas(gcf,['BOX_ROI_PDF_' name{1} '_NOISE_' Noise '_EQPY_' Nomalization],'fig')
close all

% end