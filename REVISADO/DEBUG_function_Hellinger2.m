% 
% 
% plot(DATA.sg.pdf.truth.x,sqrt(DATA.sg.pdf.truth.y)/max(sqrt(DATA.sg.pdf.truth.y)))
% hold on; plot(DATA.sg.pdf.truth.x,(DATA.sg.pdf.truth.y)/max(DATA.sg.pdf.truth.y))
% 
% 
% plot(sqrt(DATA.sg.pdf.truth.y),(DATA.sg.pdf.truth.y))
% 
% 
% plot(mean(cell2mat(DATA.sg.RoI.x')'),sqrt(sum(cell2mat(DATA.sg.RoI.y')'))./(sum(cell2mat(DATA.sg.RoI.y')')))
% 
% 
% plot(mean(cell2mat(DATA.sg.RoI.x')'),sqrt(sqrt(sum(cell2mat(DATA.sg.RoI.y')').^2)))
%     
% 

clear
load f


[setup] = IN('Gaussian','sg','poisson','dist','linear','bypass',1,1e4,1000,1);   % Definir os Parâmetros Iniciais
[DATA] = datasetGenSingle(setup);   
[X.EST,X.GRID,Y.EST,Y.GRID,Y.TRUTH] = Method_ADDNoise(setup,DATA,100);
v =Y.TRUTH;
[~,~,Y.EST,n,~] = Method_ADDNoise(setup,DATA,f.poisson(end));
subplot(3,1,1);plot(v,real(sqrt(n)),':r'); hold on
subplot(3,1,1);plot(v,real(sqrt(v)),'k'); hold on; 
subplot(3,1,1);xlabel('Probability'); ylabel('Amplitude'); legend('\surdNoise','\surdSignal')

sd = [1 round(length(f.poisson)/2) length(f.poisson)];
cl = ['rgbk']
figure
for j = 1:length(sd)
for i=1:700
    [~,~,Y.EST,n,~] = Method_ADDNoise(setup,DATA,f.poisson(sd(j)));
    
% n = v'+sd(j)*randn(length(v),1);
nv = real(sqrt(v)-sqrt(n)).^2;
nvx{j}(i,:) =real(nv);
end

plot(v,real(mean(nvx{j})),[':' cl(j)]); hold on
% plot(v,real(mean(nvx{j})),[':' cl(j)]); hold on
end
% subplot(3,1,2);xlabel('Probability'); ylabel('Amplitude'); legend('(surdN_{STD=0.005})-(\surdS)','(\surdN_{STD=0.01})-(\surdS)','(\surdN_{STD=0.05})-(\surdS)','(\surdN_{STD=0.1})-(\surdS)')
% subplot(3,1,2);
xlabel('Probability'); ylabel('Amplitude'); legend('(\surdN_{1}-\surdS)²','(\surdN_{2}-\surdS)²','(\surdN_{3}-\surdS)²','(\surdN_{STD=0.1}-\surdS)²')


% 
% for j = 1:length(sd)
% for i=1:700
% n = v'+sd(j)*randn(length(v),1);
% nx{j}(i,:) = sqrt((sqrt(v)'-sqrt(n)).^2);
% % nx{j}(i,:) =sqrt(n)./(n);
% end
% 
% subplot(3,1,3);plot(v,real(mean(nx{j})),[':' cl(j)]); hold on
% end
% 
% 
% % subplot(3,1,3); plot(v,sqrt(v)./(v),'k'); hold on
% subplot(3,1,3); 
% subplot(3,1,3);xlabel('Probability'); ylabel('Amplitude');legend('\surd((\surdN_{STD=0.005})-(\surdS))²','\surd((\surdN_{STD=0.01})-(\surdS))²','\surd((\surdN_{STD=0.05})-(\surdS))²','\surd((\surdN_{STD=0.01})-(\surdS))²')