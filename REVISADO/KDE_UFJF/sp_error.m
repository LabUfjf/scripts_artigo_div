function [bsp,erroSP] = sp_error(ef,fa,datae,dataj)

for h=1:1:length(fa)
    sp(h)=sqrt((sqrt(ef(h)*(1-fa(h)))*((ef(h)+(1-fa(h)))/2)));
end

[bsp,i] = max(sp);
bsp=bsp*100;
ef=100*ef(i);
fa=100*(1-fa(i));

%% ERRO
[~,bm_ef]=binofit((ef/100)*(datae),(datae));
eim_ef=ef-bm_ef(1);
esm_ef=bm_ef(2)-ef;

e_ef=((eim_ef+esm_ef)/2)*100;

[~,bm_fa]=binofit((fa/100)*(dataj),(dataj));
eim_fa=fa-bm_fa(1);
esm_fa=bm_fa(2)-fa;

e_fa=((eim_fa+esm_fa)/2)*100;

%% Calculo da propagação do Erro

soma=(ef+fa);
somadiv=soma/2;
multi=ef*fa;
raizmulti=sqrt(multi);
multi2=raizmulti*somadiv;
raizmulti2=sqrt(multi2);

% SOMA

errosoma=sqrt(e_ef^2+e_fa^2);
errosomadiv=errosoma/2;

% Multiplicação

erromulti=multi*sqrt((e_ef/ef)^2+(e_fa/fa)^2);

erroraizmulti=(1/2)*(erromulti/multi)*raizmulti;

erromulti2=multi2*sqrt((erroraizmulti/raizmulti)^2+(errosomadiv/somadiv)^2);

erroraizmulti2=(1/2)*(erromulti2/multi2)*raizmulti2;

erroSP=erroraizmulti2;


