
close all; clc; clear variables;




wb = waitbar(0,'Aguarde...');
for nt=1:50
    [setup] = IN(10000);
    [sg,~] = datasetGenSingle(setup,'Gauss');
    [IND,TARGET] = CV(setup.EVT,setup.BLOCKS);
    i=0;
    for bin = 5:1:100
        i = i+1;
        for cv = 1:setup.BLOCKS
            ind.TR.SG=find(TARGET.TR(cv,:)==1);
            %       sum(TARGET.TR(cv,ind.TR.SG)==0)
            DATASG.TR=sg.evt(IND.TR(cv,ind.TR.SG));
            [xcv(cv,:),ycv(cv,:)]=data_normalized(DATASG.TR,bin);
            range.SG = linspace(min(sg.evt) ,max(sg.evt),1000);
            y(cv,:) = interp1(xcv(cv,:),ycv(cv,:),range.SG,'nearest','extrap');
            %         plot(x(cv,:),y(cv,:)); hold on
        end
        %     ytruth=interp1(sg.pdf.truth.x,sg.pdf.truth.y,range.SG,'nearest','extrap');
        clear xcv ycv
        %         for j = 1:cv
        %             P=y(j,:);
        %             Q=mean(y);
        %   Q=ytruth;
        %   plot(range.SG,P,'r',range.SG,Q,'k',range.SG,ytruth,'b')
        %   pause
        %             ISB(i,j)=(sum(P-Q))/length(P);
        %             IV(i,j)=(sum((P-Q).^2))/length(P);
        %         end
        
    end
    bin = 5:1:100;
    h = 3.5*sg.g1.std*length(sg.evt(IND.TR(cv,ind.TR.SG)))^(-1/3);
    bin_truth(nt) = ceil((max(sg.evt(IND.TR(cv,ind.TR.SG)))-min(sg.evt(IND.TR(cv,ind.TR.SG))))/h);
    bin_scott(nt) = calcnbins(sg.evt(IND.TR(cv,ind.TR.SG)),'scott');
    bin_ss(nt) = sshist(sg.evt(IND.TR(cv,ind.TR.SG)),bin);
    bin_MISE(nt) = divhist(sg.evt(IND.TR(cv,ind.TR.SG)),bin);
    
    waitbar(nt/100)
end
close(wb)

x=linspace(1,max(bin),100000);
% ytruth = normpdf(x,mean(bin_truth),std(bin_truth));
ysc = normpdf(x,mean(bin_scott),std(bin_scott));
ymi = normpdf(x,mean(bin_MISE),std(bin_MISE));
yss = normpdf(x,mean(bin_ss),std(bin_ss));

plot(mean(bin_truth),0,'*r',x,ysc,'k',x,ymi,'b',x,yss,'g')
legend('SCOTT_{TRUTH}','SCOTT','MISE','SS')




% plot(bin,mean(IV')); hold on
% plot(bin,mean(ISB.^2')); hold on
% plot(bin,mean(MISE')); hold on
%
% legend('IV','ISB','MISE')
%
% disp(['SCOTT_{TRUTH}=' num2str(bin_truth) '|SCOTT=' num2str(calcnbins(sg.evt(IND.TR(cv,ind.TR.SG)),'scott')) '|MISE=' num2str(ind_MISE) '|SS=' num2str(sshist(sg.evt(IND.TR(cv,ind.TR.SG))))])
% plot(mean(x),mean(y),'-r')