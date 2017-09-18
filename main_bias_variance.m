%% TESTE Bias X Variance

clear variables; close all; clc

doPlot.Shape = 1;
Noise = 'normal';
Nomalization = 'no';
% bin = 100000:100000:200000
be=linspace(-1,0,26);
bd=linspace(0,1,26);
bin=[be(1:end-1) bd];

for name = {'Gauss'};
%     for name = {'Gauss','Bimodal','Rayleigh','Logn','Gamma'};
    for test = {'Bias','Variance','Both','Truth'};
        
        
        wb = waitbar(0,'Aguarde');
        for nt = 1;
            
            [setup] = IN(1000);
            [sg,~] = datasetGenSingle(setup,name{1});
            
            i = 0;
            for B=bin
                i=i+1;
                xh2 = linspace(min(sg.evt),max(max(sg.evt)),1000);
                
                switch name{1}
                    case 'Gauss'
                        ytruth = [normpdf(xh2,sg.g1.mu,sg.g1.std)];
                    case 'Bimodal'
                        ytruth = [normpdf(xh2,sg.g1.mu,sg.g1.std) + normpdf(xh2,sg.g2.mu,sg.g2.std)]/2;
                    case 'Rayleigh'
                        ytruth = raylpdf(sg.pdf.truth.x,sg.b);
                    case 'Logn'
                        ytruth = lognpdf(sg.pdf.truth.x,sg.mu,sg.std);
                    case 'Gamma'
                        ytruth = gampdf(sg.pdf.truth.x,sg.A,sg.B);
                end
                AMP = B*max(sg.pdf.truth.y);
                [noise] = noiseADD(sg.pdf.truth.y,AMP,'normal');
                
                switch test{1}
                    case 'Bias'
                        signal = sg.pdf.truth.y+AMP;
                    case 'Variance'
                        signal = sg.pdf.truth.y+noise;
                    case 'Both'
                        signal = sg.pdf.truth.y+noise+AMP;
                    case 'Truth'
                        signal = sg.pdf.truth.y;
                end
                
                if doPlot.Shape == 1
                    plot(sg.pdf.truth.x,sg.pdf.truth.y,'k');
                    %                     plot(sg.pdf.truth.x,signal,':r',sg.pdf.truth.x,sg.pdf.truth.y,'k');
%                     title([test]);       
                    legend('Signal','Truth'); axis tight;
                    grid on; set(gca,'GridLineStyle',':');
                    saveas(gcf,['SHAPE_' name{1}],'fig')
                    %                     saveas(gcf,['SHAPE_' test{1} '_' name{1}],'fig')
                    close all
%                     pause
                end
                
                
                [V] = DFSelect(signal,sg.pdf.truth.y,Nomalization);
                
                for div = 1:15
                    A{div}(i,nt) = V(div);
                end
            end
            waitbar(nt/50)
        end
        close(wb)
        
        VL={'Bias','Variance','MISE','Linf','Lp','Sorensen','Gower','IP','Harmonic','Cosine','Hellinger','Squared','AddSym','Kullback','Kumar'};
        CL=['kkkggrrbbbcmmyk'];
        ML=[':::------------'];
        
        for b =1:15
            % subplot(3,5,b); plot(bin,(mean(A{b}')),[ML(b) CL(b)]); axis tight; grid on; set(gca,'GridLineStyle',':')
            subplot(3,5,b);boxplot(real(A{b}'),bin,'colors',CL(b)); axis tight; grid on; set(gca,'GridLineStyle',':');
            set(gca,'XtickLabel',[min(bin) 0 max(bin)]')
            set(gca,'Xtick',[1 27 50])
            title([VL{b}])
            xlabel('Amplitude')
            ylabel('Divergencia')
            
        end
        %
        %         set(gcf, 'Position', get(0, 'Screensize'));
        %         saveas(gcf,['BOX_BIASxVARIANCE_' test{1} '_PDF_' name{1} '_NOISE_' Noise],'fig')
        %         close all
        
    end
end