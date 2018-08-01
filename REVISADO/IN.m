function [setup] = IN(NAMEtype,DATAtype,NOISEtype,ROItype,INTERPtype,NORMtype,NEVT,NGRID,NEST,NROI)

%==========================================================================
% Objetivo: Definir os par�metros iniciais de an�lise
%==========================================================================
setup.TYPE.NAME = NAMEtype;      % Qual tipo de PDF (Ex: 'Gaussian','Uniform','Rayleigh','Gamma','LogN' e 'Bimodal');
setup.TYPE.DATA = DATAtype;      % Qual tipo de Dado (Ex: 'sg' ou 'bg');
setup.TYPE.NOISE = NOISEtype;    % Qual tipo de Ru�do (Ex:'poisson','normal','noisemix','none','bias')
setup.TYPE.ROI = ROItype;        % Qual tipo de RoI (Ex:'dist','prob','deriv','deriv2');
setup.TYPE.INTERP = INTERPtype;  % Qual tipo de interpola��o ser� utilizada (Ex: 'linear','nearest');
setup.TYPE.NORM = NORMtype;      % Qual tipo de normaliza��o ser� utilizada (Ex: 'fit','full','bypass');
setup.EVT = NEVT;                % N�mero de eventos que ser�o gerados;
setup.PTS = NGRID;             % N�mero de ponto que a PDF anal�tica ter�;
setup.EST = NEST;                % N�mero de pontos da PDF estimada;
setup.DIV = NROI;                % N�mero de divis�es das Regi�es de Interesse;
% setup.ROIBG =unique(sort(randi(NROI,1,10)));
setup.ROIBG =floor(linspace(1,NROI,10));
setup = SETrange(setup);         % Carregar o Range do Ru�do;
setup.MINMAX.STD = 4;            % STD para escolher o range das PDFs.  
setup.TYPE.MD ={'Pearson','L\infty','L2','Sorensen','Gower','IP','Harmonic','Cosine','Hellinger','Sq Euclidean','Sq \chi�','AS \chi�','KL','Taneja','KJ'};
end