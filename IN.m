function [setup] = IN(N,PTS)
setup.EVT = N;
setup.BLOCKS = 1; % truth
setup.DIV = 50;    % número de divisões
setup.PTS = PTS; % truth
setup.Div.L=10; 
setup.Div.S=2; 
setup.Div.D=5; % Garantir que os parâmetros estejam iguais ao fastKDE
end