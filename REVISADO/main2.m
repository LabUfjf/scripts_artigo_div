%% Main of the FastKDE Analysis
clear variables;
close all;
clc
%% Parameters
n=10^4;         % Number of events
m=1000;         % Number of estimation points
div=2^1;          % Number of matrix divisions
d=1;            % Number of dimensions
f=1;            % Smoothness Parameter (Keep it that way)
% Distribuition Parameters
mu=0;
sigma=0.25;
% X=[-1:0.01:1];
% Y = normpdf(X,mu,sigma);
% A=randn(n,d);
% xgrid=linspace(min(A),max(A),m);

%% FLAGS PLOTS
plot.hist=0;

%-------------------------------------------------------------------------%
%% PreAllocation
kk=10;
Fvtime=zeros(1,kk);

vectorD=[1 2 4 5 8 10 20 25 40 50 100];
vectorN=[10 100 500 1000 10000 25000 50000 75000 100000 150000 200000];

matrix=zeros(length(vectorN),length(vectorD));
matrixe=zeros(length(vectorN),length(vectorD));
%-------------------------------------------------------------------------%

aux1=0;
for j=vectorN
    aux1=aux1+1;
    aux2=0;
%     n=10^j;
    %% Random Gaussian Distribuition
    A = normrnd(mu,sigma,j,d);
    
    for div=vectorD
        aux2=aux2+1;
        for i=1:kk
            tic
            [~,~]=fastKDE(A,m,f,(div),'variable');      % Our Implementation Fast
            Fvtime(i)=toc;
        end
        matrix(aux1,aux2)=mean(Fvtime);
        matrixe(aux1,aux2)=std(Fvtime)/kk;
    end
end

% vector_div=[2^0 2^1 2^2 2^3 2^4 2^5 2^6 2^7];
% vector_n=[10^1 10^2 10^3 10^4 10^5];
figure
surf(vectorN,vectorD,matrix')
xlabel('Number of Events')
ylabel('Number of divisions')
zlabel('Time(seconds)')
legend show
axis tight
grid on

