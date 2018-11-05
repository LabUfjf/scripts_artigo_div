function [DADOS,hmin]=hCV2(DATA)

DADOS = sort(DATA.sg.evt);

syms u
n=length(DADOS);
r=0;
type = 'Gaussian';
[dk] = kernel_fun_der(type,r);
[d2k] = kernel_fun_der(type,2*r);
cK = kernel_fun_conv(type,r);
Rdk = Rg(dk);
FUCV = matlabFunction(cK-2*d2k);
[ho]=h_hunter(DATA,[],'SV');
vh = linspace(0.01*ho,10*ho,300);
e = range(DATA.sg.evt)/10;
wb=waitbar(0,'Aguarde...')
for i=1:n
    x = DADOS(DADOS>DADOS(i)-e & DADOS<DADOS(i)+e);
    
    [F] = fastM(x);
    if length(x) >5
        for j=1:length(vh)
            h = vh(j);
            S(j)=sum(sum(FUCV((F/h))));
            CV(j)=(Rdk*(1/(n*h^((2*r)+1))))+((-1)^r / ((n-1)*h^((2*r)+1)))*S(j);
        end
        hmin(i)=vh(find(CV==min(CV)));
        clear CV
    else
        hmin(i)=NaN;
    end
    waitbar(i/n)
    
end
close(wb)


