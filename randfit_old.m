function [out,pdf] = randfit_old(x,y,n)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%            Fun��o para gerar dados � partir da PDF anal�tica 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENTRADA :  f = fun��o anal�tica (cfit)
%            n = n�mero de eventos que desejamos gerar 
%            range = m�nimo e m�ximo valores da fun��o anal�tica, ex: [-1 1]
%            pts = n�mero de pontos que desejamos discretizar a fun��o
%            anal�tica
%--------------------------------------------------------------------------
% SA�DA :    out = eventos gerados obedecendo a fun��o anal�tica
%            pdf = pdf discreta gerada a partir da anal�tica
%--------------------------------------------------------------------------
% EXEMPLO: data = [randn(1,1000) 3+0.5*randn(1,1000) 5+0.25*randn(1,1000)];
%          bin = 500;
%          [y,x]=hist(data,bin);
%          f=fit(x',y','gauss3');
%          [X,pdf] = randfit(f,10000,[min(data) max(data)],2000)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% GERAR PDF NUM�RICA
% criar range
% pdf.x = linspace(range(1),range(2),pts)';
% aplicar na fun��o anal�tica
% pdf.y = f(pdf.x);
pdf.x = x;
pdf.y = y;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% NORMALIZAR PDF
% pela �rea
A = area2d(pdf.x,pdf.y);
pdfnorm = pdf.y/A;
% pela soma das probabilidades
% DIV = sum(pdf.y);
pdf1 = pdf.y/sum(pdf.y);
% figure
% plot(pdf.x,pdf.y)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% C�LCULAR CDF
cdf = cumsum(pdf1);

% Selecionar valores �nicos para n�o dar erro na interpola��o
[~, mask] = unique(cdf);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% GERAR DADOS UNIFORMES
data_uniform = rand(1, n);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CRIAR A PROJE��O DOS DADOS NA CDF
% plot(pdf.x(mask), max(pdfnorm)*cdf(mask),':b')
% pause
out = interp1(cdf(mask), pdf.x(mask), data_uniform,'nearest','extrap');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pdf.y = pdfnorm;
end

function [ area ] = area2d( x,y )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%tbin=abs((x(2)-x(1)));
tbin=min(diff(x));
%area=trapz(x,y);
area=sum(abs(y))*tbin;

end


