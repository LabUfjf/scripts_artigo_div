% RIEMANN SUM TEST
clear variables; close all; clc

method = 'full';
type = 'deriv';

for name = {'Gauss'};
    % for name = {'Gauss','Bimodal','Rayleigh','Logn','Gamma'};
    [setup] = IN(100,100000);
    [sg,~] = datasetGenSingle(setup,name{1},type);
    vest = 100:5:1000;
    wb = waitbar(0,'Aguarde...');
    %     for itp = {'nearest'};
    for ireg = 1:setup.DIV
        iint = 0;
        for itp = {'nearest'};
            iint=iint+1;
            iest=0;
            dt = sum(sqrt(diff(sg.pdf.truth.x).^2+diff(sg.pdf.truth.y).^2));
            for nest=vest
                iest = iest+1;
                [xest,xgrid,yest,ygrid,ytruth] = FitFullFix(setup,sg,sg.RoI.x,ireg,nest,name,itp,method,type);
                AT{iint}{ireg}(iest)  = rsum(xgrid,abs(ygrid-ytruth));
                DIVT{iint}{ireg}(iest,:) = DFSelectDx(xgrid,ygrid,ytruth);
                waitbar(iest/length(vest))
                %    plot(xgrid,ygrid-ytruth,'.r')
                %    pause
                %    close
                %    d
            end
        end
        %         plot(xgrid,ytruth,'.k',xgrid,ygrid,'.r',xest,yest,'.g')
        %         pause
        %         close
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
%A
% dv = A;

for reg = 1:setup.DIV
    for div = 1:15
        M{div}(reg,:) = DIVT{1}{reg}(:,div);
    end
end

for i=1:setup.DIV
    M{16}(i,:)= AT{1}{i};
end

VL={'Bias','Variance','MISE','Linf','Lp','Sorensen','Gower','IP','Harmonic','Cosine','Hellinger','Squared','AddSym','Kullback','Kumar','Area'};
CL=['kkkggrrbbbkggrb'];
ML=[':::::::::::::::'];

% format longE
for i=1:16
    
    % subplot(4,4,1);mesh(sg.pdf.truth.x,sg.pdf.truth.y,'k'); axis tight
    subplot(4,4,i);mesh(vest,sg.RoI.Xaxis,(M{i})); axis tight
    title([VL{i} '(D)'])
    ylabel(type)
    xlabel('X_{EST}')
    zlabel('RS')
    set(gca,'ZTickLabel',M{i})
end