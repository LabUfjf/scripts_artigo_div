% TEST DISTRIBUIÕES
clear variables;  clc; close all;
%=========================================================================
% TESTANDO TODAS AS DISTRIBUIÇÕES QUE SERÃO UTILIZADAS NA TESE
%=========================================================================
norm = 'fit';
inter = 'linear';
errortype = 'none';
mod = 'abs';
j=0;
cl = ['yrbgkmc'];
ntmax=2000;
% for name = {'Gaussian','Bimodal','Trimodal','Rayleigh','Logn','Gamma','Laplace'};
%     j=j+1;
for   name = {'Gaussian'};
    wb=waitbar(0,'Aguarde...');
    for i=1:ntmax
        nEVT = 5000;
        nEST = 10;
        nROI = 1;
        nGRID = 10^5;
       
        [setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
        [DATA] = datasetGenSingle(setup);
        s(i)=std(DATA.sg.evt);
        [bin_scott(i)]=calcnbins([reshape(DATA.sg.evt,length(DATA.sg.evt),1)],'scott');
%         [BIN_truth(i)]=bintruth(DATA,[],'nearest');
        waitbar(i/ntmax)
    end
end
close(wb)



histogram(bin_scott); hold on
% histogram(BIN_truth);
legend('Scott','Truth')