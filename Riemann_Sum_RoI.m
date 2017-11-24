% RIEMANN SUM TEST
clear variables; close all; clc

method = 'fit';

for name = {'Gauss'};
    % for name = {'Gauss','Bimodal','Rayleigh','Logn','Gamma'};
    [setup] = IN(100,5000000);
    [sg,~] = datasetGenSingle(setup,name{1});
%    vest = 100;
    vest = 100:100:1000;
    wb = waitbar(0,'Aguarde...');
    
    %     for itp = {'nearest'};
    for ireg = 1:setup.DIV
        iint = 0;
        for itp = {'nearest'};
            iint=iint+1;            
            iest=0;
            for nest=vest
                
                iest = iest+1;
                [xest,xgrid,yest,ygrid,ytruth] = FitFullFix(setup,sg,sg.RoI.x.dy,ireg,nest,name,itp,method,'deriv');
                
                AT{iint}{ireg}(iest)  = rsum(xgrid,abs(ygrid-ytruth));
%                 DIVT{iint}{ireg}(iest,:) = DFSelectDx(xgrid,ygrid,ytruth);
                waitbar(iest/length(vest))
%                 plot(xgrid,ygrid-ytruth,'.r')
%                 plot(xgrid,ytruth,'.k',xgrid,ygrid,'.r')
%                 pause
%                 close
            end
        end
    end
end
close(wb)

VL={'Bias','Variance','MISE','Linf','Lp','Sorensen','Gower','IP','Harmonic','Cosine','Hellinger','Squared','AddSym','Kullback','Kumar','Area'};
CL=['kr'];
ML=[':::::::::::::::'];


% figure
% for fi = 1:2
%     DIVT{fi}(:,size(DIVT{fi},2)+1)=AT{fi};
%     for d=1:16
%         subplot(4,4,d);plot(vest,DIVT{fi}(:,d)',CL(fi));
%         title([VL{d}])
%         xlabel('X_{EST}')
%         ylabel('Value')
%         grid on
%         set(gca,'GridLineStyle',':'); axis tight;
%         hold on
%         legend('Nearest','Linear')
%         clc
%     end
%     
% end
%

for i=1:setup.DIV
   M(i,:)= AT{1}{i};
end
mesh(vest,(1:setup.DIV)/setup.DIV,M)

% 
% for i = 1:10
%     
%     plot(i,AT{1}{i},'.')
%     hold on
% end
% 
% Res.nearest=interp1(vest,DIVT{1},[2000 5000 10000 15000],'linear','extrap');
% Res.linear=interp1(vest,DIVT{2},[2000 5000 10000 15000],'linear','extrap');