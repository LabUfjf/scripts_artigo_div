function [Num,Den,DivValue] = DivTest(P,Q)

        
[Num(1,:),Den(1,:),DivValue(1,:)]=NumDenDiv(P.head,Q.head);
[Num(2,:),Den(2,:),DivValue(2,:)]=NumDenDiv(P.deriv,Q.deriv);
[Num(3,:),Den(3,:),DivValue(3,:)]=NumDenDiv(P.tail,Q.tail);
[Num(4,:),Den(4,:),DivValue(4,:)]=NumDenDiv(P.all,Q.all);


end