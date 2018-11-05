function [X,ff] = KDEBINNED(x,h,M)

n = length(x);
% M = 400;


del0 = (1/(4 * pi))^(1/10);


if isempty(h)
h = del0 * (243/(35 * n))^(1/5) * sqrt(var(x));
end
%        h = del0 * bandwidth;
%     h = bandwidth;
tau = 4;

%     if isempty(range)
rangex = [min(x) - tau * h, max(x) + tau * h];
%     end
a = min(rangex);
b = max(rangex);
gpoints = linspace(a, b, M);
gcounts = hist(x, gpoints);
delta = (b - a)/(h * (M - 1));
L = min(floor(tau/delta), M);

lvec = 0:L;

kappa =   pdf('normal',(lvec * delta),0,1)/(n * h);

P = 2^(ceil(log(M + L + 1)/log(2)));
kappa = [kappa zeros(1,P-(2*L)-1) fliplr(kappa(2:end))];
tot = sum(kappa) * ((b - a)/(M - 1)) * n;
gcounts = [gcounts  zeros(1, P-M)];
kappa = fft(kappa/tot);
gcounts = fft(fft(fft(gcounts)));
y = real(fft(kappa .* gcounts))/P;

ff=y([1:M]);
aff=area2d(gpoints,ff);
ff=ff/aff;
X =  gpoints;

end