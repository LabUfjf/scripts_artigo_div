% Function file: [H, P, h] = bootmode (x, m, B)
%
% This function tests whether the distribution underlying the univariate
% data in vector x has m modes. The method employs the smooth bootstrap
% as described [1].
%
% The parsimonious approach is to consider a successively increasing
% number of modes until the null hypothesis (H0) is accepted (i.e. H=0),
% where H0 corresponds to the number of modes being equal to m.
%
% x is the vector of data
%
% m is the number of modes for hypothesis testing
%
% B is the number of bootstrap replicates
%
% H=0 indicates that the null hypothesis cannot be rejected at the 5%
% significance level.  H=1 indicates that the null hypothesis can be
% rejected at the 5% level.
%
% P is the achieved significance level using the bootstrap test.
%
% h is the critical bandwidth (i.e. the smallest bandwidth achievable to
% obtain a kernel density estimate with m modes)
%
%    Bibliography:
%    [1] Efron and Tibshirani. Chapter 16 Hypothesis testing with the
%         bootstrap in An introduction to the bootstrap (CRC Press, 1994)
%
%  bootmode v1.0 (27/03/2018)
%  Author: Andrew Charles Penn
%  https://www.researchgate.net/profile/Andrew_Penn/


%% Stamp data example used in reference [1]
%% From stamp dataset in bootstrap R package
% stamp = [0.079;0.077;0.080;0.128;0.089;0.075;0.084;0.100;0.079;0.106;0.112;0.079;0.080;
%    0.093;0.080;0.079;0.072;0.103;0.108;0.078;0.098;0.081;0.071;0.120;0.102;0.079;0.078;
%    0.097;0.108;0.105;0.105;0.110;0.072;0.072;0.091;0.131;0.072;0.079;0.082;0.072;0.090;
%    0.072;0.099;0.096;0.077;0.101;0.076;0.071;0.110;0.098;0.070;0.080;0.072;0.105;0.078;
%    0.075;0.075;0.070;0.119;0.082;0.080;0.099;0.070;0.097;0.075;0.082;0.074;0.072;0.091;
%    0.069;0.070;0.069;0.080;0.070;0.100;0.090;0.079;0.089;0.076;0.081;0.064;0.079;0.079;
%    0.082;0.108;0.106;0.079;0.080;0.075;0.082;0.080;0.081;0.095;0.082;0.079;0.102;0.072;
%    0.073;0.110;0.073;0.075;0.114;0.077;0.079;0.069;0.081;0.075;0.110;0.078;0.082;0.101;
%    0.077;0.081;0.078;0.074;0.093;0.069;0.078;0.080;0.110;0.119;0.072;0.073;0.078;0.109;
%    0.070;0.076;0.079;0.078;0.079;0.070;0.115;0.079;0.072;0.086];

% Results from multimodality testing using this
% function compare well with reference [1]
%
% m	 h       P
% 1  0.0068  0.00
% 2  0.0032  0.32
% 3  0.0030  0.07
% 4  0.0028  0.00
% 5  0.0026  0.00
% 6  0.0024  0.00
% 7  0.0015  0.46

function [H, P, h] = bootmode (x, m, B)

  % Vectorize the data
  x = x(:);
  n = numel(x);

  % Find critical bandwidth
  [criticalBandwidth] = findCriticalBandwidth (x, m);
  h = criticalBandwidth;

  % Random resampling with replacement from a smooth estimate of the distribution
  idx = 1+fix(rand(n,B)*n);
  Y = x(idx);
  xvar = var(x,1); % calculate sample variance
  Ymean = ones(n,1) * mean(Y);
  X = Ymean + (1 + h^2/xvar)^(-0.5) * (Y - Ymean + (h * randn(n,B)));

  % Calculate bootstrap statistic of the bootstrap samples
  % Boostrap statistic is the number of modes (faster)
  f = zeros(200,B);
  for j = 1:B
    [f(:,j),t] = gausskde(X(:,j),h);
  end
  % Compute number of modes in the kernel density estimate of the bootstrap samples
  mboot = sum(diff(sign(diff(f)))<0);
  % Approximate achieved significance level (ASL) from bootstrapping number of modes
  P = sum(mboot > m)/B;

  %% Calculate bootstrap statistic of the bootstrap samples
  %% Boostrap statistic is the critical bandwidth (slower)
  %hBoot = zeros(B,1);
  %for j = 1:B
  %  [criticalBandwidth] = findCriticalBandwidth (X(:,j), m);
  %  hBoot(j) = criticalBandwidth;
  %end
  %% Approximate achieved significance level (ASL) from bootstrapping critical bandwidths
  %P = sum(hBoot > h)/B;

  % Accept or reject null hypothesis
  if P > 0.05
    H = 0;
  elseif P < 0.05
    H = 1;
  end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [criticalBandwidth] = findCriticalBandwidth (x, mref)

  if mref > numel(x)
    error('the number of modes cannot exceed the number of datapoints')
  end

  % Calculate starting value for bandwidth
  % The algorithm sets the initial bandwidth so that half
  % of the sorted, unique data points are well separated
  xsort = sort(x);
  xdiff = diff(xsort);
  h = median(xdiff(xdiff>0))/(2*sqrt(2*log(2)));

  m = inf;
  while m > mref
    % Increase h
    h = h * 1.01; % Increase query bandwidth by 1%
    [y, t] = gausskde (x, h);
    m = sum(diff(sign(diff(y)))<0);
  end
  criticalBandwidth = h;

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [f, t] = gausskde (x, h)

  % Vectorize the data
  x = x(:);

  % Default properties of t
  n = numel(x);
  tmin = min(x) - 3 * h; % define lower limit of kernel density estimate
  tmax = max(x) + 3 * h; % define upper limit of kernel density estimate

  % Kernel density estimator
  t = linspace(tmin,tmax,200)';
  f = zeros(200,1);
  for i = 1:n
    xi = ones(200,1) * x(i);
    u = (t-xi)/h;
    K = @(u) 1/sqrt(2*pi)*exp(-0.5*u.^2); % Gaussian kernel
    f = f + K(u);
  end
  f = f * 1/(n*h);

end