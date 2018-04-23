function []= DEBUG_function(setup,DATA,n)
sd = [1 round(length(setup.RANGE.NOISE)/2) length(setup.RANGE.NOISE)];
xest = linspace(min(DATA.sg.pdf.truth.x),max(DATA.sg.pdf.truth.x),setup.EST);
yest = GridNew(DATA.sg,xest,setup.TYPE.NAME);
f = setup.RANGE.NOISE(sd(n));
nt_max = 100;

for i = 1:nt_max
signal = noiseADD(xest,yest,f,setup.TYPE.NOISE);
%% => Definir o Grid após a estimação
ytruth = GridNew(DATA.sg,DATA.sg.pdf.truth.x,setup.TYPE.NAME);
ygridM_linear = interp1(xest,signal,DATA.sg.pdf.truth.x,'linear','extrap');
ygridM_nearest = interp1(xest,signal,DATA.sg.pdf.truth.x,'nearest','extrap');

plot(DATA.sg.pdf.truth.x,ygridM_linear+ytruth,'.:r'); hold on
plot(DATA.sg.pdf.truth.x,ygridM_nearest+ytruth,'.:g'); legend('Linear+Truth','Nearest+Truth')
pause

F11_L(i,:) = abs(ygridM_linear.*ytruth); F11_L(isnan(F11_L)|isinf(F11_L))=0;
F11_N(i,:) = abs(ygridM_nearest.*ytruth); F11_N(isnan(F11_N)|isinf(F11_N))=0;
F12_L(i,:) = abs(ygridM_linear./ytruth); F12_L(isnan(F12_L)|isinf(F12_L))=0;
F12_N(i,:) = abs(ygridM_nearest./ytruth); F12_N(isnan(F12_N)|isinf(F12_N))=0;
F13_L(i,:) = abs(sqrt(ygridM_linear-ytruth)); F13_L(isnan(F13_L)|isinf(F13_L))=0;
F13_N(i,:) = abs(sqrt(ygridM_nearest-ytruth)); F13_N(isnan(F13_N)|isinf(F13_N))=0;
F14_L(i,:) = abs(log(ygridM_linear.\ytruth)); F14_L(isnan(F14_L)|isinf(F14_L))=0;
F14_N(i,:) = abs(log(ygridM_nearest.\ytruth)); F14_N(isnan(F14_N)|isinf(F14_N))=0;

F21_L(i,:) = abs((ygridM_linear-ytruth).^2); F21_L(isnan(F21_L)|isinf(F21_L))=0;
F21_N(i,:) = abs((ygridM_nearest-ytruth).^2); F21_N(isnan(F21_N)|isinf(F21_N))=0;
F22_L(i,:) = abs((ygridM_linear.*ytruth).^(3/2)); F22_L(isnan(F22_L)|isinf(F22_L))=0;
F22_N(i,:) = abs((ygridM_nearest.*ytruth).^(3/2)); F22_N(isnan(F22_N)|isinf(F22_N))=0;
F23_L(i,:) = abs(sqrt(ygridM_linear)); F23_L(isnan(F23_L)|isinf(F23_L))=0;
F23_N(i,:) = abs(sqrt(ygridM_nearest)); F23_N(isnan(F23_N)|isinf(F23_N))=0;
F24_L(i,:) = abs(log(ygridM_linear)); F24_L(isnan(F24_L)|isinf(F24_L))=0;
F24_N(i,:) = abs(log(ygridM_nearest)); F24_N(isnan(F24_N)|isinf(F24_N))=0;

end

figure(1)
subplot(2,2,1);plot(DATA.sg.pdf.truth.x,mean(F11_L),'.:r'); hold on
subplot(2,2,1);plot(DATA.sg.pdf.truth.x,mean(F11_N),'.:g'); 
subplot(2,2,1);plot(DATA.sg.pdf.truth.x,max(F11_L),':r'); 
subplot(2,2,1);plot(DATA.sg.pdf.truth.x,max(F11_N),':g'); 
subplot(2,2,1);plot(DATA.sg.pdf.truth.x,min(F11_L),':r'); 
subplot(2,2,1);plot(DATA.sg.pdf.truth.x,min(F11_N),':g'); title('GT'); axis tight; legend('linear','nearest')
subplot(2,2,1);plotRANGE(max([max(max(F11_L)) max(max(F11_N))]),min([min(min(F11_L)) min(min(F11_N))]));

subplot(2,2,2);plot(DATA.sg.pdf.truth.x,mean(F12_L),'.:r'); hold on; 
subplot(2,2,2);plot(DATA.sg.pdf.truth.x,mean(F12_N),'.:g'); 
subplot(2,2,2);plot(DATA.sg.pdf.truth.x,max(F12_L),':r'); 
subplot(2,2,2);plot(DATA.sg.pdf.truth.x,max(F12_N),':g');
subplot(2,2,2);plot(DATA.sg.pdf.truth.x,min(F12_L),':r'); 
subplot(2,2,2);plot(DATA.sg.pdf.truth.x,min(F12_N),':g'); title('G/T'); axis tight; legend('linear','nearest')
subplot(2,2,2);plotRANGE(max([max(max(F12_L)) max(max(F12_N))]),min([min(min(F12_L)) min(min(F12_N))]));

