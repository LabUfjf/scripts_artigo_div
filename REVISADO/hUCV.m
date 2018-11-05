function [X,fv,hcv]=hUCV(DATA,ho,nPoint)

% [ho]=h_hunter(DATA,[],'MLCV');

[X,ff] = KDEfixed(DATA.sg.evt',ho,nPoint);
fi = interp1(X,ff,DATA.sg.evt','linear',0);
% ylambda=exp((length(DATA.sg.evt')^-1)*sum(log(fi(fi~=0))));
% ho=h_hunter(DATA,nPoint,'MLCV');
% hi = ho*((lambda./(fi)).^(1/2));



vh = linspace(0.01*ho,2*ho,100);
[~,n,DADOS]= format_data(DATA.sg.evt);

type = 'Gaussian';

syms u
r=0;
[dk] = kernel_fun_der(type,r);
[d2k] = kernel_fun_der(type,2*r);
cK = kernel_fun_conv(type,r);
Rdk = Rg(dk);
FUCV = matlabFunction(cK-2*d2k);

D=nPoint;
e = range(DADOS)/5 ;
Xdiv = linspace(min(DADOS),max(DADOS),D+1);
d = diff(Xdiv); d=d(1)/2;
xdiv = Xdiv(1:end-1)+d;
wb=waitbar(0,'Aguarde...');
 vh = linspace(0.01*ho,4*ho,100);
for div = 1:D
    %     x = DADOS(DADOS>DADOS(div)-e & DADOS<DADOS(div)+e);
    x = DADOS(DADOS>xdiv(div)-e & DADOS<xdiv(div)+e);
%     Hi = hi(DADOS>xdiv(div)-e & DADOS<xdiv(div)+e);
%     vh = linspace(0.01*min(hi),20*max(hi),100);
    % [F] = fastM(x);
%     x
%     pause
    term = 0;
     for k=1:length(vh)
        h=vh(k);
        term = 0;
        if length(x)>5
        for i=1:length(x)
            term=term+mean(FUCV((x(x~=x(i))-x(i))/h));
            %         term=sum(mean(FUCV(F)));
        end;
        %     CV(div,k)=(Rdk*(1/(n*h^((2*r)+1))))+((-1)^r / ((n-1)*h^((2*r)+1)))*sum(mean(FUCV((F/h))'));
        CV(k)=(Rdk*(1/(n*h^((2*r)+1))))+((-1)^r / ((n-1)*h^((2*r)+1)))*term;
        else
        CV(k) = NaN;
        end
    %         CV
    %         pause(0.05)
     end
    if isnan(CV)
    hmin(div)=NaN;
    else
    hmin(div)=vh(find(CV==min(CV),1));
    end
    waitbar(div/D)
end
hmin=hmin(~isnan(hmin));
xdiv=xdiv(~isnan(hmin));
close(wb)
hcv.local=interp1(xdiv,hmin,DADOS,'nearest','extrap');
hcv.smooth= interp1(xdiv,hmin,DADOS,'linear','extrap');
hcv.local(find(hcv.local<=0)) = min(hcv.local(find(hcv.local>0)));
hcv.smooth(find(hcv.smooth<=0)) = min(hcv.smooth(find(hcv.smooth>0)));
% plot(vh,CV); hold on
% pause(0.05)
% end
hi = {hcv.smooth};
[X,fv.smooth] = KDESSE(DADOS,hi,100);
hi = {hcv.local};
[X,fv.local] = KDESSE(DADOS,hi,100);
% figure
% plot(X,fv,'.k'); hold on
% plot(DADOS,hcv.smooth,'or')
% plot(DADOS,hcv.local,'.b')
%    plot(DATA.sg.pdf.truth.x,DATA.sg.pdf.truth.y,'g')
% plot(xdiv,hmin,'sk')
% Hi=hmin;
% x=DADOS;
% X = linspace(min(x),max(x),n);
%     for j=1:length(X)
%         Kv(j,:)=Hi.^(-1/2).*Kn(Hi.^(-1/2).*(repmat(X(:,j),1,length(x))-x));
%     end
% kv = (1/n)*sum(Kv');
% % plot(vh,CV)
% figure
%
% plot(DADOS,hmin,'.'); hold on
%          
% plot(X,kv,'-r')

