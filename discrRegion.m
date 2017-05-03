function [ x1,y1] = discrRegion( x,y )

%%=========================================================================
%% Função definir as regiões HEAD, DERIV e TAIL
%%=========================================================================
%% Entradas:
%           x - Struct contendo o eixo x da função análitica
%           y   - Struct contento o eixo y da função análitica
%           
%% Saída:
%           x      - Struct contendo o eixo x da função análitica para cada
%           regiao
%           y      - Struct contendo o eixo y da função análitica para cada
%           regiao
%           ind    - Struct contendo os indices de head, deriv e tail 
%%
pct.tail=0.01;
pct.head=0.90;

maxY=max(y);

ind.tail=find(y<maxY*pct.tail);
ind.head=find(y>=maxY*pct.head);

indunion=union(ind.tail,ind.head);
ind.deriv=setdiff(1:length(y),indunion);

x1.head=x(ind.head);
x1.tail=x(ind.tail);
x1.deriv=x(ind.deriv);
x1.all=x;

y1.head=y(ind.head);
y1.tail=y(ind.tail);
y1.deriv=y(ind.deriv);
y1.all=y;
end

