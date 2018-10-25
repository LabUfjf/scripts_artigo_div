function [X,f] = kernelND(DATA,nPoint,est,bin_method,h_method,type,dolambda)
% disp(['[KDE][PDF][..]']); %display de controle
%==========================================================================
% KERNEL UniDimensional UFJF
%==========================================================================
% Entradas: x: dados de Kernel N-Dimensional
%           nPoint: número de pontos do kernel
%           lambda: fator de suavização
%           optN: Binagem Ótima do Histograma via L1 Loss
%           type: (tipo de banda do KDE)
%                 - 'variable' : Kernel de Banda variável
%                 - 'fix': Kernel de Banda Fixa
%                 - 'both': Calcular os dois tipos de banda
%=========================================================
% Saídas:   Xlimit: range X do Kernel
%           f: probabilidades do Kernel
%==========================================================================
%==========================================================================
x = DATA.sg.evt;
x = x(:);
x={x'};                                 % comentar para kernel N-Dimensional, por isso não precisa ser cell
nd=length(x);                           % número de dimensões

%-------------------------------------------------------------------------%
for d=1:nd;                             % loop para preencher variáveis de cada dimensão
    n{d}=length(x{d});                  % eventos em cada dimensão
    stdv = mad(x{d});                   % desvio padrão robusto
    X{d} = linspace(min(x{d}),max(x{d}),nPoint(d));
    h{d} =h_hunter(DATA,nPoint,h_method);
    
    
    switch est
        case 'ASH'
            M = 10;
            [xest,yest] = ASHEST(DATA,bin_method);
            if dolambda ==1
                fx = interp1(xest,yest,x{d},'linear','extrap');
                lambda=exp((length(x{d})^-1)*sum(log(fx(fx~=0))));
            else
                lambda = 1;
            end
            if strcmp(type,'SSE');
                fpi{d} = interp1(xest,yest,x{d},'linear','extrap');
                [hi{d}] = hSSE(h{d},lambda,fpi{d});
            end
            if strcmp(type,'BE');
                fpk{d} = interp1(xest,yest,X{d},'linear','extrap');
                [hk{d}] = hBE(h{d},lambda,fpk{d},x{d},X{d});
            end
            
        case 'HIST'
            [xest,yest] = BINEST(DATA, bin_method);
            if dolambda ==1
                fx = interp1(xest,yest,x{d},'linear','extrap');
                lambda=exp((length(x{d})^-1)*sum(log(fx(fx~=0))));
            else
                lambda = 1;
            end
            fx = interp1(xest,yest,x{d},'linear','extrap');
            lambda=exp((length(x{d})^-1)*sum(log(fx(fx~=0))));
            
            if strcmp(type,'SSE');
                fpi{d} = interp1(xest,yest,x{d},'nearest','extrap');
                [hi{d}] = hSSE(h{d},lambda,fpi{d});
            end
            if strcmp(type,'BE');
                fpk{d} = interp1(xest,yest,X{d},'nearest','extrap');
                [hk{d}] = hBE(h{d},lambda,fpk{d},x{d},X{d});
            end
        case 'PF'
            [xest,yest] = BINEST(DATA, bin_method);
            if dolambda ==1
                fx = interp1(xest,yest,x{d},'linear','extrap');
                lambda=exp((length(x{d})^-1)*sum(log(fx(fx~=0))));
            else
                lambda = 1;
            end
            fx = interp1(xest,yest,x{d},'linear','extrap');
            lambda=exp((length(x{d})^-1)*sum(log(fx(fx~=0))));
            
            if strcmp(type,'SSE');
                fpi{d} = interp1(xest,yest,x{d},'linear','extrap');
                [hi{d}] = hSSE(h{d},lambda,fpi{d});
            end
            if strcmp(type,'BE');
                fpk{d} = interp1(xest,yest,X{d},'linear','extrap');
                [hk{d}] = hBE(h{d},lambda,fpk{d},x{d},X{d});
            end
        case 'truth'

            xest = DATA.sg.pdf.truth.x;
            yest = DATA.sg.pdf.truth.y;
            if dolambda ==1
                fx = interp1(xest,yest,x{d},'linear','extrap');
                lambda=exp((length(x{d})^-1)*sum(log(fx(fx~=0))));
            else
                lambda = 1;
            end
            fx = interp1(xest,yest,x{d},'linear','extrap');
            lambda=exp((length(x{d})^-1)*sum(log(fx(fx~=0))));
            
            if strcmp(type,'SSE');
                fpi{d} = interp1(xest,yest,x{d},'linear','extrap');
                [hi{d}] = hSSE(h{d},lambda,fpi{d});
            end
            if strcmp(type,'BE');
                fpk{d} = interp1(xest,yest,X{d},'linear','extrap');
                [hk{d}] = hBE(h{d},lambda,fpk{d},x{d},X{d});
            end
    end
end
%==========================================================================
% Transformando parâmetros em matriz
%==========================================================================
x=cell2mat(x);
X=cell2mat(X');
n = cell2mat(n);

if strcmp(type,'SSE');
    [Hi,~] = h_adjust(hi,[],nd);
else
    [~,Hk] = h_adjust([],hk,nd);
end

%==========================================================================
% Construindo o KDE
%==========================================================================

switch type
    case 'fix'
        [X,f] = KDEfixed(x,X,H,nPoint,n,nd);
    case 'SSE'
        [X,f] = KDESSE(x,X,Hi,nPoint,n,nd);
    case 'BE'
        [X,f] = KDEBE(x,X,Hk,nPoint,n,nd);
end
