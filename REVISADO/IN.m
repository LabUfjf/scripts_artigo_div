function [setup] = IN(NAMEtype,DATAtype,NOISEtype,ROItype,INTERPtype,NORMtype,NEVT,NGRID,NEST,NROI)

%==========================================================================
% Objetivo: Definir os parâmetros iniciais de análise
%==========================================================================
setup.TYPE.NAME = NAMEtype;      % Qual tipo de PDF (Ex: 'Gaussian','Uniform','Rayleigh','Gamma','LogN' e 'Bimodal');
setup.TYPE.DATA = DATAtype;      % Qual tipo de Dado (Ex: 'sg' ou 'bg');
setup.TYPE.NOISE = NOISEtype;    % Qual tipo de Ruído (Ex:'poisson','normal','noisemix','none','bias')
setup.TYPE.ROI = ROItype;        % Qual tipo de RoI (Ex:'dist','prob','deriv','deriv2');
setup.TYPE.INTERP = INTERPtype;  % Qual tipo de interpolação será utilizada (Ex: 'linear','nearest');
setup.TYPE.NORM = NORMtype;      % Qual tipo de normalização será utilizada (Ex: 'fit','full','bypass');
setup.EVT = NEVT;                % Número de eventos que serão gerados;
setup.PTS = NGRID;             % Número de ponto que a PDF analítica terá;
setup.EST = NEST;                % Número de pontos da PDF estimada;
setup.DIV = NROI;                % Número de divisões das Regiões de Interesse;
% setup.ROIBG =unique(sort(randi(NROI,1,10)));
setup.ROIBG =floor(linspace(1,NROI,10));
setup = SETrange(setup);         % Carregar o Range do Ruído;
setup.MINMAX.STD = 4;            % STD para escolher o range das PDFs.  
setup.TYPE.MD ={'Pearson','L\infty','L2','Sorensen','Gower','IP','Harmonic','Cosine','Hellinger','Sq Euclidean','Sq \chi²','AS \chi²','KL','Taneja','KJ'};
end