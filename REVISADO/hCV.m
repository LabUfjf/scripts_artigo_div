function [hmin,yy,MCV]=hCV(DATA,nPoint)
[ho]=h_hunter(DATA,[],'SV');
vh = linspace(0.01*ho,10*ho,50);
[nd,n,DADOS]= format_data(DATA.sg.evt);
DADOS = DADOS';
e = range(DADOS)/25;
wb=waitbar(0,'Aguarde...');
for i=1:n
    CV = 0;
    x = DADOS(DADOS>DADOS(i)-e & DADOS<DADOS(i)+e);
    for k = 1:length(vh);
        term=0;
        h = vh(k);
        if length(x) >5
            tic
            for j=1:length(x);
                X = linspace(min(x),max(x),nPoint);      
%                   [~,fx]=fastKDE(data,nPoint,1,2,h,'fix');
                [~,fx]=KDEfixed((x(x~=x(j))-x(j))',h,nPoint);
                term=term+sum(fx);                
            end
            toc
            [xk,yk]=KDEfixed((x(x~=x(j))-x(j))',h,nPoint);
            dx=diff(xk); dx=dx(1);
            CV(k)= sum((yk.^2)*dx)-((2/n)*term);
        else
            CV(k)=NaN;
        end
    end
    MCV(i,:)=CV;
    if isnan(CV)
        hmin(i)=NaN;
    else
        hmin(i)=vh(find(CV==min(CV)));
    end
    waitbar(i/n)
end
close(wb)
stairs(DADOS,hmin,'sk'); hold on
yy = smooth(hmin,0.05,'lowess');
plot(DADOS,yy,':r')
end
 