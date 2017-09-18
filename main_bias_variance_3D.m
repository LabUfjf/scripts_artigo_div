%% TESTE Bias X Variance

clear variables; close all; clc

doPlot.Shape = 1;
Noise = 'normal';
Nomalization = 'no';
be=linspace(-1,0,26);
bd=linspace(0,1,26);
bin=[be(1:end-1) bd];


for name = {'Gauss','Bimodal','Rayleigh','Logn','Gamma'};
    wb = waitbar(0,'Aguarde');
    
    [setup] = IN(1000);
    [sg,~] = datasetGenSingle(setup,name{1});
    
    i = 0;
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
    
    for B1=bin
        i=i+1;
        AMP1 = B1*max(sg.pdf.truth.y);
        j=0;
        for B2 = bin
            j=j+1;
            AMP2 = B2*max(sg.pdf.truth.y);
            [noise] = noiseADD(sg.pdf.truth.y,AMP2,'normal');
            
            
            signal = sg.pdf.truth.y+noise+AMP1;
            
            [V] = DFSelect(signal,sg.pdf.truth.y,Nomalization);
            
            for div = 1:15
                A{div}(i,j) = V(div);
            end
        end
        waitbar(i/length(bin))
    end
    close(wb)
    
    VL={'Bias','Variance','MISE','Linf','Lp','Sorensen','Gower','IP','Harmonic','Cosine','Hellinger','Squared','AddSym','Kullback','Kumar'};
    CL=['kkkggrrbbbcmmyk'];
    ML=[':::------------'];
    %
    for b =1:15
        subplot(3,5,b);  surf((bin)*max(sg.pdf.truth.y),(bin)*max(sg.pdf.truth.y),real(A{b}),'FaceColor','green','EdgeColor','none');hold on
        subplot(3,5,b);  contour((bin)*max(sg.pdf.truth.y),(bin)*max(sg.pdf.truth.y),real(A{b}))
        camlight left; lighting phong; axis tight; alpha(1);grid on
        title([VL{b}])
        ylabel('Bias')
        xlabel('NV')
        zlabel('Divergence')
        %
    end
%     pause
    set(gcf, 'Position', get(0, 'Screensize'));
    saveas(gcf,['SURF3D_BIASxVARIANCE_PDF_' name{1} '_NOISE_' Noise '_' Nomalization],'fig')
    close all
    
end
