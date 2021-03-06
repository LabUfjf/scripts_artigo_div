function [out,pdf] = randfit(X,Y)
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
pdf.x = X;
pdf.y = Y;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% NORMALIZAR PDF
% pela �rea
A = area2d_new(pdf.x,pdf.y);
pdfnorm = pdf.y./repmat(A,size(pdf.y,1),1);
% pela soma das probabilidades
% DIV = sum(pdf.y);
pdf1 = pdf.y./repmat(sum(pdf.y),size(pdf.y,1),1);
% figure
% plot(pdf.x,pdf.y)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% C�LCULAR CDF
cdf = cumsum(pdf1);

% cdf(mask) = NaN;
% X(mask) = NaN;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% GERAR DADOS UNIFORMES
n =size(Y,2);
data_uniform = rand(1,n);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CRIAR A PROJE��O DOS DADOS NA CDF
% plot(pdf.x(mask), max(pdfnorm)*cdf(mask),':b')
% pause

% plot(pdf.x,cdf)
% ind = reshape(1:n,1,n/1);
% tic
for i=1:n
    [~, mask] = unique(cdf(:,i));
    out(i) = interp1(cdf(mask,i), pdf.x(mask,i), data_uniform(i),'nearest','extrap');
end
% toc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pdf.y = pdfnorm;
end

function [ A ] = area2d_new( X,Y )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%tbin=abs((x(2)-x(1)));
tbin=min(diff(X)); tbin = tbin(1);
%area=trapz(x,y);
A=sum(abs(Y))*tbin;

end


