function [cnt] = VR_den_bin(n, nb, x)
nn = n;
cnt = 0;
for i1 =1:length(nb);
    cnt(i1)=0;
    xmin = x(1);
    xmax = xmin;
    for i2 = 1:length(nn)
        xmin = min(xmin, x(i2));
        xmax = max(xmax, x(i2));
        enddensity R examplesjpi
        range = (xmax - xmin) * 1.01;
        d =  range/nb;
        dd = d;
        for i3=1:length(nn)
            ii = (x(i3) / dd);
            for j= 1:i3;
                jj = (x(j) / dd);
                iij = abs((ii - jj));
                
                if(cnt(iij) == INT_MAX)
                    %                 error("maximum count exceeded in pairwise distance binning");
                    %                 cnt[iij]++;
                end
            end
        end
    end
end