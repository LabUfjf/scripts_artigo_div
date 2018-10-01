%% Main of the FastKDE Analysis
clear variables;
close all;
clc
%% Parameters
n=10^4;         % Number of events
m=2^9;         % Number of estimation points
div=2^1;          % Number of matrix divisions
d=1;            % Number of dimensions
f=1;            % Smoothness Parameter (Keep it that way)
type='fix';
% Distribuition Parameters
mu=0;
sigma=0.25;
X=[-1:0.01:1];
Y = normpdf(X,mu,sigma);
%% Random Gaussian Distribuition
A = normrnd(mu,sigma,n,d);
% A=randn(n,d);
% xgrid=linspace(min(A),max(A),m);

%% FLAGS PLOTS
plot.hist=0;

%-------------------------------------------------------------------------%
%% PreAllocation
kk=10;
Lvtime=zeros(1,kk);
Lftime=zeros(1,kk);
Fftime=zeros(1,kk);
Fvtime=zeros(1,kk);
Mtime=zeros(1,kk);
Ktime=zeros(1,kk);
aKtime=zeros(1,kk);
kde2time=zeros(1,kk);
%-------------------------------------------------------------------------%


if(d==1)
    for i=1:kk
        % Not Matricial
        tic
        [x2v,p2v]=KDE_opt(A,m,f,'variable');                   % Our Implementation
        Lvtime(i)=toc;
        
        tic
        [x2f,p2f]=KDE_opt(A,m,f,'fix');                   % Our Implementation
        Lftime(i)=toc;
        
        tic
        [x1f,pdf1f]=fastKDE(A,m,f,div,'fix');      % Our Implementation Fast
        Fftime(i)=toc;
        
        tic
        [x1v,pdf1v]=fastKDE(A,m,f,div,'variable');      % Our Implementation Fast
        Fvtime(i)=toc;
        
        tic
        [pdf2,x2] = ksdensity(A,'npoints',m);        % Matlab Implementation
        Mtime(i)=toc;
        
        tic
        [~,pdf3,x3,~]=kde(A,m,min(A),max(A));
        Ktime(i)=toc;
        
        tic
        [pdf4,x4]=akde1d(A,m);
        aKtime(i)=toc;
        
    end
    
    figure
    semilogy(1:kk,Lftime,'sr','DisplayName','KDEf')
    hold on
    semilogy(1:kk,Lvtime,'sg','DisplayName','KDEv')
    semilogy(1:kk,Fftime,'*r','DisplayName','FastKDEf')
    semilogy(1:kk,Fvtime,'*g','DisplayName','FastKDEv')
    semilogy(1:kk,Mtime,'ob','DisplayName','Ksdensity')
    semilogy(1:kk,Ktime,'om','DisplayName','KDE')
    semilogy(1:kk,aKtime,'oc','DisplayName','aKDE')
    xlabel('Attempts')
    ylabel('Time(seconds)')
    legend show
    axis tight
    grid on
else
    for i=1:kk
        tic
        [x1f,pdf1f]=fastKDE(A,m,f,div,'variable');      % Our Implementation Fast
        Fftime(i)=toc;
        
        tic
        [~,density,xpdf,ypdf]=kde2d(A,m);
        kde2time(i)=toc;
    end
    
    figure
    semilogy(1:kk,Fftime,'*r','DisplayName','FastKDEf')
    hold on
    semilogy(1:kk,kde2time,'*g','DisplayName','Kde2')
    xlabel('Attempts')
    ylabel('Time(seconds)')
    legend show
    axis tight
    grid on
    
end
% display('--------------------------------------');
% display('Our Implementation:');
% display(['KDE Fix Time: ' num2str(Lftime)]);
% display(['KDE Variable Time: ' num2str(Lvtime)]);
% display('-------');
% display(['FastKDE Fix Time: ' num2str(Fftime)]);
% display(['FastKDE Variable Time: ' num2str(Fvtime)]);
% display('--------------------------------------');
% display('Others Implementations:');
% display(['Ksdensity Time: ' num2str(Mtime)]);
% display(['KDE Time: ' num2str(Ktime)]);
% display(['aKDE Time: ' num2str(aKtime)]);

if plot.hist==1
    figure
    plot(X,Y,'k','DisplayName','Analytic PDF')
    hold on
    plot(x2f{1},p2f,'sr','DisplayName','KDEf')
    plot(x2v{1},p2v,'sg','DisplayName','KDEv')
    plot(x1f,pdf1f,'*r','DisplayName','FastKDEf')
    plot(x1v,pdf1v,'*g','DisplayName','FastKDEv')
    plot(x2,pdf2,'ob','DisplayName','Ksdensity')
    plot(x3,pdf3,'om','DisplayName','KDE')
    plot(x4,pdf4,'oc','DisplayName','aKDE')
    legend show
    axis tight
end