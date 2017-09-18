% Caracterizando ruido Gamma
close all;
clear variables;
clc


% name = {'Gauss','Bimodal','Rayleigh','Logn','Gamma'};
name={'Gauss'};

[setup] = IN(1000);
[sg,~] = datasetGenSingle(setup,name{1});
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
   
for TH =linspace(100000,1000,50);  
    
[noiseGamma] = noiseADD(sg.pdf.truth.y,TH,'gamma');
d = noiseGamma-sg.pdf.truth.y;

noiseGauss = noiseADD(sg.pdf.truth.y,std(d),'normal');
std(d)
plot(sg.pdf.truth.x,noiseGauss,'.r',sg.pdf.truth.x,d,'.k')
pause
close
end


m = 0.1; %mean = lambda (pode variar para testar)
N = 1;
for i=1:length(sg.pdf.truth.y);
r(i) = poissrnd(sg.pdf.truth.y(i)*100000,N,1); %gerando sinal para testar
end

% % penew = gamrnd(alfa,beta);
% %aplicando a função proposta ('poisson contínua')
% x = 0:0.1:15;
% y = exp(x * log(m) - m - gammaln(x+1));
%       
% %comparando resultados
% figure;
% hold on;
% [a b] = hist(r, max(r)-min(r)+1);
% plot(min(r):max(r),a/N, 'o', 'MarkerFaceColor','blue');
% plot(x,y, 'or');
% 

