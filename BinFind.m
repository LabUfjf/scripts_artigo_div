function [ bins ] = BinFind(x1,x2)

ind=[];
ind=find(x2>=min(x1) & x2<=max(x1));
bins=length(ind);

end

