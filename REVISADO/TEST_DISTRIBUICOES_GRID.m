% TEST DISTRIBUIÕES
clear variables;  clc; close all;
%=========================================================================
% TESTANDO TODAS AS DISTRIBUIÇÕES QUE SERÃO UTILIZADAS NA TESE
%=========================================================================
norm = 'fit';
inter = 'linear';
errortype = 'none';
mod = 'abs';
j=0;
cl = ['yrbgkmc'];
for name = {'Uniform','Gaussian','Bimodal','Trimodal','Rayleigh','Logn','Gamma'};
    % name={'Gaussian'};
    j=j+1;
    %=========================================================================
    nEVT = 1;
    nEST = 10;
    %     vGRID = linspace(50,1000000,100);
    vGRID = 100000;
    nROI = 1;
    wb=waitbar(0,'Aguarde...');
    for i=1:length(vGRID);
        nGRID= vGRID(i);
        [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
        [DATA] = datasetGenSingle(setup);
        DA(i)=abs(area2d(DATA.sg.pdf.truth.x,DATA.sg.pdf.truth.y)-DATA.sg.Integral);
        waitbar(i/length(vGRID))
    end
    close(wb)
    D(j) = DA;
    %     h=diff(DATA.sg.pdf.truth.x); h=h(1);
    %     Dy(j,:)=abs(diff(DATA.sg.pdf.truth.y)/h);
    %
    %     H(j)=h;
    %     x(j,:)=DATA.sg.pdf.truth.x;
    %     y(j,:)=DATA.sg.pdf.truth.y;
    %     vDR(j) = mean(abs(diff(DATA.sg.pdf.truth.y)/h));
    %     vDA(j) = mean(DA);
    plot(vGRID,DA,['-' cl(j)])
    xlabel('Pontos de Grid','FontSize',14)
    ylabel('Erro de Área','FontSize',14)
    grid on
    axis tight
    set(gca,'GridLineStyle',':','xscale','log','yscale','log','FontSize',12);
    %   legend([name{1}])
    %   saveas(gcf,[pwd '\TEST_DISTRIBUICOES\DISTERROR[' name{1} ']'],'png')
    %   saveas(gcf,[pwd '\TEST_DISTRIBUICOES\DISTERROR[' name{1} ']'],'fig')
    %   close
    hold on
end


legend('Uniform','Gaussian','Bimodal','Trimodal','Rayleigh','Logn','Gamma')
% pause
% % axis([min(DATA.sg.pdf.truth.x) max(DATA.sg.pdf.truth.x) 0 max(DATA.sg.pdf.truth.y)])
% end
% bin = calcnbins(DATA.sg.evt,'fd');
% [xh,yh] = data_normalized(DATA.sg.evt,bin);
% d = diff(xh); d = d(1);
% hold on
% stairs(xh-d/2,yh,'k')
%
for j = 1:7
    %     figure(3)
    %    bar(j,vDR(j)'); hold on
    %    figure(4)
    bar(j,sum(Dy(j,:))); hold on
    %     DAr(j)=area2d(Dx(j,1:end-1),Dy(j,:));
    
    %     Rg(j) = sum(diff(Dy(j,:).^2).*y(j,1:end-2)*H(j))
end
% % xlabel('x')
% % ylabel('Derivada')
% %  legend('Uniform','Gaussian','Bimodal','Trimodal','Rayleigh','Logn','Gamma')
%  figure(4)
%  bar(Rg)