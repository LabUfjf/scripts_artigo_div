

load([pwd '\TRUTH\TEST_ERROR\VEC_ERROR[normal]PDF[Gaussian]METHOD[full]INTERP[linear].mat'])
errorbar(V.noise,V.mean,V.std); hold on
% cftool(V.noise,V.mean)

plot(fit_norm,V.noise,V.mean,'.k');
grid on; axis tight
set(gca,'gridlinestyle',':')
str =  [{'Linear model Poly1:'}
    {'fit(x) = p1*x + p2'}
    {'where x is normalized by mean 0.05 and std 0.02891'}
    {'Coefficients (with 95% confidence bounds):'}
    {'p1 =     0.05811  (0.05808, 0.05813)'}
    {'p2 =      0.1005  (0.1005, 0.1005)'}];
annotation('textbox','String',str,'FontSize',8)
legend('Data','Fit')
ylabel('Area')
xlabel('Variance*Peak')


% load([pwd '\TRUTH\TEST_ERROR\VEC_ERROR[poisson]PDF[Gaussian]METHOD[full]INTERP[linear].mat'])
% % cftool(V.noise,V.mean)
% plot(fit_poisson,V.noise,V.mean,'.k');
% grid on; axis tight
% set(gca,'gridlinestyle',':')
% str =  [{'General model Power1:'}
%     {'fit_poisson(x) = a*x^b'}
%     {'Coefficients (with 95% confidence bounds):'}
%     {'a =       16.02  (15.99, 16.05)'}
%     {'b =     -0.4987  (-0.4988, -0.4985)'}];
% annotation('textbox','String',str,'FontSize',8)
% legend('Data','Fit')
% ylabel('Area')
% xlabel('Events')

%
load([pwd '\TRUTH\TEST_ERROR\fit_norm.mat'])
load([pwd '\TRUTH\TEST_ERROR\fit_poisson.mat'])

rnoise_normal = linspace(0,0.1,1000);
rnoise_poisson = linspace(10000000,10000,1000);

plot(rnoise_normal,fit_norm(rnoise_normal))

i=0;
for rf=linspace(0.01,0.1,100)
i=i+1;
    f.norm(i)=interp1(fit_norm(rnoise_normal),rnoise_normal,rf,'linear','extrap');
    f.poisson(i)=interp1(fit_poisson(rnoise_poisson),rnoise_poisson,rf,'linear','extrap');
end

plot(f.norm)
plot(f.poisson)