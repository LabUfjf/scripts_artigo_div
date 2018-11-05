load carsmall Weight
% histogram plus density with default bandwidth
a1 = subplot(2,1,1);
[ff,xx] = ecdf(Weight);
ecdfhist(ff,xx);
a = findobj(gca,'type','patch');
set(a(end),'facecolor',[.9 .9 1])
[f0,x0,u] = ksdensity(Weight);
line(x0,f0,'color','b')
% try other bandwidths
uu = linspace(u/10,10*u,5);
subplot(2,2,3);
v = zeros(size(uu));
n=length(Weight);
% using same partition each time reduces variation 
cp = cvpartition(length(Weight),'LeaveOut');
for j=1:length(uu)
      % compute log likelihood for test data based on training data
      loglik = @(xtr,xte) (n^(-1))*sum(log(ksdensity(xtr,xte,'width',uu(j))));
      % sum across all train/test partitions
      v(j) = sum(crossval(loglik,Weight,'partition',cp));
      % plot the fit to the full dataset
      [f,xi] = ksdensity(Weight,'width',uu(j));
      h(j) = line(xi,f,'color',[.75 .75 .75]); 
end 
% find and highlight the one that appears best 
[maxv,maxi] = max(v); 
set(h(maxi),'linewidth',2,'color','r');
h0 = line(x0,f0,'color','b','linewidth',2);
title('Kernel smooth variation with bandwidth') 
legend([h0 h(maxi)],'Default','Highest log-lik')
% show the cross-validation values (sum of log likelihoods)
subplot(2,2,4)
plot(uu,v,'b-',uu(maxi),v(maxi),'ro')
title('Cross-validated log likelihood vs. bandwidth')
% add it to the histogram display
[f,x] = ksdensity(Weight,'width',uu(maxi));
line(x,f,'color','r','parent',a1)
legend(a1,'Histogram','Default','Cross-validated')
title(a1,'Histogram and two kernel-smooth estimates')