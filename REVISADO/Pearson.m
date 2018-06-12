function [Prs] = Pearson(P,Q,mod)

C = corr(P,Q,'Type','Pearson')'; 
Prs = ar(C(1,:),mod);

end