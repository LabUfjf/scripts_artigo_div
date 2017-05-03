function [ x,y ] = ash(varargin)

%ASH  AVERAGE SHIFT HISTOGRAM.
% 
%   [X,Y] = HIST(DATA) bins the elements of Y into FD equally spaced
%   containers with 10 SHIFT HISTOGRAMS and returns the mean number
%   of elements in each container.
%
%   [X,Y] = HIST(DATA,M), where M is a scalar, uses M SHIFT HISTOGRAMS.
%
%   [X,Y] = HIST(DATA,X,TYPE), where TYPE is a defined, the interpolation
%   has made with the definition. OBS. the default value is 'NEAREST'.
%
%   HIST(...) without output arguments produces a histogram bar plot of
%   the results.
%
%   Class support for inputs Y, X: 
%      float: double, single
%

% Parse possible Axes input

narginchk(1,inf);
[~,args,nargs] = axescheck(varargin{:});

data=args{1};
type = 'nearest';
if nargs == 1
    m = 10;
    bin = calcnbins(data, 'fd');
elseif nargs==2
    m = args{2};
    bin = calcnbins(data, 'fd');
elseif nargs==3
    m = args{2};
    bin = args{3};
else
    m = args{2};
    bin = args{3};
    type = args{4};
end

% Main


v = linspace(min(data),max(data),bin);
h = diff(v); h = h(1);
% h=(max(data)-min(data))/bin;

%% AVERAGE SHIFT HISTOGRAM


dt=h/m;
t0=linspace(-h/2,(h/2-dt),m)';
% t0=linspace(0,(h-(h/m)),m)';

for j=1:m
    gridx(j,:)=linspace((min(data)+t0(j)),(max(data)+t0(j)),bin);
    for i=1:bin-1
        fa(j,i)=length(find(data>=gridx(j,i) & data<=(gridx(j,i+1))));
        xa(j,i)=(gridx(j,i)+gridx(j,i+1))/2;
    end
end


newgrid=xa(:)';
for k=1:m
    fsh(k,:)=interp1(xa(k,:),fa(k,:),newgrid,type,0);
end

fash=mean(fsh,1);

if nargout > 0
    x=newgrid;
    y=fash;
else
    bar(newgrid,fash,1,'hist')
end

%% HELP SECTION
%  ORDINARY HISTOGRAM

% h=(max(data)-min(data))/bin;
% 
% 
% gridx=min(data):h:max(data);
% % gridx(2,:)=linspace(min(data),max(data),bin+1);
% 
% for i=1:bin
%     f(i)=length(find(data>=gridx(i) & data<=(gridx(i+1))));
%     x(i)=(gridx(i)+gridx(i+1))/2;
% end
% bar(x,f,1,'hist')


end

