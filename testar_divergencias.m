sd = 0.00001;

noise=sd*randn(1,length(sg.gauss.pdf.y.eq.all));

Ax=sg.gauss.pdf.x.eq.all;
Ay=sg.gauss.pdf.y.eq.all;
By=sg.gauss.pdf.y.eq.all+noise;


Cx=sg.gauss.pdf.x.eq.tail;

[~,tail]=ismember(Cx,Ax);

Cy=sg.gauss.pdf.y.eq.tail;
Dy=sg.gauss.pdf.y.eq.tail+noise(tail);

figure

plot(Ax,By,'.r')
hold on; 
plot(Ax,Ay,'.b')
hold on
plot(Cx,Dy,'.m')
plot(Cx,Cy,'.k')

E=DFSelect(Ay,By);
F=DFSelect(Cy,Dy);

for i=1:length(Ay)
    f1(i)=(Ay(i)/By(i));
    f2(i)=log(f1(i));
    f3(i)=Ay(i)*f2(i);
%     f4(i)=(Ay(i)*By(i));
%     f5(i)=f3(i)/f4(i);
% %      f6=DFSelect(Ay(i),By(i)); f7(i)=f6(10);
%     pause
%     disp('===================================')
end


sum(f3)

figure
plot(Ax,f1,'.k','DisplayName','(P-Q)^2')
hold on
plot(Ax,f2,'.r','DisplayName','(P+Q)')
plot(Ax,f3,'.c','DisplayName','((P-Q)^2)*(P+Q)')
plot(Ax,f4,'.b','DisplayName','(P*Q)')
plot(Ax,f5,'.m','DisplayName','(((P-Q)^2)*(P+Q))/(P*Q))')
legend show