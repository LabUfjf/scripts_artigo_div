% RIEMANN SUM TEST
clear variables; close all; clc

method = 'fit';
type = 'deriv';

for name = {'Gauss'};
    % for name = {'Gauss','Bimodal','Rayleigh','Logn','Gamma'};
    [setup] = IN(100,5000000);
    [sg,~] = datasetGenSingle(setup,name{1});
    
    if strcmp(type,'prob')
        xsg = sg.RoI.x.dy;
    else
        xsg = sg.RoI.x.py;
    end
    
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
                [xest,xgrid,yest,ygrid,ytruth,d] = FitFullFix(setup,sg,xsg,ireg,nest,name,itp,method,type);
                A(ireg)=1;
                AT{iint}{ireg}(iest)  = rsum(xgrid,abs(ygrid-ytruth));
                %    DIVT{iint}{ireg}(iest,:) = DFSelectDx(xgrid,ygrid,ytruth);
                waitbar(iest/length(vest))
                %    plot(xgrid,ygrid-ytruth,'.r')
                %    pause
                %    close
                %    d
            end
        end
        plot(xgrid,ytruth,'.k',xgrid,ygrid,'.r',xest,yest,'.g')
        pause
        close
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
dv = A/(sum(A));

for i=1:setup.DIV
    M(i,:)= AT{1}{i}/A(i);
end

mesh(vest,(1:setup.DIV)/setup.DIV,M)
figure
plot(dv)
%
% for i = 1:10
%
%     plot(i,AT{1}{i},'.')
%     hold on
% end
%
% Res.nearest=interp1(vest,DIVT{1},[2000 5000 10000 15000],'linear','extrap');
% Res.linear=interp1(vest,DIVT{2},[2000 5000 10000 15000],'linear','extrap');