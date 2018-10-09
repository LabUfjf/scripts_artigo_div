function [val ix] = match(v,w)
%=============== MATCH DATA POINTS IN V TO THOSE IN W ==========================
%Takes a set of (possibly high-dimensional) data points v, and returns the
%same points in an ordered sequence--ordered so that points in v correspond
%to points in w.  Correspondence is determined based on the shape of the data
%sets in space.
%
%Inputs:
%   v   An n-by-d matrix of data points.  Each row corresponds to one point in
%       d-space.
%   w   Another n-by-d data matrix, giving the "reference" or "target" points.
%       The points in v are ordered to make them match up with those in w in
%       some sense (see Notes).
%
%Outputs:
%   val A re-ordered version of v.
%   ix  An index vector such that v(ix,:) = val.
%
%Notes:
%   -If v or w is a constant vector, v is returned unaltered.
%   -If d = 1 (scalar data points), then v is rearranged so that the jth- 
%    smallest value of v corresponds to the jth-smallest value of w.
%   -If d > 1, the v and w points are first given a location/scale
%    transformation so they have the same mean and unit componentwise variance.
%    Then the points are matched in a greedy way (closest pairs matched first).

%===============================================================================
%--Go through special cases-----------------------------------------------------
%Deal with the scalar (d = 1) case.
[n d] = size(v);
if d==1
    [vs vx] = sort(v);
    [ws wx] = sort(w);
    [wxs wxx] = sort(wx);
    ix = vx(wxx);
    val = v(ix);
    return
end
%Check for special case of all datat points the same.
if size(unique(v,'rows'),1)==1 || size(unique(w,'rows'),1)==1
    val = v;
    ix = (1:n)';
    return
end

%--If not any special case, proceed with usual d-dimensional matching-----------
%(NB: use outer product with ones(n,1) to avoid repmat calls)
ix = zeros(n,1);
onevec = ones(n,1);
%Center both data sets to have mean zero
vc = v - onevec*mean(v);
wc = w - onevec*mean(w);
%Scale both data sets to have componentwise variances of 1
vcs = vc./(onevec*std(v));
wcs = wc./(onevec*std(w));
%Do it by recursively joining the nearest pair (greedy approach).
D = squareform(pdist([vcs; wcs]));
D = D(n+1:2*n,1:n);
val = zeros(n,d);
high = max(D(:))+1;
for k = 1:n
    [minw minv] = ind2sub([n n],find(D(:)==min(D(:)),1,'first'));
    ix(minw) = minv;
    val(minw,:) = v(minv,:);    %-assign approp v to the w loc'n in val.
    D(minw,:) = high;           %-Prevent picking same w again
    D(:,minv) = high;           %-prevent picking same v again
end


end

