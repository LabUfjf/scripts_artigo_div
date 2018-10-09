function y = improve(y0,x,confun,varargin)
%=====IMPROVE A DATA SHARPENING SOLUTION BY MOVING IT TOWARD THE ORIGINAL DATA=======
%
%Example Calls:
% y = improve(y0,x,confun)
% y = improve(y0,x,confun,varargin)
%
%Given a solution y0 that satisfies constraint function confun, improve() shifts
%the points in y0 toward the original data x using a greedy point-by-point
%method.  The constraint remains satisfied throughout. The solution returned,
%y, will have min(y0(j),x(j)) <= y(j) <= max(y0(j),x(j)) for all j.
%
%Required Inputs:
%   y0      An initial guess solution, that satisfies the constraint. n-by-d
%           matrix (d==1 for scalar data).
%   x       The observed data, in an n-by-d matrix.
%   confun  A function handle for a consraint-checking function.  Takes
%           arguments the size of x.  Confun returns a logical result (true if 
%           the constraint is satisfied).
%
%Optional Inputs (attribute-value pairs):
%   'objfun'    A function handle to an objective function objfun(y,x) to be 
%               minimized during sharpening.  The first argument of objfun is
%               the sharpened y, the 2nd argument is the unsharpened x. If
%               supplied, the solution y will also have objfun(y)<=objfun(y0).
%   'tol'       Tolerance for determining when a point is at home or pinned by
%               the constraint.  Default 1e-4.
%   'verbose'   Set to true to see interim progress; false (default) for none.
%   'maxpasses' Upper bound on the number of passes through the data.  Default
%               500.  Normally should not need to adjust this.
%   'matching'  Logical true (default) to do re-matching of y to x during the search,
%               or false to skip the matching step.  Use matching when the objective
%               function is invariant to permutations of y, and turn off matching
%               when the order of y does matter to the objective.
%
%Outputs:
%   y       The sharpened data points (n by d)
%

