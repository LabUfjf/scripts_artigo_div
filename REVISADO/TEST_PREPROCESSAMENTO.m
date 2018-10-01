% TEST DISTRIBUIÕES
clear variables;  clc; close all;
%=========================================================================
% TESTANDO TODAS AS DISTRIBUIÇÕES QUE SERÃO UTILIZADAS NA TESE
%=========================================================================
norm = 'fit';
inter = 'linear';
errortype = 'none';
mod = 'abs';
% for name = {'Uniform','Gaussian','Bimodal','Trimodal','Rayleigh','Logn','Gamma'};
name={'Gaussian'};
%=========================================================================
nEVT = 2500;
nEST = 100;
nGRID= 10^5;
nROI = 1;
nt = 250;
nbin = 2500;


% wb = waitbar(0,'Aguarde...')

% for i = 1:nt
% [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
% setup.MINMAX.STD =4;            % STD para escolher o range das PDFs.
% [DATA] = datasetGenSingle(setup);
% DATAO = [DATA.sg.evt; 100];
% for bin = 2:nbin;
% [yh,xh]=hist(DATA.sg.evt,bin); yh = yh/area2d(xh,yh);
% [yho,xho]=hist(DATAO,bin); yho = yho/area2d(xho,yho);
% yh_grid = interp1(xh,yh,DATA.sg.pdf.truth.x,'nearest','extrap');
% yho_grid = interp1(xho,yho,DATA.sg.pdf.truth.x,'nearest','extrap');
% A_grid(i,bin)=area2d(DATA.sg.pdf.truth.x,abs(DATA.sg.pdf.truth.y-yh_grid));
% Ao_grid(i,bin)=area2d(DATA.sg.pdf.truth.x,abs(DATA.sg.pdf.truth.y-yho_grid));
% end
% binn.fd(i)=calcnbins(DATA.sg.evt,'fd');
% bino.fd(i)=calcnbins(DATAO,'fd');
% binn.scott(i)=calcnbins(DATA.sg.evt,'scott');
% bino.scott(i)=calcnbins(DATAO,'scott');
% waitbar(i/nt)
% end
% close(wb)
% bin = 2:nbin;
% 
% plot(bin,mean(A_grid(:,2:end)),'-k'); hold on
% plot(bin,mean(A_grid(:,2:end))+std(A_grid(:,2:end)),':k'); hold on
% [nn]=find(mean(A_grid(:,2:end))==min(mean(A_grid(:,2:end))));
% vn =min(mean(A_grid(:,2:end)));
% plot(bin(nn),vn,'ok');
% plot(round(mean(binn.fd)),vn,'sk');
% plot(round(mean(binn.scott)),vn,'+k');
% 
% plot(bin,mean(Ao_grid(:,2:end)),'-r'); hold on
% plot(bin,mean(Ao_grid(:,2:end))+std(Ao_grid(:,2:end)),':r'); hold on
% [nno]=find(mean(Ao_grid(:,2:end))==min(mean(Ao_grid(:,2:end))));
% vno =min(mean(Ao_grid(:,2:end)));
% plot(bin(nno),vno,'or');
% plot(round(mean(bino.fd)),vno,'sr');
% plot(round(mean(bino.scott)),vno,'+r');
% 
% plot(bin,mean(A_grid(:,2:end))-std(A_grid(:,2:end)),':k'); hold on
% plot(bin,mean(Ao_grid(:,2:end))-std(Ao_grid(:,2:end)),':r'); hold on
% 
% legend('\mu Grid','\sigma Grid','Bin Ótimo','Bin FD','Bin Scott','\mu Grid_{outlier}','\sigma Grid_{outlier}','Bin_{outlier} Ótimo','Bin_{outlier} FD','Bin_{outlier} Scott')
% ylabel('Área do Erro')
% xlabel('Número de Bins')
% grid on
% set(gca,'GridLineStyle',':','xscale','log','yscale','log','FontSize',12);
% axis tight
method = 'scott';
[setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
setup.MINMAX.STD =4;            % STD para escolher o range das PDFs.
[DATA] = datasetGenSingle(setup);
bin = calcnbins(DATA.sg.evt,method);
DATAO = [-100; DATA.sg.evt; 100];


histf(DATA.sg.evt,bin,'facecolor',[0.75 0.75 0.75],'facealpha',.5,'edgecolor','none'); hold on; axis tight
plot(DATA.sg.pdf.truth.x,DATA.sg.pdf.truth.y,'-k')
axis tight;grid on
set(gca,'GridLineStyle',':')
axis tight
set(gca,'FontSize',12)
legend('Histograma_{Outlier}','PDF')
ylabel('Densidade de Probabilidade')
xlabel('Variável Aleatória')


figure
bin = calcnbins(DATAO,method);
subplot(1,2,1);histf(DATAO,bin,'facecolor',[0.75 0.75 0.75],'facealpha',.5,'edgecolor','none'); hold on; axis tight
subplot(1,2,1);plot(DATA.sg.pdf.truth.x,DATA.sg.pdf.truth.y,'-k')
axis tight
grid on
set(gca,'GridLineStyle',':')
axis tight
set(gca,'FontSize',12)
plot(min(DATAO),0,'*k'); plot(max(DATAO),0,'*k');
legend('Histograma_{Outlier}','PDF')
ylabel('Densidade de Probabilidade')
xlabel('Variável Aleatória')

subplot(1,2,2);histf(DATAO,bin,'facecolor',[0.75 0.75 0.75],'facealpha',.5,'edgecolor','none'); hold on; axis tight
subplot(1,2,2);plot(DATA.sg.pdf.truth.x,DATA.sg.pdf.truth.y,'-k')
axis tight
grid on
set(gca,'GridLineStyle',':')
axis tight
set(gca,'FontSize',12)
plot(min(DATAO),0,'*k'); plot(max(DATAO),0,'*k');
xlim([min(DATA.sg.pdf.truth.x) max(DATA.sg.pdf.truth.x)])
legend('PDF','Histograma_{Outlier}')
ylabel('Densidade de Probabilidade')
xlabel('Variável Aleatória')

M = mean(DATA.sg.evt);
Mo = mean(DATAO);

S = std(DATA.sg.evt);
So = std(DATAO);

bin =500;

figure
DATAD = [DATA.sg.evt; 0*ones(200,1); -1*ones(200,1)];
[yhd,xhd]=hist(DATAD,bin); yhd = yhd/area2d(xhd,yhd);
dhd = diff(xhd); dhd=dhd(1)/2;

histf(DATAD,bin,'facecolor',[0.75 0.75 0.75],'facealpha',.5,'edgecolor','none'); hold on; axis tight
% stairs(xhd-dhd,yhd,'-r'); hold on;
plot(DATA.sg.pdf.truth.x,DATA.sg.pdf.truth.y,'-k')
axis tight;grid on
set(gca,'GridLineStyle',':')
axis tight
set(gca,'FontSize',12)
legend('Histograma','PDF')
xlim([min(DATA.sg.pdf.truth.x) max(DATA.sg.pdf.truth.x)])
ylabel('Densidade de Probabilidade')
xlabel('Variável Aleatória')
% 
% var(DATA.sg.evt)
% var(DATAO)
%     saveas(gcf,[pwd '\TEST_PREPROCESSAMENTO\DIST[' name{1} ']'],'png')
%     saveas(gcf,[pwd '\TEST_PREPROCESSAMENTO\DIST[' name{1} ']'],'fig')
%     close
% pause
% % axis([min(DATA.sg.pdf.truth.x) max(DATA.sg.pdf.truth.x) 0 max(DATA.sg.pdf.truth.y)])
% end
% bin = calcnbins(DATA.sg.evt,'fd');
% [xh,yh] = data_normalized(DATA.sg.evt,bin);
% d = diff(xh); d = d(1);
% hold on
% stairs(xh-d/2,yh,'k')

% plot(DATA.sg.pdf.truth.x,DATA.sg.pdf.truth.y,'-k')
% xlabel('Variável Aleatória','FontSize',14)
% ylabel('Densidade de Probabilidade','FontSize',14)
% grid on
% set(gca,'GridLineStyle',':')
% axis tight
% set(gca,'FontSize',12)
