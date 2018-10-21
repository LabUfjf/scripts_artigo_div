function [F] = fastM(x)
XM=repmat(x,1,length(x));
XD=repmat(x',length(x),1);
XO = XD-XM;
remove_diagonal = @(t)reshape(t(~diag(ones(1,size(t, 1)))), size(t)-[1 0]);
F=remove_diagonal(XO);
end