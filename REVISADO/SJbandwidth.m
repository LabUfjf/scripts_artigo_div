function hout = SJbandwidth(x)
% hout = SJbandwidth(x)
%
% Sheather and Jones(1991) bandwidth selection for kernel density estimation.
%
% Reference: Wand and Jones (1995) pp.74-75, see also appendix C for calculation helps
% with normal densities.

%Note, this function was originally based on a function bandwidth_SJ, written by
%Taesam Lee, that was downloaded from the MATLAB file exchange.  But it has been
%changed the point that it doesn't resemble the original any more.  Most
%importantly:
% - using only the normal case, removed 2nd argument.
% - replaced symbolic computation with numeric approximation (it is faster this way).

%coefficients of Hermite polynomials up to H8.  Hj(x) = H(j,:)*x.^(0:8)
H = [[   1    0    0    0    0    0    0    0    0];
    [   0    1    0    0    0    0    0    0    0];
    [  -1    0    1    0    0    0    0    0    0];
    [   0   -3    0    1    0    0    0    0    0];
    [   3    0   -6    0    1    0    0    0    0];
    [   0   15    0  -10    0    1    0    0    0];
    [ -15    0   45    0  -15    0    1    0    0];
    [   0 -105    0  105    0  -21    0    1    0];
    [ 105    0 -420    0  210    0  -28    0    1]];


%fcn to calc the Hermite polynomial (vectorized across x)
    function val = HP(y,r)
        %     val = zeros(size(y));
        %     for j = 1:length(val)
        %         val(j) = H(r+1,:)*(y(j).^(0:8)');
%         val = (H(r+1,:)*(repmat(A,1,9).^repmat(0:8,length(A),1))')';       
        
          val = (H(r+1,:)*(repmat(y,1,9).^repmat(0:8,length(y),1))')';
        %     end
    end

%fcn to get rth derivatives of std normal distributions.
dNr = @(y,r) (-1)^r*HP(y,r).*normpdf(y);

%Estimate sigma
sighat = std(x);

%Get required derivatives of fk at zero.  See Appendix C for fmlas.
fk_der4_0 = dNr(0,4);
fk_der6_0 = dNr(0,6);

% RK = quad('normpdf(x).^2',-5,5);
RK = 0.28209;
mu2 = 1;                                %-2nd moment of normal kernel.

n=length(x);

%STEP 1
Psi8_NS=105/(32*pi^(1/2)*sighat^9);

%STEP 2
g1 = (-2*fk_der6_0/(mu2*Psi8_NS*n))^(1/9);
Psi6 = 0;
for i = 1:n
    Psi6 = Psi6 + (1/n^2)*sum(dNr((x-x(i))/g1,6))/g1^7;
end

%STEP 3
g2 = (-2*fk_der4_0/(mu2*Psi6*n))^(1/7);
Psi4 = 0;
for i = 1:n
    Psi4 = Psi4 + (1/n^2)*sum(dNr((x-x(i))/g2,4))/g2^5;
end

%STEP 4
hout=(RK/(mu2^2*Psi4*n))^(1/5);


end