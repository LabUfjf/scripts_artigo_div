function [V] = SH_family(xgrid,P,Q)

dx = diff(xgrid);
dx = dx(1);

SHf=(Q.*log((Q./P)));
SH.Kullback = sum(SHf(~isnan(SHf)&~isinf(SHf)))*dx;

V = (cell2mat(struct2cell(SH))');
    
end