function [g,f] = bkde(x,h,M)
%============= BINNED KERNEL DENSITY ESTIMATE WITH GAUSSIAN KERNEL =============
%Uses a good approximation method to quickly calculate the 1D kernel density
%estimate for a data set x at m evenly-spaced points, using a gaussian kernel
%with bandwidth h. The vector of density function values is returned in f.
%Approximation should be very good for m > 100 or so.
%
%Example Calls:
%   f = bkde(x,h,M)         Where M is a vector of evenly-spaced, increasing 
%                           grid points, returns a vector of density values.
%   [f g] = bkde(x,h,M)     Where M is a scalar number of grid points, returns 
%                           function values in f and the grid points in g.
%
%Inputs:
%   x   A column vector of data values.
%   h   A positive scalar bandwidth.
%   M   A positive integer number of grid points to return, or a vector of grid
%       points at which to calculate the estimate.
%Outputs:
%   f   A vector of M or length(M) function values at grid points g.
%   g   A vector of grid points at which the density is evaluated.

%Notes:
%   Reference: Wand and Jones 1995, Kernel Smoothing, Appendix D.
%   ***NB: no error or consistency checking yet in this function, e.g.:
%       -If g supplied, check that uniformly spaced, and max(x)<g(end).
%       -Check x column vector, transpose if not.
%       
%===============================================================================


%--Create g, the vector of grid points------------------------------------------
%Also get d, the grid spacing.
if length(M)>1                          %-If a gridpoint vector supplied.
    g = M;
    M = length(g);
    LB = g(1);
    d = (g(M)-g(1))/(M-1);
else                                    %-If only number of gridpoints supplied.
    LB = min(x)-3*h;
    UB = max(x)+3*h;
    d = (UB-LB)/(M-1);
    g = [LB+(0:M-2)*d UB]';
end
%--Create c, the vector of grid counts------------------------------------------
n = length(x);                          %-Sample size.
C = sparse(2*n,M);                      %-Matrix for collecting c contributions.
row = (1:2*n)';                         %-Vector for counting rows.
lindex = floor((x-LB)/d)+1;             %-For each x, closest gridpt on left.
rindex = lindex+1;                      %-For each x, closest gridpt on right.
lweight = (g(rindex)-x)/d;              %-Weights assigned to left gridpts.
rweight = (x-g(lindex))/d;              %-Weights assigned to right gridpts.
indices = [lindex; rindex];             %-Put indices into single vector.
weights = [lweight; rweight];           %-Put weights into single vector.
ind = 2*n*(indices-1)+row;              %-Get linear indices of locations in C 
                                        % to place the weights (could use
                                        % sub2ind function instead).
C(ind) = weights;                       %-Use linear indices to fill spots in C.
c = full(sum(C)');                      %-Final grid counts is sum of C' cols.
%--Create k, the vector of kernel weights---------------------------------------
tau = 4;                                %-Eff. support of Kh is [-tau, tau].
L = min(floor(tau*h/d),M-1);            %-max l value to calc k for.
l = (0:L)';                             %-Vector of l values.
                                        %-Calc the k vals (gaussian kernel).
k = 1/(n*sqrt(2*pi)*h)*exp(-(d*l).^2/(2*h^2));
%--Perform the convolution using fft method-------------------------------------
%Find the smallest power of 2 bigger than M+L (for fastest performance of fft).
P = 2^ceil(log(M+L)/0.693147180559945);
%Pad the c and k vectors with zeros.
cc = [c; zeros(P-M,1)];
kk = [k; zeros(P-2*L-1,1); k(L+1:-1:2)];
%Get the fft's of each vector.
ftc = fft(cc);
ftk = fft(kk);
%Get the inverse fft of their elementwise product; keep only the first M values
%of the result as the approximation.
flong = ifft(ftc.*ftk);
f = flong(1:M);
f = round(1e8*f)/1e8;                   %-Round off to avoid problems detecting 
                                        % modes, etc.  
end