%Notes:
% TODO:  Consider improving the way ordermem is used:
%           -fill it up without skipping rows when a match is found. 
%           -do ismember(ix',ordermem(1:count,:),'rows') in order to reduce the
%            size of compared matrix in ismember (if this improves speed).
%===============================================================================

%==INITIALIZE THINGS============================================================
%--Parse the inputs-------------------------------------------------------------
IP = inputParser;                       %-Create instance of inputParser class.
                                        %-Add args/validator fcns to the schema.
IP.addRequired('y0', @(x) isnumeric(x) && ~any(isnan(x(:))) );
IP.addRequired('x', @(x) isnumeric(x) && ~any(isnan(x(:))) );
IP.addRequired('confun', @(x) strcmp(class(x),'function_handle'));
IP.addParamValue('objfun', [], @(x) strcmp(class(x),'function_handle'));
IP.addParamValue('tol', 1e-4, @(x) isscalar(x) && x>0);
IP.addParamValue('verbose', false, @(x) islogical(x));
IP.addParamValue('maxpasses', 500, @(x) isnumeric(x) && x>0);
IP.addParamValue('matching', true, @(x) islogical(x) && isscalar(x) );
IP.parse(y0,x,confun,varargin{:});      %-Parse and validate input arguments.
IP.FunctionName = 'improve';            %-Other parser settings
objfun = IP.Results.objfun;             %-Bring out the objective function.
tol = IP.Results.tol;                   %-Bring out the val of tol.
verbose = IP.Results.verbose;           %-Bring out the val of verbose.
maxpasses = IP.Results.maxpasses;       %-Bring out the val of maxpasses.
matching = IP.Results.matching;         %-Bring out the val of matching.
if ~confun(y0)
    error('The given starting value does not satisfy the constraint')
end

%Set up needed objects----------------------------------------------------------
n = size(y0,1);
idx = (1:n)';                           %-Indices to use for ordering.
count = 1;                              %-Loop counter.
if matching
    [y ix] = match(y0,x);               %-Ensure elements of y & x are matched.
    ordermem = zeros(maxpasses+1,n);    %-Memory to hold re-ordering info.
    ordermem(1,:) = ix';
else
    y = y0;
end
if isempty(objfun)
    testfun = confun;
else
    OFval = objfun(y0,x);               %-Starting objfun value.
                                        %-Create a fcn to control grid search:
    testfun = @(v) confun(v) && objfun(v,x)<=OFval;
end
                                        %-A fcn to get a unit vec from a to b.
unitvec = @(a,b) (b-a)/sqrt((b-a)*(b-a)');
dist = @(a,b) sqrt(sum((a-b).^2,2));    %-A fcn to calc euclidean dist between 
                                        % sets of row vectors.

%--Find the initial set of m moveable points------------------------------------
D = dist(x,y);
home = D<=tol;                          %-Logical vec of pts. at home.
nothome = idx(~home);                   %-Index vec of not-home points
pinned = false(n,1);                    %-Logical vec to hold pinned status.
for i = 1:length(nothome)               %-Fill in the pinned vector.
    tst = y;
    j = nothome(i);
    tst(j,:) = tst(j,:) + tol*unitvec(tst(j,:),x(j,:));
    if ~testfun(tst)
        pinned(j) = true;
    end
end
moveable = ~(home|pinned);              %-Logical vector of home or pinned pts.
m = sum(moveable);                      %-m is the number of moveable points.


%==RUN THE ALGORITHM============================================================
%Perform repeated passes through the data points.  At each pass, try to move
%each point toward home by stepping out from its current location.  The step
%size is a proportion of the distance |y(j) - x(j)|; this proportion starts
%at 1 (step all the way) and is reduced by factors of 2 whenever no moves
%can be made.
%--Set the sweep order----------------------------------------------------------
%Sweep in descending order of distance from home.
pts = idx(moveable);
[Ds ix] = sort(D(moveable),'descend');
pts = pts(ix);                          %-pts is the ordered set of moveables.

%--OUTER LOOP: KEEP SWEEPING UNTIL NO MORE POINTS ARE MOVEABLE------------------
steps = 1;                              %-Initial no. of steps in grid search.
while m>0 && count<maxpasses

    nmoved = 0;                         %-Re-set move counter.

    %--INNER LOOP: A SINGLE PASS THROUGH THE MOVEABLE POINTS--------------------
    %Note, we ensure that the minimum step size possible is equal to tol.
    for i = 1:m
        j = pts(i);
        A = y(j,:);                     %-"left post": the current sharpened pt.
        B = x(j,:);                     %-"right post": the true data pt.
        d = dist(A,B);                  %-Distance between posts.
        uv = unitvec(A,B);              %-Unit vector from A to B.
        k = 0;                          %-Counts number of successful steps.
        stepsize = max(d/steps,tol);
        stop = false;
        while ~stop && (k+1)*stepsize<=d
        %Start at A and step out toward B. Count the number of successful steps
        %(k) before violating constraint. Stop stepping out once constraint is
        %violated or B is reached.
            y(j,:) = A + (k+1)*stepsize*uv;
            if testfun(y)
                k = k+1;
            else
                stop = true;
            end
        end
        %Set y(j,:) to the last feasible step.
        y(j,:) = A + k*stepsize*uv;
        if k>0
            nmoved = nmoved+1;          %-Add to the move count if pt changed.
        end
    end

    %--Show interim progress (if desired), and update counter-------------------
    if verbose
        disp(['Sweep: ' num2str(count) '   moves: ' num2str(nmoved) ...
              '   moveable: ' num2str(m) '   steps: ' num2str(steps)])
    end
    count=count+1;                      %-Increment counter.

    %--Prepare for next sweep, depending on whether moves were made-------------
    %If points have been moved, re-match and order the points without
    %modifying the search.  If no points moved, double the no. of grid pts.
    if nmoved>0
        %--Re-match the points if neccessary------------------------------------
        %But be careful to avoid infinite cycles. Only accept the re-ordering if
        %it is a new arrangment.
        if matching
            [yy ix] = match(y,x);
            if ~ismember(ix',ordermem,'rows')
                ordermem(count,:) = ix';
                y = yy;
            end
        end
        %--Re-find the set of m moveable points---------------------------------
        D = dist(x,y);
        home = D<=tol;                  %-Logical vec of pts. at home.
        nothome = idx(~home);           %-Index vec of not-home points
        pinned = false(n,1);            %-Vec to hold pinned status.
        for i = 1:length(nothome)       %-Fill in the pinned vector.
            tst = y;
            j = nothome(i);
            tst(j,:) = tst(j,:) + tol*unitvec(tst(j,:),x(j,:));
            if ~testfun(tst)
                pinned(j) = true;
            end
        end
        moveable = ~(home|pinned);      %-Vec of home or pinned pts.
        m = sum(moveable);              %-Number of moveable points.
        %--Re-set the sweep order-----------------------------------------------
        %Sweep in descending order of distance from home.
        pts = idx(moveable);
        [Ds ix] = sort(D(moveable),'descend');
        pts = pts(ix);                  %-The ordered set of moveables.
    else
        steps = 2*steps;
    end

end

%===============================================================================

end
