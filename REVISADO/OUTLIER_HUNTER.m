function [SET,D] = OUTLIER_HUNTER(DATA, method,s)

[~,~,D]=k_means(DATA',1);

if strcmp(method,'Zscore')
    Z_Score=abs((D-median(D))/stdRobust(D,'MAD'));
    SET=Z_Score>s;
end

if strcmp(method,'ZscoreSn')
    Z_Score=abs((D-median(D))/stdRobust(D,'Sn'));
    SET=Z_Score>s;
end

if strcmp(method,'Std')
    Z_Score=abs((D-mean(D))/std(D));
    SET=Z_Score>s;
end

if strcmp(method,'CDF')
    [TH] = STDPCT(s);
    [SET] = ecdfepdf(D,TH);
end


end
