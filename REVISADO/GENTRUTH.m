function [bin,Cmean,nbin] = GENTRUTH(name,nEVT,binmax,method)

tag = ['[BINTRUTH][' name '][' num2str(nEVT) '][' num2str(binmax) '][' method ']'];

if exist([pwd '\TRUTH\' tag '.mat'], 'file')
    load([pwd '\TRUTH\' tag]);
    disp('Arquivo Encontrado. Carregando...')
else
    disp('Criando Arquivo...')
    norm = 'fit';
    errortype = 'none';
    ntmax=100;
    nEST = 2;
    nROI = 1;
    nGRID = 10^5;
    inter = 'nearest';
    wb=waitbar(0,['Aguarde[' name ']']);
    Csum = 0;
    for i=1:ntmax
        [setup] = IN(name,'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
        [DATA] = datasetGenSingle(setup);
        if strcmp(method,'HIST')
            [~,C,nbin]=bintruth(DATA,binmax);
        end
        if strcmp(method,'ASH')
            [~,C,nbin]=ASHtruth(DATA,binmax);
        end
        waitbar(i/ntmax)
        Csum = Csum + C;
    end
    close(wb)
    Cmean = Csum/ntmax;
    % ind = find(Cmean==min(Cmean));
    % bin = nbin(ind);
    in0 = 8;
    fitmodel=fit(nbin(in0:end)',Cmean(in0:end)','smoothingspline','smoothingparam',0.3);
    binR = nbin(in0:end);
    V=fitmodel(binR);
    % plot(fitmodel,binR,Cmean(in0:end))
    ind = find(V==min(V));
    bin = binR(ind);
    
    save([pwd '\TRUTH\' tag],'bin','Cmean','nbin')
end


end