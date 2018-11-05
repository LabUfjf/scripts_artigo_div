function [X,kv] = amskde(DATA,ho,nPoint)
x= DATA.sg.evt;

% x=x(1:1000);
x = sort(x);
X=linspace(min(x),max(x),nPoint);
r=1;
d=1;
n = length(x);
g = matlabFunction(-kernel_fun_der('Gaussian',r));
[X,ff] = KDEfixed(x',ho,nPoint);
fi = interp1(X,ff,x,'linear',0);
lambda=exp((length(x)^-1)*sum(log(fi(fi~=0))));
% ho=h_hunter(DATA,nPoint,'MLCV');
hi = ho*((lambda./(fi)).^(1/2));

% y(1)= (X(1)+X(2))/2;

% for j=2:1000000
%     
%     for i=1:length(x)
%         
%         A(i) = (x(i)./(hi(i).^(d+2))).*g(((y(j-1)-x(i))./hi(i)).^2);
%         B(i) = (1./(hi(i).^(d+2))).*g(((y(j-1)-x(i))./hi(i)).^2);
%         y(j) = sum(A)/sum(B);
%     end
%     
%     plot(j,y(j),'.k'); hold on
%         pause(0.01)  
% end
C=1;
for i=1:length(x)
dfk(i) = (2/n)*sum((1./(hi.^(d+2))).*g(((x(i)-x)./hi).^2))* ((sum((x./(hi.^(d+2))).*g(((x(i)-x)./hi).^2))/sum((1./(hi.^(d+2))).*g(((x(i)-x)./hi).^2)))-x(i));   
    
    fg(i)=C*(sum((fi.*(1./(hi.^d))).*g(((x-x(i))./hi).^2))/sum(fi));

end
C = 1/area2d(x,fg');
fg = C*fg;
dfk = abs(dfk);
for i = 1:length(x)

%     Mv(i) = ((ho^2)/(2/C))*(dfk(i)/fg(i));
    Mv(i)=(lambda/((n^-1)*sum(fi)))*((ho^2)/(2/C))*(dfk(i)/fg(i));
%       plot(i,Mv(i),'.k'); hold on
%         pause(0.01)  
end
Hi=Mv;
    for j=1:nPoint
        Kv(j,:)=Hi.^(-1/2).*Kn(Hi.^(-1/2).*(repmat(X(:,j),1,length(x))-x'));
    end
kv = (1/n)*sum(Kv');

% Kv = 
% 
%     plot(X,kv,'b-'); hold on
%     
% plot(x,C*fg,'.'); hold on
% plot(x,Mv,'r.')
% % plot(x,dfk,'.'); hold on
% plot(DATA.sg.pdf.truth.x,DATA.sg.pdf.truth.y,'-k')