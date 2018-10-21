function [y]=fdt(x)
%FDT Frequency distribution table. A frequency distribution table shows us 
%  a summarized grouping of data orderly arranged, divided into mutually 
%  exclusive classes (no data value can fall into two different classes),
%  inclusive or exhaustive (all data values must be included) and the 
%  number of occurrences in a class. It is a way of showing unorganized
%  data. Some of the graphs that can be used with frequency distributions
%  are histograms, line charts, bar charts and pie charts.
%
%  Frequency distributions are used for both qualitative and quantitative
%  data. Here, we are presenting it for quantitative data (measuring 
%  observations).
%
%  An essential requirement for a frequency distribution is to decide about
%  the number of classes. Theory recomends it should be between 5 and 20 
%  classes. However, some times it it required more classes. Too many 
%  classes or too few classes might not reveal the basic shape of the data 
%  set, also it will be difficult to interpret such frequency distribution.
%  The maximum number of classes may be determined by a formula. Generally
%  the class interval or class width is the same for all classes.
%
%  There are several mathematical procedures which can help calculate the 
%  number of classes, all of them have their pros and cons, and can be 
%  found in many statistical texts. Here, we include a menu to choose one 
%  from:
%
%  -- Square root rule
%  -- 2 to the k rule
%  -- Rice rule
%  -- Sturges rule
%  -- Doane formula
%  -- Freedman-Diaconis rule
%  -- Scott rule
%  -- Shimazaki-Shinomoto method*
%
%  In other case you must give the number of classes you need.
%
%  *For the last option, it is necessary to download the sshist m-function 
%  (Histogram Binwidth Optimization). It returns the optimal number of bins
%  in a histogram used for density estimation. Optimization principle is to 
%  minimize expected L2 loss function between the histogram and an unknown 
%  underlying density function. An assumption made is merely that samples 
%  are drawn from the density independently each other. It can found at
%  http://www.mathworks.com/matlabcentral/fileexchange/24913-histogram-
%  binwidth-optimization
%
%  Why one should organize data in a frequency distribution table?
%  -- To organize data in a meaningful, intelligible way.
%  -- To enable the reader to determine the nature or shape of the 
%     distribution (can make patterns within the data more evident).
%  -- To facilitate computational procedures for measuring the center, 
%     variation, distribution shape, outlier(s), and time.
%  -- To enable the researcher to draw charts and graphs for the 
%     presentation of data.
%  -- To enable the reader to make comparison among different data sets. 
%
%  This m-function also offer a data graph dispaly menu you can select one
%  option:
%
%  -- Histogram
%  -- Frequency polygon 
%  -- Absolut ogive
%  -- Relative ogive (here with the observed and the predicted cdf)
%  -- All
% 
%  Syntax: function [y] = fdt(x) 
%      
%  Input:
%       x - data vector (from a menu can choose the number of classes
%           procedure)
%  Output:
%         - frequency (distribution) table and a data graph display
%           (optionally from a menu)
%    [y]  - frequency (distribution) table, a data graph display 
%           (optionally from a menu), and absolut frequencies and 
%           class marks matrix (optionally). This last matrix can be
%           further used for some grouped statistics procedure you can find
%           in my Matlab FEX author page
%
%  Example: We generate a frequency (distribution) table for the length
%  (longest shell measurement) of the abalone Haliotis rugens (Bache and
%  Lichman, 2013). Original values were re-scaled by 200 to get mm (eg. 
%  0.455*200 = 91 mm). Data was taken from the Abalone Data Set of the UCI 
%  Machine Learning Repository, Center for Machine Learning and 
%  Intelligence Systems at 
%  https://archive.ics.uci.edu/ml/datasets/Abalone
%  As a didactical point-of-view, we use the Sturges rule and
%  Shimazaki-Shinomoto's method.
%
%  Calling on Matlab the function: 
%          fdt(x)
%
%  1. Using the Sturges' rule
%  Answer is:
%
%  Do you want to select the number of procedure classes from a menu (y/n)?: y
% 
%  Procedure menu:
%  1) Square root rule
%  2) 2 to the k rule
%  3) Rice rule
%  4) Sturges rule
%  5) Doane formula
%  6) Freedman-Diaconis rule
%  7) Scott rule
%  8) Shimazaki-Shinomoto method
% 
%  Which option do you want?: 4
% 
%  Frequency distribution table: No. of classes, c = 14
%  by the Sturges' rule
%  ---------------------------------------------------------------------------
%      LB          UB          CM          F        Fa        f         fa        
%  ---------------------------------------------------------------------------
%   15.0000     25.5714     20.2857        2         2      0.0005    0.0005
%   25.5714     36.1429     30.8571       30        32      0.0072    0.0077
%   36.1429     46.7143     41.4286       43        75      0.0103    0.0180
%   46.7143     57.2857     52.0000      112       187      0.0268    0.0448
%   57.2857     67.8571     62.5714      159       346      0.0381    0.0828
%   67.8571     78.4286     73.1429      294       640      0.0704    0.1532
%   78.4286     89.0000     83.7143      367      1007      0.0879    0.2411
%   89.0000     99.5714     94.2857      503      1510      0.1204    0.3615
%   99.5714    110.1429    104.8571      718      2228      0.1719    0.5334
%  110.1429    120.7143    115.4286      733      2961      0.1755    0.7089
%  120.7143    131.2857    126.0000      782      3743      0.1872    0.8961
%  131.2857    141.8571    136.5714      301      4044      0.0721    0.9682
%  141.8571    152.4286    147.1429      122      4166      0.0292    0.9974
%  152.4286    163.0000    157.7143       11      4177      0.0026    1.0000
%  ---------------------------------------------------------------------------
%  LB, lower boundaries;UB, upper boundaries;CM, class mark;F, absolut frequency;
%  Fa, cumulative absolut frequency;f, relative frequency;fa, cumulative relative
%  frequency.
%   
%  Do you want a graphic display for the tabulated data? (y/n)): y
%  Graph display menu:
%  1) Histogram
%  2) Frequency polygon
%  3) Absolut ogive
%  4) Relative ogive
%  5) All
% 
%  Which option do you want?: 5
%   [it gives a graphic display]
%
%  2. Using the Shimazaki-Shinomoto's method
%  Answer is:
%
%  Do you want to select the number of procedure classes from a menu (y/n)?: y
% 
%  Procedure menu:
%  1) Square root rule
%  2) 2 to the k rule
%  3) Rice rule
%  4) Sturges rule
%  5) Doane formula
%  6) Freedman-Diaconis rule
%  7) Scott rule
%  8) Shimazaki-Shinomoto method
% 
%  Which option do you want?: 8
% 
%  Frequency distribution table: No. of classes, c = 43
%  It was used the Shimazaki-Shinomoto's method.
%  ---------------------------------------------------------------------------
%      LB          UB          CM          F        Fa        f         fa        
%  ---------------------------------------------------------------------------
%   15.0000     18.4419     16.7209        1         1      0.0002    0.0002
%   18.4419     21.8837     20.1628        0         1      0.0000    0.0002
%   21.8837     25.3256     23.6047        1         2      0.0002    0.0005
%                      .  .  .  .  .  .  .  .  .
%                      .  .  .  .  .  .  .  .  .{37 more classes were omited}
%                      .  .  .  .  .  .  .  .  .
%  152.6744    156.1163    154.3953        9      4175      0.0022    0.9995
%  156.1163    159.5581    157.8372        0      4175      0.0000    0.9995
%  159.5581    163.0000    161.2791        2      4177      0.0005    1.0000
%  ---------------------------------------------------------------------------
%  LB, lower boundaries;UB, upper boundaries;CM, class mark;F, absolut frequency;
%  Fa, cumulative absolut frequency;f, relative frequency;fa, cumulative relative
%  frequency.
%   
%  Do you want a graphic display for the tabulated data? (y/n)): y
%  Graph display menu:
%  1) Histogram
%  2) Frequency polygon
%  3) Absolut ogive
%  4) Relative ogive
%  5) All
% 
%  Which option do you want?: 5
%   [it gives the graphic display appears in the front jpg image]
%
%  Created by A. Trujillo-Ortiz and R. Hernandez-Walls
%             Facultad de Ciencias Marinas
%             Universidad Autonoma de Baja California
%             Apdo. Postal 453
%             Ensenada, Baja California
%             Mexico.
%             atrujo@uabc.edu.mx
%
%  To cite this file, this would be an appropriate format:
%  Trujillo-Ortiz, A. and R. Hernandez-Walls (2014). fdt:Frequency
%     distribution table [WWW document]. URL http://www.mathworks.com/
%     matlabcentral/fileexchange/47955-fdt
%
%  First author thanks 2014-2 Statistics (Oceanology) and General Statistics
%  (Environmental Sciences) classes to encourage him to publish this 
%  m-function. Also thanks to Mohammad Abouali for him valuable comment on
%  some string functions.
%
%  Copyright (C) September 24, 2014.
%
%  References:
%  Bache, K. & Lichman, M. (2013), UCI Machine Learning Repository
%    [http://archive.ics.uci.edu/ml]. Irvine, CA: University of California, 
%    School of Information and Computer Science.
%  Shimazaki H. and Shinomoto S. (2007), A method for selecting the bin 
%    size of a time histogram Neural Computation, 19(6):1503-1527.
%

n = length(x);
disp(' ')
o = input('Do you want to select the number of procedure classes from a menu (y/n)?: ', 's');
if o == 'y'
    disp(' ')
    disp('Procedure menu:')
    disp('1) Square root rule')
    disp('2) 2 to the k rule')
    disp('3) Rice rule')
    disp('4) Sturges rule')
    disp('5) Doane formula')
    disp('6) Freedman-Diaconis rule')
    disp('7) Scott rule')
    disp('8) Shimazaki-Shinomoto method')
    disp(' ')
    option = input('Which option do you want?: ');
    disp(' ')
    switch option
        case 1,
            %option1: Square root rule
            c = ceil(sqrt(n));
            t = char('It was used the Square root''s rule.');
        case 2,
            %option2: 2 to the k rule
            c = 1;
            while 2^c < n;
                c = c + 1;
            end
            t = char('It was used the 2 to the k rule.');
        case 3,
            %option3: Rice rule
            c = ceil(2*n^(1/3));
            t = char('It was used the Rice''s rule.');
        case 4,
            %option4: Sturges rule
            c = ceil(1 + log2(n));
            t = char('It was used the Sturges'' rule.');
        case 5,
            %option5: Doane formula
            aG1 = abs(skewness(x,0));
            sG1 = sqrt((6*n*(n-1))/((n+1)*(n+3)*(n-2)));
            c = ceil(1 + log2(n) + log2(1+(aG1/sG1)));
            t = char('It was used the Doane''s formula.');
        case 6,
            %option6: Freedman-Diaconis rule
            a = 3.49*iqr(x)*n^(-1/3);
            c = ceil(range(x)/a);
            t = char('It was used the Freedman-Diaconis'' rule.');
        case 7,
            %option7: Scott rule
            s = std(x);
            a = 3.49*s*n^(-1/3);
            c = ceil(range(x)/a);
            t = char('It was used the Scott''s rule.');
        case 8,
            %option8: Shimazaki-Shinomoto method
            c = sshist(x);
            t = char('It was used the Shimazaki-Shinomoto''s method.');
    end
else
    c = input('Give me the number of classes you would like: ');
    t = char('It was used a specified number of classes.');
end

if c < 5
    disp('Warning:theory suggests it must be at least 5 classes. However,')
    disp('the number of classes obtained is presented.') 
end

[F CM] = hist(x,c); %absolute frequency and classes mark vectors
no = F;
xo = CM;
a = (CM(end)-CM(1))/(c-1); %bin (class) width

%lower boundaries
LB = [];
for i = 1:c
    lb = CM(i)-0.5*a;
    LB = [LB lb];
end

%upper boundaries
UB = [];
for i = 1:c
    ub = CM(i)+0.5*a;
    UB = [UB ub];
end

Fa = cumsum(F); %cumulative absolute frequency
f = F./n; %relative frequency
fa = cumsum(f); %cumulative relative frequency

D = [LB' UB' CM' F' Fa' f' fa'];

disp('   ')
fprintf('Frequency distribution table: No. of classes, c = %i\n',c)
fprintf('%s\n', char(t)) %I thank Mohammad Abouali for him valuable comment
fprintf('---------------------------------------------------------------------------\n');
disp('    LB          UB          CM          F        Fa        f         fa        ');
fprintf('---------------------------------------------------------------------------\n');
for k = 1:c
    fprintf('%8.4f%12.4f%12.4f%9i%10i%12.4f%10.4f\n',D(k,1),D(k,2),D(k,3),D(k,4),D(k,5),D(k,6),D(k,7));
end
fprintf('---------------------------------------------------------------------------\n');
disp('LB, lower boundaries;UB, upper boundaries;CM, class mark;F, absolut frequency;')
disp('Fa, cumulative absolut frequency;f, relative frequency;fa, cumulative relative') 
disp('frequency.')
disp('   ')
g = input('Do you want a graphic display for the tabulated data? (y/n)): ', 's');
if g == 'y'
    disp('Graph display menu:')
    disp('1) Histogram')
    disp('2) Frequency polygon')
    disp('3) Absolut ogive') 
    disp('4) Relative ogive')
    disp('5) All')
    disp(' ')
    option = input('Which option do you want?: ');
    disp(' ')
    figure('Name',t)
    switch option
        case 1,
            %option1: Histogram
            hist(x,c)
            ttl = sprintf('Histogram of given data. %s', t);
            title(ttl)
            xlabel('C l a s s e s (c)')
            ylabel('Absolut frequencies (F)')
        case 2,
            %option2: Frequency polygon
            plot(CM,F,'r-',CM,F,'k.')
            ttl = sprintf('Frequency polygon of given data. %s', t);
            title(ttl)
            xlabel('C l a s s  m a r k s (CM)')
            ylabel('Absolut  frequencies (F)')
        case 3, 
            %option3: Absolut ogive 
            plot(CM,Fa,'r-') 
            ttl = sprintf('Absolut ogive of given data. %s', t);
            title(ttl) 
            xlabel('C l a s s  m a r k s (CM)') 
            ylabel('Absolut cumulative frequencies (Fa)') 
        case 4, 
            %option4: Relative ogive 
            hold on;
            ecdf(x)
            plot(CM,fa,'r-',[0;CM'],0.5*ones(1,c+1),'k--')
            h = legend('Empirical cdf','Observed cdf',2);
            set(h,'Interpreter','none')
            ttl = sprintf('Relative ogive of given data. %s', t);
            title(ttl) 
            xlabel('C l a s s  m a r k s (CM)') 
            ylabel('Relative cumulative frequencies (fa)')
            hold off;            
        case 5, 
            %option5: All
            subplot(2,2,1)
            hist(x,c)
            title('Histogram of given data.')
            xlabel('C l a s s e s (c)')
            ylabel('Absolut frequencies (F)')
            subplot(2,2,2)
            plot(CM,F,'r-',CM,F,'k.')
            title('Frequency polygon of given data.')
            xlabel('C l a s s  m a r k s (CM)')
            ylabel('Absolut  frequencies (F)')
            subplot(2,2,3)
            plot(CM,Fa,'r-') 
            title('Absolut ogive of given data.') 
            xlabel('C l a s s  m a r k s (CM)') 
            ylabel('Absolut cumulative frequencies (Fa)') 
            subplot(2,2,4)
            hold on;
            ecdf(x)
            plot(CM,fa,'r-',[0;CM'],0.5*ones(1,c+1),'k--') 
            h = legend('Empirical cdf','Observed cdf',2);
            set(h,'Interpreter','none')
            title('Relative ogive of given data.') 
            xlabel('C l a s s  m a r k s (CM)') 
            ylabel('Relative cumulative frequencies (fa)')
            hold off;
            sttl = sprintf('Display of the requested graphs. %s', t);
            subtitle(sttl);
    end
end

if nargout > 0
    y = [CM' F'];
else
end

function [ax,h] = subtitle(text)
%Centers a title over a group of subplots.
%Returns a handle to the title and the handle to an axis.
% [ax,h]=subtitle(text)
%returns handles to both the axis and the title.
% ax=subtitle(text)
%returns a handle to the axis only.
ax = axes('Units','Normal','Position',[.1 .1 .85 .85],'Visible','off');
set(get(ax,'Title'),'Visible','on');
title(text);
if (nargout < 2)
    return
end
h = get(ax,'Title');


return,