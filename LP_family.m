function [V] = LP_family()

dx = diff(xgrid);
dx = dx(1);

LP.LInf = max(abs(P-Q));
LP.L2N = (sqrt(sum((P-Q).^2)))*dx;

V = (cell2mat(struct2cell(LP))');
    
end