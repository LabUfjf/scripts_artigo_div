function [X,pdf] = fastKDE(data,nPoint,f,Div,h,type)

%% fastKDE Compute kernel density or distribution estimate using matricial
%%           way

%  [X,pdf]=fastKDE(data,nPoint,f,Div) computes a probability density estimate
%   of the sample in the vector of lines 'data'.  fastKDE evaluates the density
%   estimate at 'nPoints' points covering the range of the data.  'pdf' is
%   the vector of density values and 'X' is the grid of the 'nPoints' points.
%   'Div' is the number of times that the matrix is divided to reduce the
%   RAM effort.
%   The estimate is based on a normal kernel function, using a window parameter
%   (bandwidth) that is a function of the number of points in X.
%
%  [X,pdf]=fastKDE(data,nPoint,f,Div) If 'data' is a nx2 matrix the function
%  computes a 2D probability density estimate of the sample.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% l=1;
doNorm = 0;

[nd,n,data]= format_data(data);

%-------------------------------------------------------------------------%
%% PreAllocation
X=zeros(nd,nPoint);
% h=zeros(1,nd);

%-------------------------------------------------------------------------%

if nd ==1
%     [hist_pdf,Xedges,~] = histcounts(data,'Normalization', 'pdf','BinMethod','fd');
%     xh = (Xedges(1:end-1) + Xedges(2:end))/2;
    M=10;
    [BIN.rudemo] = calcnbins(data, 'rudemo');
    [xh,hist_pdf] = ashN(data,M,'linear',BIN.rudemo);
%     ds = diff(xh); ds=ds/2;
%     xh = xh(1:end-1)+ds;
    
%       xh = (xh(1:end-1) + xh(2:end))/2;
    
    proby=interp1(xh(hist_pdf~=0),hist_pdf(hist_pdf~=0),data,'linear','extrap');           %cálculo das probabilidades dos eventos de kernel
    lambda=exp((length(data)^-1)*sum(log(proby(proby~=0)))); %calculo do lambda otimo pela teoria do paper
    X = linspace(min(data),max(data),nPoint); %range X do kernel
    probky=interp1(xh(hist_pdf~=0),hist_pdf(hist_pdf~=0),X,'linear','extrap');
else
    [hist_pdf,Xedges,Yedges,~] = histcounts2(data(1,:),data(2,:),'Normalization', 'pdf','BinMethod','fd');
    xh = (Xedges(1:end-1) + Xedges(2:end))/2;
    yh = (Yedges(1:end-1) + Yedges(2:end))/2;
    proby=interp2(xh,yh,hist_pdf',data(1,:),data(2,:),'linear',min(min(hist_pdf(hist_pdf>0))));           %cálculo das probabilidades dos eventos de kernel
    lambda=exp((length(data)^-1)*sum(log(proby(proby~=0)))); %calculo do lambda otimo pela teoria do paper
    for i=1:nd
        h(i) =((4/(nd+2))^(1/(nd+4)))*std(data(i,:))*n^(-1/(nd+4)); % cálculo do h("rule-of-thumb") ótimo pelo AMISE
        X(i,:) = linspace(min(data(i,:)),max(data(i,:)),nPoint); %range X do kernel
    end
end

h=h*f;

switch type
    case 'fix'
        for d=1:nd;
            h = ones(1,length(data))*h;
            Hi =h.^2;
        end
    case 'sse'
        [hi] = hihj(h,lambda,proby,n);         % cálculo da banda variável
        Hi =hi.^2;
    case 'be'
        [hk] = hkfct(h,lambda,probky,nPoint);
        Hk =hk.^2;
    otherwise
        disp('Kernel Bandwidth not selected')
end


%==========================================================================
% Fazendo os Cálculos do KERNEL ND de banda Fixa e Variável
%==========================================================================
if nd ==1
    %% Dimensões = 1
    %     if length(data)>=69998
    pdf=zeros(1,nPoint);
    for j=1:Div
        if strcmp(type,'be')
            ind = (1+(nPoint/Div)*(j-1)):(nPoint/Div)*(j);
            pdf(1,ind)=(((1/n)*sum((repmat((Hk(ind).^(-1/2))',1,n).*Kn(repmat((Hk(ind).^(-1/2))',1,n).*((repmat(X(ind),length(data),1)')-repmat(data,nPoint/Div,1)))),2))');
        else
            pdf(1,(1+(nPoint/Div)*(j-1)):(nPoint/Div)*(j))=(((1/n)*sum((repmat((Hi.^(-1/2)),nPoint/Div,1).*Kn(repmat((Hi.^(-1/2)),nPoint/Div,1).*((repmat(X((1+(nPoint/Div)*(j-1)):(nPoint/Div)*(j)),length(data),1)')-repmat(data,nPoint/Div,1)))),2))');
        end
    end
    
    if doNorm == 1
        [A]= area2d(X,pdf);
        pdf = pdf/A;
    end
else
    
    pdf=zeros(nPoint,nPoint);
    for jj=1:Div
        
        for kk=1:Div
            MH1= repmat((Hi(1,:).^(-1/2)),nPoint/Div,1);
            MH2= repmat((Hi(2,:).^(-1/2)),nPoint/Div,1);
            MD1 = repmat(data(1,:),nPoint/Div,1);
            MD2 = repmat(data(2,:),nPoint/Div,1);
            MX1=repmat(X(1,((1+(nPoint/Div)*(jj-1)):(nPoint/Div)*(jj))),length(data(1,:)),1)';
            MX2=repmat(X(2,((1+(nPoint/Div)*(kk-1)):(nPoint/Div)*(kk))),length(data(2,:)),1)';
            
            pdf(((1+(nPoint/Div)*(jj-1)):(nPoint/Div)*(jj)),((1+(nPoint/Div)*(kk-1)):(nPoint/Div)*(kk)))=((1/n)*(MH1.*Kn(MH1.*(MX1-MD1)))*(MH2.*Kn(MH2.*(MX2-MD2)))')';
        end
        
    end
    if doNorm == 1
        [V]= volume_pts(X(1,:),X(2,:),pdf,nPoint);
        pdf = pdf/V;
    end
    
end

clearvars -except X pdf

end


function [nd,n,data]= format_data(data)

[nd,n] = size(data);

if nd>n
    data = data';
    [nd,n] = size(data);
end

end

function [hi] = hihj(h,lambda,fpi,n)
for i=1:n
    hi(i)=abs((h).*(sqrt(lambda./fpi(i))));
%         hi(:,i)=abs((h).*(sqrt(1./fpi(i))));
end
end


function [hk] = hkfct(h,lambda,fpk,nPoint)
for i=1:nPoint
    hk(i)=abs((h).*(sqrt(lambda./fpk(i))));
%     hk(i)=abs((h)./(sqrt(fpk(i))));
end
end

function [K]=Kn(u)
K=((2*pi)^(-1/2))*exp((-(u.^2)/2)); %Gaussian
end

function [ area ] = area2d(x,y)
tbin=min(diff(x));
area=sum(abs(y))*tbin;
end

function [V]= volume_pts(x,y,z,pts)

xgrid = min(x):range(x)/pts:max(x);
ygrid = min(y):range(y)/pts:max(y);

h = waitbar(0,'Remaking GRID points');
zgrid=zeros(length(xgrid),1);
for i=1:length(xgrid)
    zgrid(i,:)= interp2(x,y,z,xgrid(i),ygrid,'linear');
    waitbar(i/length(xgrid))
end
close(h)
dx=min(diff(xgrid));
dy=min(diff(ygrid));
V=sum(sum(dx*dy*zgrid));
end
