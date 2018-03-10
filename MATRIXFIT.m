function [dxfit,Pfit,Qfit]=MATRIXFIT(xgrid,P,Q)

Ndiv  = size(P,1);
Qline=Q(:);
Pline=P(:);
dxline=xgrid(:);
IND = find(P-Q~=0);
Nfit = round(length(IND)/Ndiv);
Pfit = reshape(Pline(IND),Nfit,Ndiv)';
Qfit =  reshape(Qline(IND),Nfit,Ndiv)';
dxfit =  reshape(dxline(IND),Nfit,Ndiv)';
Pfit=Pfit(:,1:end-1)';
Qfit=Qfit(:,1:end-1)';   
dxfit = diff(dxfit');

end