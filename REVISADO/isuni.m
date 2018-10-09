function tf = isuni(fz,places)
%===================== QUICK CHECK FOR UNIMODALITY =============================
%
% tf = isuni(fz), where fz is a set of function values for increasing x, returns
% true if fz is unimodal, false otherwise
%
% tf = isuni(fz,places) rounds fz to places decimal places before checking.
% This helps to avoid tiny bumps being treated as genuine modes.

if nargin==2
    fz = round(10^(places)*fz)/10^places;
end

d = diff(fz);
d(d==0) = [];
chgs = sum(diff(sign(d))~=0);       %-Number of sign changes.

tf = chgs<=1;                       %-Chgs could be 0 for monotone, 1 for 
                                    % unimodal.
    
end
