function [tf locmax] = isuni2D(f,varargin)
%=====================TWO-DIMENSIONAL UNIMODALITY CHECK=========================
% Given a matrix f of function values evaluated over an (unspecified) regularly-
% spaced m-by-m grid, determines whether the density is unimodal according to 
% some definition.  The particular version of unimodality tested for is 
% specified by varargin.
%
% Outputs:
%   tf          A logical indicating true if the constraint is satisfied.
%   locmax      A logical matrix the same size as f indicating where maxima are.
%
% Optional arguments:
%   Enter any combination of the following to get the desired behaviour of the
%   function.
%   * 'onemax'          True if the function has only one local maximum.
%   * 'nomin'           True if the function has zero local minima.
%   * 'conditionals'    True if all conditionals of the function are unimodal.
%   * 'marginals'       True if both marginals of the function are unimodal.
%
%   If multiple constraints are supplied, tf returns true only when all
%   constraints are satisfied.
%   If no optional arguments are supplied, 'onemax' and 'nomin' are used.

%NOTES:
% * TODO: Need to check for contiguous groups of modes (to avoid falsely 
% rejecting plateaus).  This would be especially necessary if we put in rounding
% of f--which might be nice to avoid numerical problems giving tiny spurious
% modes.
% * TODO: Function currently has no error checking (e.g. checking for square f,
% checking for valid optional arguments, etc.).
% * NB: I removed all equalities when checking for local maxima/minima (i.e. I'm
% using "<" rather than "<=").  This helps avoid problems when using the binned
% KDE.  But later, if incorporate checking for plateaus, we might want these
% equalities put back in.
%===============================================================================

%--Set up constraints and initialize things-------------------------------------
if isempty(varargin)
    varargin = {'onemax','nomin'};
    ncon = 2;
else
    ncon = length(varargin);
end
m = size(f,1);

%--Round f off to wipe out noise in the tails-----------------------------------
% E.g. if use binned estimator to get f, could have numerical noise left over
% from fourier transforms.  To round off, find what order of magnitude the max
% density value is, then round off to six more sigfigs.
pwr = ceil(-log10(max(f(:)))) + 6;
f = round(10^pwr*f)/10^pwr;

%--Find the local maxima if necessary-------------------------------------------
% To check for local maxes, take each interior point of f, and compare to its 8
% nearest neighbours.  If it's greater than all of them, it's a max.
if nargout==2 || ismember('onemax',varargin)
    locmax = false(size(f));
    fpoint = f(2:m-1,2:m-1);

    up = fpoint > f(1:m-2,2:m-1);
    down = fpoint > f(3:m,2:m-1);
    left = fpoint > f(2:m-1,1:m-2);
    right = fpoint > f(2:m-1,3:m);

    upleft = fpoint > f(1:m-2,1:m-2);
    upright = fpoint > f(3:m,1:m-2);
    downleft = fpoint > f(1:m-2,3:m);
    downright = fpoint > f(3:m,3:m);

    locmax(2:m-1,2:m-1) = up&down&left&right&upleft&upright&downleft&downright;
end

%--Loop through constraints and do checking-------------------------------------
for i = 1:ncon
    switch varargin{i}
        
        case 'onemax'                    
        %-Need only one max. Just count the previously-found maxima.
            tf = sum(locmax(:))==1;
        
        case 'nomin'
        %-Need zero minima.  To count, flip the function upside down and re-do
        % the count of maxima.
            fpoint = -f(2:m-1,2:m-1);
            up = fpoint > -f(1:m-2,2:m-1);
            down = fpoint > -f(3:m,2:m-1);
            left = fpoint > -f(2:m-1,1:m-2);
            right = fpoint > -f(2:m-1,3:m);

            upleft = fpoint > -f(1:m-2,1:m-2);
            upright = fpoint > -f(3:m,1:m-2);
            downleft = fpoint > -f(1:m-2,3:m);
            downright = fpoint > -f(3:m,3:m);

            locmin = up&down&left&right&upleft&upright&downleft&downright;
            tf = sum(locmin(:))==0;
        
        case 'conditionals'
        %-Check each row and column sequentially to see if they're unimodal.
            tf = true;
            i = 1;
            while tf&&i<=m
                dr = diff(f(i,:));
                dr(dr==0) = [];
                chgsr = sum(diff(sign(dr))~=0);
                tfr = chgsr<=1; 
                dc = diff(f(:,i));
                dc(dc==0) = [];
                chgsc = sum(diff(sign(dc))~=0);
                tfc = chgsc<=1; 
                tf = tfr&&tfc;
                i = i+1;
            end
            
        case 'marginals'
        %-Need unimodal marginal curves.  Do numerical integration in X1 and X2
        % directions to get functions proportional to the marginals. 
            marg1 = trapz(f);
            marg2 = trapz(f,2);
            
            dm1 = diff(marg1);
            dm1(dm1==0) = [];
            tf1 = sum(diff(sign(dm1))~=0) <= 1;
            
            dm2 = diff(marg2);
            dm2(dm2==0) = [];
            tf2 = sum(diff(sign(dm2))~=0) <= 1;

            tf = tf1&&tf2;

    end    
    
    if ~tf                              %-Break out of for loop if already found
        break                           % constraint violations.
    end
    
end

end

