function [setup] = IN(N)
setup.EVT = N;
setup.BLOCKS = 40; % truth
setup.DIV = 10;    % n�mero de divis�es
setup.PTS = 100000; % truth
setup.Div.L=10; 
setup.Div.S=2; 
setup.Div.D=5; % Garantir que os par�metros estejam iguais ao fastKDE
end