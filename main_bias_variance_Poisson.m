%% TESTE Bias X Variance

clear variables; close all; clc
% load PT_int
doPlot.Shape = 1;
Noise = 'poisson';
Nomalization = 'no';

Nevt=linspace(5500,1000000,1000);
% Nevt=1000;
Nbins = 5500;

for name = {'Gauss'};
    %     for name = {'Gauss','Bimodal','Rayleigh','Logn','Gamma'}; 
    for nt = 1:50;
        wb = waitbar(0,'Aguarde');
        i = 0;
        for N=Nevt;                
            i=i+1;
            [setup] = IN(10000,Nbins);
            [sg,~] = datasetGenSingle(setup,name{1});            
            xh2 = linspace(min(sg.evt),max(max(sg.evt)),Nbins);
            
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
            
            [signal] = noiseADD(ytruth,ytruth,[],N,'poisson');
%             [signal] = PoissonADD(ytruth,N);
%                         stairs(xh2,ytruth,'k'); hold on
%                         stairs(xh2,signal/area2d(xh2,signal),'r');
%                         pause
%                         close
            signal = signal/area2d(xh2,signal);
            [V] = DFSelect(signal,ytruth,Nomalization);
%             plot(signal);hold on
%             plot(ytruth)
%             pause
%             close
            
            for div = 1:15
                A{div}(i,nt) = V(div);
            end          
            waitbar(i/length(Nevt))
        end
        close(wb)
    end
    
          VL={'Bias','Variance','MISE','Linf','Lp','Sorensen','Gower','IP','Harmonic','Cosine','Hellinger','Squared','AddSym','Kullback','Kumar'};
            CL=['kkkggrrbbbcmmyk'];
             ML=[':::::::::::::::'];
%             ML=[':::------------'];
            bin = Nevt;
            for b =1:15
                 subplot(3,5,b); plot(bin,(mean(A{b}')),['s' ML(b) CL(b)],'MarkerSize',3); axis tight; grid on; set(gca,'GridLineStyle',':')
%                 subplot(3,5,b); plot(bin,(mean(A{b}')),[ML(b) CL(b)]); axis tight; grid on; set(gca,'GridLineStyle',':')
%                 subplot(3,5,b);boxplot(real(A{b}'),bin,'colors',CL(b)); axis tight; grid on; set(gca,'GridLineStyle',':');
%                 set(gca,'XtickLabel',[min(bin)  max(bin)]')
%                 set(gca,'Xtick',[bin(1) bin(end)])
                title([VL{b}])
                xlabel('Eventos')
                ylabel('Divergência')
             VCTPOISSON.MEAN(b+1,:) = (mean((A{b}')));
            VCTPOISSON.STD(b+1,:) = (std((A{b}')));
                
            end
en
d
       VCTPOISSON.MEAN(1,:) = Nevt;
        VCTPOISSON.STD(1,:) = Nevt;
        save(['VCTPOISSON' num2str(Nbins)],'VCTPOISSON')
    
        
%             if doPlot.Shape == 1
%                 plot(sg.pdf.truth.x,sg.pdf.truth.y,'k');
%                 %                     plot(sg.pdf.truth.x,signal,':r',sg.pdf.truth.x,sg.pdf.truth.y,'k');
%                 %                     title([test]);
%                 legend('Signal','Truth'); axis tight;
%                 grid on; set(gca,'GridLineStyle',':');
%                 saveas(gcf,['SHAPE_' name{1}],'fig')
%                 %                     saveas(gcf,['SHAPE_' test{1} '_' name{1}],'fig')
%                 close all
%                 %                     pause
%             end
%
%
%
%         end
%         waitbar(nt/50)
%     end
%     close(wb)
%

%
%         set(gcf, 'Position', get(0, 'Screensize'));
%         saveas(gcf,['BOX_BIASxVARIANCE_' test{1} '_PDF_' name{1} '_NOISE_' Noise],'fig')
%         close all

