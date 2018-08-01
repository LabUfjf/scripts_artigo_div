% TEST LINEARIDADE
clear variables;  clc; close all;
%=========================================================================
% DESCRIÇÃO:
% Esse teste tem como intuito a linearidade entre o valor das divergências
% com "1" RoI e "N" RoIs
%=========================================================================
% PARÂMETROS INICIAIS - ADDSYM
%=========================================================================
norm = 'fit';
nRoI = 1;
nGrid= 1e5;
nEst = 100;
inter = 'linear';
errortype = 'none';
mod = 'abs';
ntmax= 10;
name = 'Gaussian';
%=========================================================================
vEst = 100;
vGrid = 1000:500:100000;
wb = waitbar(0,'Aguarde');

iest=0;
for nEst = vEst;
    iest=iest+1;
    igrid = 0;
    for nGrid = vGrid
        igrid=igrid+1;
        [setup] = IN(name,'sg',errortype,'dist',inter,norm,1,nGrid,nEst,nRoI);   % Definir os Parâmetros Iniciais
        [DATA] = datasetGenSingle(setup);
        [X.EST,X.GRID,Y.EST,Y.GRID,Y.TRUTH] = Method_ADDNoise(setup,DATA,setup.RANGE.NOISE(1));
        A(iest,igrid)= rsum(X.GRID,Y.GRID,'mid',DATA.sg,name,0);
        Integ(iest,igrid)=DATA.sg.Integral;        
        %     M(iest,igrid) = Gower(P,Q,dx,mod);
        waitbar(nEst/max(vEst))
    end
end

close(wb)
plot(vGrid,(A'))
% mesh(vEst,vGrid,abs(A'-Integ'))
% plot(X.GRID,Y.GRID,'.r',X.GRID,Y.TRUTH,'-k'); axis tight



