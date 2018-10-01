
function optM = optBINS(data,maxM)
N = size(data,2);
% Simply loop through the different numbers of bins
% and compute the posterior probability for each.
logp = zeros(1,maxM);
for M = 1:maxM
n = hist(data,M); % Bin the data (equal width bins here)
part1 = N*log(M) + gammaln(M/2) - gammaln(N+M/2);
part2 = - M*gammaln(1/2) + sum(gammaln(n+0.5));
logp(M) = part1 + part2;
end
[maximum, optM] = max(logp);
return;
