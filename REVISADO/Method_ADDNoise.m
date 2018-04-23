function [xest,xgrid,yest,ygrid,ytruth] = Method_ADDNoise(setup,DATA,f)
%==========================================================================
% Objetivo: * Adicionar Diferentes Tipos de Ruído por RoI
%           * Fazer Normalização adequada
%           * Estipular a Estimação escolhida
%==========================================================================
%% => Definir os índices
xRoI=cell2mat(DATA.sg.RoI.x);
yRoI=cell2mat(DATA.sg.RoI.y);
[IndRoI] = INDGEN(DATA.sg.pdf.truth.x,setup.DIV);
%% => Estimar e adicionar ruído
xest = linspace(min(xRoI),max(xRoI),setup.EST);
yest = GridNew(DATA.sg,xest,setup.TYPE.NAME);
signal = noiseADD(xest,yest,f,setup.TYPE.NOISE);
%% => Definir o Grid após a estimação
xgridM = xRoI(IndRoI)';
ygridM = interp1(xest,signal,xgridM,setup.TYPE.INTERP,'extrap');

%% => Organizar os resultados em matriz de acordo com as especificações do setup
if setup.DIV == 1
    xgrid = DATA.sg.pdf.truth.x;
    ygrid = interp1(xest,signal,xgrid,setup.TYPE.INTERP,'extrap');
    ytruth = DATA.sg.pdf.truth.y;
else
    if strcmp(setup.TYPE.NORM,'full')
        MyRoI = repmat(yRoI,setup.DIV,1);
        MxRoI = repmat(xRoI,setup.DIV,1);
        for i=1:setup.DIV
            MyRoI(i,IndRoI(:,i)) = ygridM(i,:);
        end
        [~,ind]=sort(xRoI);
        xgrid = MxRoI(:,ind);
        ygrid = MyRoI(:,ind);
        ytruth = GridNew(DATA.sg,xgrid,setup.TYPE.NAME);
    end
    if strcmp(setup.TYPE.NORM,'fit')
        for i=1:setup.DIV
            MyRoI(i,:) = ygridM(i,:);
        end
        xgrid = xRoI(IndRoI)';
        ygrid = MyRoI;
        ytruth = GridNew(DATA.sg,xgrid,setup.TYPE.NAME);
    end
end

end