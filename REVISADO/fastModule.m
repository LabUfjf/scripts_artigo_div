function [pdf,X] = fastModule(data,nPoint,h,KFUNCTION,METHOD)
Div = 2^1;
pdf=zeros(1,nPoint);
X = linspace(min(data),max(data),nPoint);
r=0;
h = ones(1,length(data))*h;
Hi =h.^2;
n=length(data);

for j=1:Div
    pdf(1,(1+(nPoint/Div)*(j-1)):(nPoint/Div)*(j))=(((1/n)*sum((repmat((1./Hi),nPoint/Div,1).*KCV(repmat((1./Hi),nPoint/Div,1).*((repmat(X((1+(nPoint/Div)*(j-1)):(nPoint/Div)*(j)),length(data),1)')-repmat(data,nPoint/Div,1)),r,h,KFUNCTION,METHOD)),2))');
end
% if doNorm == 1Hi.^(-1/2)
%     [A]= area2d(X,pdf);
%     pdf = pdf/A;
% end