subplot(2,2,3);plot(DATA.sg.pdf.truth.x,mean(F13_L),'.:r'); hold on;
subplot(2,2,3);plot(DATA.sg.pdf.truth.x,mean(F13_N),'.:g'); 
subplot(2,2,3);plot(DATA.sg.pdf.truth.x,max(F13_L),':r'); 
subplot(2,2,3);plot(DATA.sg.pdf.truth.x,max(F13_N),':g'); 
subplot(2,2,3);plot(DATA.sg.pdf.truth.x,min(F13_L),':r'); 
subplot(2,2,3);plot(DATA.sg.pdf.truth.x,min(F13_N),':g'); title('\surd(G-T)'); axis tight; legend('linear','nearest')
subplot(2,2,3);plotRANGE(max([max(max(F13_L)) max(max(F13_N))]),min([min(min(F13_L)) min(min(F13_N))]));

subplot(2,2,4);plot(DATA.sg.pdf.truth.x,mean(F14_L),'.:r'); hold on; 
subplot(2,2,4);plot(DATA.sg.pdf.truth.x,mean(F14_N),'.:g'); 
subplot(2,2,4);plot(DATA.sg.pdf.truth.x,max(F14_L),':r'); 
subplot(2,2,4);plot(DATA.sg.pdf.truth.x,max(F14_N),':g'); 
subplot(2,2,4);plot(DATA.sg.pdf.truth.x,min(F14_L),':r');
subplot(2,2,4);plot(DATA.sg.pdf.truth.x,min(F14_N),':g'); title('log(G\T)'); axis tight; legend('linear','nearest')
subplot(2,2,4);plotRANGE(max([max(max(F14_L)) max(max(F14_N))]),min([min(min(F14_L)) min(min(F14_N))]));

set(gcf, 'Position', get(0, 'Screensize'));
saveas(gcf,[pwd '\TEST4\TEST4[' setup.TYPE.NAME ']NOISE[' setup.TYPE.NOISE ']ROI[' setup.TYPE.ROI ']NORM[' setup.TYPE.NORM '][abs][1][' num2str(n) ']'],'png')
close all

figure(2)
subplot(2,2,1);plot(DATA.sg.pdf.truth.x,mean(F21_L),'.:r'); hold on; 
subplot(2,2,1);plot(DATA.sg.pdf.truth.x,mean(F21_N),'.:g'); 
subplot(2,2,1);plot(DATA.sg.pdf.truth.x,max(F21_L),':r'); 
subplot(2,2,1);plot(DATA.sg.pdf.truth.x,max(F21_N),':g'); 
subplot(2,2,1);plot(DATA.sg.pdf.truth.x,min(F21_L),':r'); 
subplot(2,2,1);plot(DATA.sg.pdf.truth.x,min(F21_N),':g'); title('(G-T)²'); axis tight; legend('linear','nearest')
subplot(2,2,1);plotRANGE(max([max(max(F21_L)) max(max(F21_N))]),min([min(min(F21_L)) min(min(F21_N))]));

subplot(2,2,2);plot(DATA.sg.pdf.truth.x,mean(F22_L),'.:r'); hold on; 
subplot(2,2,2);plot(DATA.sg.pdf.truth.x,mean(F22_N),'.:g'); 
subplot(2,2,2);plot(DATA.sg.pdf.truth.x,max(F22_L),':r'); 
subplot(2,2,2);plot(DATA.sg.pdf.truth.x,max(F22_N),':g'); 
subplot(2,2,2);plot(DATA.sg.pdf.truth.x,min(F22_L),':r'); 
subplot(2,2,2);plot(DATA.sg.pdf.truth.x,min(F22_N),':g'); title('(GT)^{3/2}'); axis tight; legend('linear','nearest')
subplot(2,2,2);plotRANGE(max([max(max(F22_L)) max(max(F22_N))]),min([min(min(F22_L)) min(min(F22_N))]));

subplot(2,2,3);plot(DATA.sg.pdf.truth.x,mean(F23_L),'.:r'); hold on; 
subplot(2,2,3);plot(DATA.sg.pdf.truth.x,mean(F23_N),'.:g'); 
subplot(2,2,3);plot(DATA.sg.pdf.truth.x,max(F23_L),':r'); 
subplot(2,2,3);plot(DATA.sg.pdf.truth.x,max(F23_N),':g'); 
subplot(2,2,3);plot(DATA.sg.pdf.truth.x,min(F23_L),':r'); 
subplot(2,2,3);plot(DATA.sg.pdf.truth.x,min(F23_N),':g'); title('\surd(G)'); axis tight; legend('linear','nearest')
subplot(2,2,3);plotRANGE(max([max(max(F23_L)) max(max(F23_N))]),min([min(min(F23_L)) min(min(F23_N))]));

subplot(2,2,4);plot(DATA.sg.pdf.truth.x,mean(F24_L),'.:r'); hold on; 
subplot(2,2,4);plot(DATA.sg.pdf.truth.x,mean(F24_N),'.:g'); 
subplot(2,2,4);plot(DATA.sg.pdf.truth.x,max(F24_L),':r'); 
subplot(2,2,4);plot(DATA.sg.pdf.truth.x,max(F24_N),':g'); 
subplot(2,2,4);plot(DATA.sg.pdf.truth.x,min(F24_L),':r'); 
subplot(2,2,4);plot(DATA.sg.pdf.truth.x,min(F24_N),':g'); title('log(G)'); axis tight; legend('linear','nearest')
subplot(2,2,4);plotRANGE(max([max(max(F24_L)) max(max(F24_N))]),min([min(min(F24_L)) min(min(F24_N))]));

set(gcf, 'Position', get(0, 'Screensize'));
saveas(gcf,[pwd '\TEST4\TEST4[' setup.TYPE.NAME ']NOISE[' setup.TYPE.NOISE ']ROI[' setup.TYPE.ROI ']NORM[' setup.TYPE.NORM '][abs][2][' num2str(n) ']'],'png')
close all

end