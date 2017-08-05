function [setup] = IN(N)
setup.EVT = N;
setup.DIV = 1;    % número de divisões
setup.PTS = 100000; % truth
setup.Div.L=10; 
setup.Div.S=2; 
setup.Div.D=5; % Garantir que os parâmetros estejam iguais ao fastKDE
end