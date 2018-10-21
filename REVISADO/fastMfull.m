function [F] = fastMfull(x)
XM=repmat(x,1,length(x));
XD=repmat(x',length(x),1);
F = XD-XM;
end