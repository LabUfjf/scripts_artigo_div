function [setup] = IN(N,PTS)
setup.EVT = N;
setup.BLOCKS = 1; % truth
setup.DIV = 50;    % n�mero de divis�es
setup.PTS = PTS; % truth
setup.Div.L=10; 
setup.Div.S=2; 
setup.Div.D=5; % Garantir que os par�metros estejam iguais ao fastKDE
end