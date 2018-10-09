function [f G1 G2] = bkde2D(X,h,M)
%======= BINNED BIVARIATE KERNEL DENSITY ESTIMATE WITH GAUSSIAN KERNEL==========
%Calculates the 2D kernel density estimate for a data set X at an m-by-m grid of
%points, using a gaussian product kernel with bandwidths h(1) and h(2). The
%function values and x1- and x2- coordinates are returned in f, G1, and G2.
%This function uses a binned approximation based on the FFT to increase speed.
%
%Example Calls:
%   f = bkde2D(X,h,M)       Where M is a structure with 2 fields X1 and X2,
%                           each of which are m-by-m matrices, calculates the
%                           kde at the (x1,x2) coordinates specified in M.X1 and
%                           M.X2.  X1 and X2 are as if produced by meshgrid().
%   [f G1 G2] = bkde2D(X,h,M) Where M is a scalar number of grid points, returns 
%                            function values in f and the grid points in G1, G2.
%   ... = bkde2D(X,[],M)    Calculates using the approximate normal-reference
%                           bandwidths as in Scott92, p. 152.
%Inputs:
%   X   An n-by-2 matrix of data values (data points in rows).
%   h   A 2-vector of bandwidths. h(1) is bandwidth to use for X(:,1) direction.
%   M   A positive integer number of grid points to return, or a structure with
%       fields X1 and X2 giving the grid coordinates in each direction as in the
%       meshgrid() output.
%
%Outputs:
%   f   An m-by-m matrix of function values.
%   G1  An m-by-m matrix of 1st-dimension grid points for f values.
%   G2  An m-by-m matrix of 2nd-dimension grid points for f values.

%Notes:
%   * For now this function has very limited error checking/handling.
%     
%Reference: M. P. Wand, Fast Computation of Multivariate Kernel Estimators, 
%           Journal of Computational and Graphical Statistics, 1994, 3, 433-445.
%===============================================================================


%==SET UP GRID, BANDWIDTH ETC.==================================================
n = size(X,1);
if isempty(h)
    h = std(X)*n^(-1/6);                %-Normal-ref bandwidth rule.
end
if isstruct(M)
    G1 = M.X1;
    G2 = M.X2;
    m = size(G1,1);
    minx = [G1(1,1) G2(1,1)];
    maxx = [G1(m,m) G2(m,m)];
else
    m = M;
    minx = min(X)-3*h;
    maxx = max(X)+3*h;
    [G1 G2] = meshgrid(linspace(minx(1),maxx(1),m),linspace(minx(2),maxx(2),m));
end
dx1 = (maxx(1)-minx(1))/(m-1);          %-Grid spacing in X1 direction.
dx2 = (maxx(2)-minx(2))/(m-1);          %-Grid spacing in X2 direction.
CellArea = dx1*dx2;
X1 = X(:,1);                            %-Vector of 1st X coordinates.
X2 = X(:,2);                            %-Vector of 2nd X coordinates.
g1 = G1(1,:)';                          %-Vector of X1 gridpoint locations.
g2 = G2(:,1);                           %-Vector of X2 gridpoint locations.


%==DETERMINE GRID COUNTS========================================================
% Use linear binning.  Note in these calcs that we're using the characteristics
% of G1, G2 as they are created by meshgrid:  G2 is increasing down along
% columns.  So "up" refers to higher in the matrix, but it's lower in terms of
% X2 gridpoint value.

%--Get indices of gridpoints to left, right, top, bottom of each data point-----
LeftIndex = ceil((X1-minx(1))/dx1);     %-Indices of G1 gridpt left of each pt.
RightIndex = LeftIndex+1;               %-Indices of G1 gridpt right of each pt.
UpIndex = ceil((X2-minx(2))/dx2);       %-Indices of G2 gridpt above each pt.
DownIndex = UpIndex+1;                  %-Indices of G2 gridpt below each pt.
%--Calculate weights used in linear binning-------------------------------------
hgap1 = X1-g1(LeftIndex);
hgap2 = dx1-hgap1;
vgap1 = X2-g2(UpIndex);
vgap2 = dx2-vgap1;
DownRightWeight = hgap1.*vgap1/CellArea;
DownLeftWeight = hgap2.*vgap1/CellArea;
UpRightWeight = hgap1.*vgap2/CellArea;
UpLeftWeight = hgap2.*vgap2/CellArea;
%--Now create the grid count matrix by summing weights--------------------------
% Add the four corners in turn.
temp = zeros(m);
UL = temp;                              %-For holding up-left weights.
UR = temp;                              %-For holding up-right weights.
DL = temp;                              %-For holding down-left weights.
DR = temp;                              %-For holding down-right weights.
UL(sub2ind([m m],LeftIndex,UpIndex)) = UpLeftWeight;
UR(sub2ind([m m],RightIndex,UpIndex)) = UpRightWeight;
DL(sub2ind([m m],LeftIndex,DownIndex)) = DownLeftWeight;
DR(sub2ind([m m],RightIndex,DownIndex)) = DownRightWeight;
C = UL+UR+DL+DR;


%==DETERMINE KERNEL WEIGHTS=====================================================
tau = 5;                                %-Eff. support of Kh is [-tau, tau].
L = min(floor(tau*h./[dx1 dx2]),m-1);   %-max l values to calc k for.
[l1 l2] = meshgrid(0:L(1),0:L(2));      %-Values of l1, l2 for getting K.
K1 = 1/(sqrt(2*pi)*h(1))*exp(-(dx1*l1).^2/(2*h(1)^2));
K2 = 1/(sqrt(2*pi)*h(2))*exp(-(dx2*l2).^2/(2*h(2)^2));
K = (K1.*K2)';                          %-Transpose to get right orientation.


%==GET THE ESTIMATE BY DOING THE CONVOLUTION VIA FFT============================
%Find the smallest power of 2 bigger than M+Li (for fastest performance of fft).
%If this is bigger than 2^10, just use M+Li+7.
P = [2^ceil(log(m+L(1))/0.693147180559945) 2^ceil(log(m+L(2))/0.693147180559945)];
P(P>1024) = m+L(P>1024)+7;
%Create the zero-padded C and K matrices.
Cpad = [ [C zeros(m,P(2)-m)]; zeros(P(1)-m,P(2))];
Kpad = [ [K                  zeros(L(1)+1,P(2)-2*L(2)-1) fliplr(K(:,2:end))];
          zeros(P(1)-2*L(1)-1,P(2));
         [flipud(K(2:end,:)) zeros(L(1),P(2)-2*L(2)-1)   flipud(fliplr(K(2:end,2:end)))] ];
%Compute the FFTs
FTC = fft2(Cpad);
FTK = fft2(Kpad);
%Get the inverse fft of their elementwise product to get the desired
%convolution.  Need to pull out the upper left m-by-m submatrix as the answer.
fpad = ifft2(FTC.*FTK);
f = 1/n*fpad(1:m,1:m)';                 %-Transpose answer to match G1, G2.
% f = round(1e8*f)/1e8;                   %-Round to eliminate numerical noise.
     
     
end