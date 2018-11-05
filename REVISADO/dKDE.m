function [X,df] = dKDE(DATA,h,r,nPoint)

x = DATA.sg.evt;
type = 'Gaussian';
[dk] = matlabFunction(kernel_fun_der(type,r));

X=linspace(min(x),max(x),nPoint);
n = length(x);
nd = 1;

for j=1:nPoint
    df(j,:)=(1/(n*h^(r+1)))*sum(dk((repmat(X(:,j),1,length(x))-x)/h));
end

h = diff(DATA.sg.pdf.truth.x); h=h(1);
dy=diff(DATA.sg.pdf.truth.y,r)/h;
% 
% plot(DATA.sg.pdf.truth.x(1:end-r),dy,'-k'); hold on
% plot(X,df,':r')