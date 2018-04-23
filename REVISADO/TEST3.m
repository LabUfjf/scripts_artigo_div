% function [] = TEST3()

%% DEBUG DIVERGENCIAS
close; clc; clear;

TYPE = 'sg';

ROI = 'dist';
INT = 'linear';
NORM = 'full';

NGRID = 1e5;
NEST = 1000;
NROI = 100;
% for DIV = {'Linf','L2N','Gower','Hellinger','Euclidean','Squared','AddSym','Kullback','Taneja','Kumar'}
% for DIV = {'Pearson','Sorensen','IP','Harmonic','Cosine'};
for DIV = {'Harmonic'}
    for NOISE = {'normal','poisson'};
        for name = {'Gaussian'};
            % for name = {'Gaussian','Bimodal','Rayleigh','Logn','Gamma'};
            [setup] = IN(name{1},TYPE,NOISE,ROI,INT,NORM,1,NGRID,NEST,NROI); % Definir os Parâmetros Iniciais
            [DATA] = datasetGenSingle(setup);                                           % Gerar os Dados à partir desses Parâmetros
            %             pause
            [X.EST,X.GRID,Y.EST,Y.GRID,Y.TRUTH] = Method_ADDNoise(setup,DATA,setup.RANGE.NOISE(end));
%             MD_DEBUG(X.GRID,Y.GRID,Y.TRUTH,DIV,'do');
%             set(gcf, 'Position', get(0, 'Screensize'));
%             saveas(gcf,[pwd '\TEST3\TEST3[' name{1} ']NOISE[' NOISE{1} ']DIV[' DIV{1} ']NORM[' NORM ']NORMDIV[do][end]'],'png')
%             %                          saveas(gcf,[pwd '\TEST3\TEST3[' name{1} ']NOISE[' NOISE{1} ']DIV[' DIV{1} ']NORM[' NORM ']NORMDIV[do][end]'],'fig')
%             close
            MD_DEBUG(X.GRID,Y.GRID,Y.TRUTH,DIV,'no');
            set(gcf, 'Position', get(0, 'Screensize'));
            saveas(gcf,[pwd '\TEST3\TEST3[' name{1} ']NOISE[' NOISE{1} ']DIV[' DIV{1} ']NORM[' NORM ']NORMDIV[no][end]'],'png')
            %                                      saveas(gcf,[pwd '\TEST3\TEST3[' name{1} ']NOISE[' NOISE{1} ']DIV[' DIV{1} ']NORM[' NORM ']NORMDIV[no][end]'],'fig')
            close
            %             pause
        end
        
    end
end




