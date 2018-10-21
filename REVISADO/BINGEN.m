function [bin,DATA] = BINGEN(name,out,nEVT,errortype,inter,norm,nGRID,nEST,nROI)


[binload,~,~] = GENTRUTH(name{1},round(nEVT),100,'HIST');
[setup] = IN(name{1},'sg',errortype,'dist',inter,norm,nEVT,nGRID,nEST,nROI);   % Definir os Parâmetros Iniciais
[DATA] = datasetGenSingle(setup);
[bin,C]=calcnbins([reshape(DATA.sg.evt,length(DATA.sg.evt),1); out],'all');
[bin.truth] = binload;


end