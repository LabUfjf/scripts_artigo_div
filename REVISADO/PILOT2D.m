function [fpi,hi,fpk,hk] = PILOT2D(DATA,nPoint,est,bin_method,h_method,type)
dolambda = 1;
x = DATA.sg.evt;
ho =h_hunter(DATA,nPoint,0,h_method);
for d=1:nd;                             % loop para preencher variáveis de cada dimensão
    n{d}=length(x(:,d));                  % eventos em cada dimensão
    stdv = mad(x(:,d));                   % desvio padrão robusto
    X{d} = linspace(min(x(:,d)),max(x(:,d)),nPoint(d));
    h{d} =ho(d);
    
    
    switch est
        case 'ASH'
            M = 10;
            [xest,yest,zest] = ash2D(x,10,'linear');
%             [xest,yest] = ASHEST(DATA,bin_method);

            
        case 'HIST'
            [xest,yest] = BINEST(DATA, bin_method);
            if dolambda ==1
                fx = interp1(xest,yest,x(:,d),'linear','extrap');
                lambda=exp((length(x(:,d))^-1)*sum(log(fx(fx~=0))));
            else
                lambda = 1;
            end
            fx = interp1(xest,yest,x(:,d),'linear','extrap');
            lambda=exp((length(x(:,d))^-1)*sum(log(fx(fx~=0))));
            
            if strcmp(type,'SSE');
                fpi{d} = interp1(xest,yest,x(:,d),'nearest','extrap');
                [hi{d}] = hSSE(h{d},lambda,fpi{d});
            end
            if strcmp(type,'BE');
                fpk{d} = interp1(xest,yest,x(:,d),'nearest','extrap');
                [hk{d}] = hBE(h{d},lambda,fpk{d},x(:,d),x(:,d));
            end
        case 'PF'
            [xest,yest] = BINEST(DATA, bin_method);
            if dolambda ==1
                fx = interp1(xest,yest,x(:,d),'linear','extrap');
                lambda=exp((length(x(:,d))^-1)*sum(log(fx(fx~=0))));
            else
                lambda = 1;
            end
            fx = interp1(xest,yest,x(:,d),'linear','extrap');
            lambda=exp((length(x(:,d))^-1)*sum(log(fx(fx~=0))));
            
            if strcmp(type,'SSE');
                fpi{d} = interp1(xest,yest,x(:,d),'linear','extrap');
                [hi{d}] = hSSE(h{d},lambda,fpi{d});
            end
            if strcmp(type,'BE');
                fpk{d} = interp1(xest,yest,x(:,d),'linear','extrap');
                [hk{d}] = hBE(h{d},lambda,fpk{d},x(:,d),x(:,d));
            end
        case 'truth'
            
            xest = DATA.sg.pdf.truth.x;
            yest = DATA.sg.pdf.truth.y;
            if dolambda ==1
                fx = interp1(xest,yest,x(:,d),'linear','extrap');
                lambda=exp((length(x(:,d))^-1)*sum(log(fx(fx~=0))));
            else
                lambda = 1;
            end
            fx = interp1(xest,yest,x(:,d),'linear','extrap');
            lambda=exp((length(x(:,d))^-1)*sum(log(fx(fx~=0))));
            
            if strcmp(type,'SSE');
                fpi{d} = interp1(xest,yest,x(:,d),'linear','extrap');
                [hi{d}] = hSSE(h{d},lambda,fpi{d});
            end
            if strcmp(type,'BE');
                fpk{d} = interp1(xest,yest,x(:,d),'linear','extrap');
                [hk{d}] = hBE(h{d},lambda,fpk{d},x(:,d),x(:,d));
            end
    end
end