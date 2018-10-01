function [Sn]=stdRobust(X,method)


if strcmp(method,'Sn')
    cf =1.1926;
    n = length(X);
    % Set c: bias correction factor for finite sample size
    if n < 10
        cc = [NaN 0.743 1.851 0.954 1.351 0.993 1.198 1.005 1.131];
        c = cc(n);
    elseif mod(n,2)==0 % is odd
        c = n/(n-.9);
    else % is even
        c = 1;
    end
    % compute median difference for each element
    tmp = nan(n,1);
    for i = 1:n
        tmp(i) = median(abs(X(i) - X([1:i-1 i+1:end])));
    end
    % compute median of median differences, and apply finite sample correction
    Sn = c *cf* median(tmp);
end

if strcmp(method,'Qn')
    cf = 2.21914;
    n = length(X);
    % Set c: bias correction factor for finite sample size
    if n < 10
        cc = [NaN 0.743 1.851 0.954 1.351 0.993 1.198 1.005 1.131];
        c = cc(n);
    elseif mod(n,2)==0 % is odd
        c = n/(n-.9);
    else % is even
        c = 1;
    end
    h=[n/2]+1;
    k=round((h*(h-1))/2);
    % compute median difference for each element
%     tmp = nan(n,1);
    for i = 1:n
        tmp(i,:) = abs(X(i) - X([1:i-1 i+1:end]));        
    end
    tmp=tmp(:);
    % compute median of median differences, and apply finite sample correction
    
    m = moment(X,k);
    Sn = c *cf* m;
end

if strcmp(method,'MAD')
    Sn = mad(X);
end

end

