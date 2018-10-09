%% EXAMPLE 1: WIND SPEED DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Load the data and extract the windspeeds of interest.
load windspeed
x1 = double(windspeed.h10);                 %-Speeds at the lowest height.
x2 = double(windspeed.h128);                %-Speeds at the greatest height.
n = 57;                                     %-Sample size.

%-Create and position the figure.
figure(1)                                  
set(gcf,'Units','pixels','Position',[100 100 800 400])

%Plot the original density estimates.
h1 = SJbandwidth(x1);                       %-Bandwidth to use for x1.
h2 = SJbandwidth(x2);                       %-Bandwidth to use for x2.
[f1 g1] = bkde(x1,h1,250);
[f2 g2] = bkde(x2,h2,250);
plot(g1,f1,'k-');
hold on
plot(g2,f2,'k--');

%Set up the constraint and find the sharpened estimate based on x1.
confun1 = @(y) isuni(bkde(y,h1,250));
v1 = g1(find(f1==max(f1),1,'first'))*ones(n,1);
y1 = improve(v1,x1,confun1);

%Set up the constraint and find the sharpened estimate based on x2.
confun2 = @(y) isuni(bkde(y,h2,250));
v2 = g2(find(f2==max(f2),1,'first'))*ones(n,1);
y2 = improve(v2,x2,confun2);

%Plot the sharpened estimates and finalize the plot.
[f1u g1u] = bkde(y1,h1,250);
[f2u g2u] = bkde(y2,h2,250);
plot(g1u,f1u,'k-','linewidth',2)
plot(g2u,f2u,'k--','linewidth',2)
xlabel('Speed')
ylabel('f(speed)')


%% EXAMPLE 2: KIDNEY DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--Load the dataset and calculate its function values---------------------------
load kidney
X = double(kidney(:,:));                %-The 102-by-2 data matrix.
n = 102;
m = 100;                                %-Fcn values calc'd on m-by-m grid.
hscale = 0.9;                           %-Bandwidith: use a fraction of the 
h = hscale*std(X)*n^(-1/6);             % normal-reference value.
minx = min(X,[],1)-h;                   %-Lower bounds for plotting.
maxx = max(X,[],1)+h;                   %-Upper bounds for plotting.
                                       %-Create the plotting grid.
[G1 G2] = meshgrid(linspace(minx(1),maxx(1),m),linspace(minx(2),maxx(2),m));
M = struct('X1',G1,'X2',G2);
f0 = bkde2D(X,h,M);                      %-Calculate unsharpened function vals.

%--Calculate the sharpened results for two cases--------------------------------
% First, just use unimodal constraint (only one mode, no anti-modes); then, add
% the constraint that all marginals must be unimodal.

%%%Set up initial guess for sharpening (all pts at highest mode)
[tf locmax] = isuni2D(f0);
G1maxes = G1(locmax);
G2maxes = G2(locmax);
best = find(f0(locmax)==max(f0(locmax)),1,'first');
Y0 = repmat([G1maxes(best) G2maxes(best)],[n 1]);
%%%

confun1 = @(X) isuni2D(bkde2D(X,h,M),'onemax','nomin');
Y1 = improve(Y0,X,confun1,'verbose',true);
f1 = bkde2D(Y1,h,M);

confun2 = @(X) isuni2D(bkde2D(X,h,M),'onemax','nomin','conditionals');
Y2 = improve(Y0,X,confun2,'verbose',true);
f2 = bkde2D(Y2,h,M);

%--Create the figure------------------------------------------------------------
NC = 20;                                %-Number of contours to draw.
fig2D = figure(6);
clf
set(fig2D,'Units','inches','Position',[1 1 6 2.5])

%%%Plot the unsharpened KDE; also plot the data and the mode locations.
subplot(1,3,1)
    contourf(G1,G2,f0,NC)
    hold on
    plot(X(:,1),X(:,2),'ko','markersize',1,'markerfacecolor','k')
    title('Unsharpened','FontSize',8);
    xlabel('Birth Weight (kg)','FontSize',8)
    ylabel('Kidney Length (mm)','FontSize',8)
    set(gca,'XTickLabel',[2 3 4 5],'FontSize',8)
    set(gca,'Units','inches','Position',[0.2 0.4 1.8 1.8])
%%%

%%%Plot the sharpened KDE with unimodality constraint. Also show sharpened
%data points with lines indicating movement.
subplot(1,3,2)
    contourf(G1,G2,f1,NC)
    hold on
    plot(X(:,1),X(:,2),'ko','markersize',1,'markerfacecolor','k')
    for i = 1:n
        if ~all(Y1(i,:)==X(i,:))
            plot([X(i,1) Y1(i,1)],[X(i,2) Y1(i,2)],'k-','linewidth',1) 
            plot(Y1(i,1),Y1(i,2),'ko','markersize',1.5,'markerfacecolor','w');
        end
    end
    set(gca,'YTickLabel','')
    title('Unimodal','FontSize',8);
    xlabel('Birth Weight (kg)','FontSize',8)
    set(gca,'XTickLabel',[2 3 4 5],'FontSize',8)
    set(gca,'Units','inches','Position',[2.15 0.4 1.8 1.8])
%%%

%%%Plot the sharpened KDE with unimodal conditionals.
subplot(1,3,3);
    contourf(G1,G2,f2,NC)
    hold on
    plot(X(:,1),X(:,2),'ko','markersize',1,'markerfacecolor','k')
    for i = 1:n
        if ~all(Y2(i,:)==X(i,:))
            plot([X(i,1) Y2(i,1)],[X(i,2) Y2(i,2)],'k-','linewidth',1);
            plot(Y2(i,1),Y2(i,2),'ko','markersize',1.5,'markerfacecolor','w');
        end
    end
    set(gca,'YTickLabel','')
    title('Unimodal Conditionals','FontSize',8);
    xlabel('Birth Weight (kg)','FontSize',8)
    set(gca,'XTickLabel',[2 3 4 5],'FontSize',8)
    set(gca,'Units','inches','Position',[4.15 0.4 1.8 1.8])
%%%

linkaxes
CM = colormap('gray');
CM = 0.5*CM;
CM = (1-CM);
colormap(CM)




























































