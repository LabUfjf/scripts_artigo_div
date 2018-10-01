function [MCV] =KDECV(DATA,nGRID,h,METHOD)
KFUNCTION = 'Gaussian';

[nd,n,DATA]= format_data(DATA);

CVO = cvpartition(DATA,'LeaveOut');
err = zeros(CVO.NumTestSets,1);

if nd ==1
    for j = 1:CVO.NumTestSets
        [V(j)] = sum(fastModule(DATA(CVO.training(j)),nGRID,h,KFUNCTION,METHOD));
    end
else
end
MCV=(1/n)*sum(V)-log((n-1)*h);
end

function [nd,n,data]= format_data(data)

[nd,n] = size(data);

if nd>n
    data = data';
    [nd,n] = size(data);
end

end

% CV = (n^-1)*sum(log(KDEflex(DATA,nGRID,h,METHOD)))-log((n-1)*h);




