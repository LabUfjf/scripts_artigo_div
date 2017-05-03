function [Num,Den,DivValue] = NumDenDiv(P,Q)

A.Linf = max(abs(P-Q));  
LInf = A.Linf;

A.L2 =sqrt(sum((P-Q).^2)); 
LP.L2 = A.L2;

A.Sorensen = sum(abs(P-Q));
B.Sorensen = (sum(abs(P+Q)));
L1.Sorensen = A.Sorensen/B.Sorensen;

A.Gower = (sum(abs(P-Q)));
L1.Gower = A.Gower/length(P);

A.Innerproduct = sum(P.*Q);
IP.Innerproduct = A.Innerproduct/length(P);

A.Harmonic = sum((P.*Q)/(P+Q));
IP.Harmonic = 2*A.Harmonic;

A.Cosine = sum(P.*Q);
B.Cosine = sqrt(sum(P.^2))*sqrt(sum(Q.^2));
IP.Cosine = (1-(A.Cosine/B.Cosine));

A.Hellinger = sqrt((2*sum((sqrt(P)-sqrt(Q)).^2))/length(P));
SQ.Hellinger = A.Hellinger;

A.Squared = sum(((P-Q).^2)./(P+Q));
L2.Squared = sum(((P-Q).^2)./(P+Q));

A.AddSym = sum((((P-Q).^2).*((P+Q)))/(P.*Q));
L2.AddSym = A.AddSym;

A.Kullback = (sum(P.*log((P./Q))));
SH.Kullback = A.Kullback;

A.Kumar = sum(((P.^2-Q.^2).^2)./(2*(P.*Q).^(3/2)));
CO.Kumar = A.Kumar;

Num(1) = A.Linf;  
Num(2) = A.L2;
Num(3) = A.Sorensen;
Num(4) = A.Gower;
Num(5) = A.Innerproduct; 
Num(6) = A.Harmonic;
Num(7) = A.Cosine;
Num(8) = A.Hellinger;
Num(9) = A.Squared;
Num(10) = A.AddSym;
Num(11) = A.Kullback;
Num(12) = A.Kumar;

Den(1) = NaN;  
Den(2) = NaN;
Den(3) = B.Sorensen;
Den(4) = NaN;
Den(5) = NaN;
Den(6) = NaN;
Den(7) = B.Cosine;
Den(8) = NaN;
Den(9) = NaN;
Den(10) = NaN;
Den(11) = NaN;
Den(12) = NaN;

DivValue = [LInf LP.L2 L1.Sorensen L1.Gower IP.Innerproduct IP.Harmonic IP.Cosine SQ.Hellinger L2.Squared L2.AddSym SH.Kullback CO.Kumar];

end