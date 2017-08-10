clear variables; close all; clc

% PARÂMETROS DE ENTRADA:



for NV = 1:50
    tic
    % bin=linspace(-0.05,0.05,50);
    bin=10:1:120;
    for nt = 1:50;
        
        [setup] = IN(10000);
        % CRIAR BANCO DE DADOS:
        [sg,~] = datasetGenSingle(setup,'Bimodal');
        SCOTT(nt)= calcnbins(sg.evt,'scott');
        FD(nt)= calcnbins(sg.evt,'fd');
        %   SS(nt) =sshist(sg.evt);
        i = 0;
        
        
        for B=bin
            i=i+1;
            
            [xh,yh] = data_normalized(sg.evt,B);
            % %         d = diff(xh); d=d(1)/2;
            xh2 = linspace(min(sg.evt),max(max(sg.evt)),1000);
            yh2=interp1(xh,yh,xh2,'nearest','extrap');
            yh2 = yh2/area2d(xh2,yh2);
%             ytruth = [normpdf(xh2,sg.g1.mu,sg.g1.std)];             
            ytruth = [normpdf(xh2,sg.g1.mu,sg.g1.std) + normpdf(xh2,sg.g2.mu,sg.g2.std)]/2;
            [V] = DFSelect(yh2,ytruth,'norm');
            %        [noise] = noiseADD(sg.pdf.truth.y,B,'gamma');
            %
            %         [V] = DFSelect(noise,sg.pdf.truth.y,'norm');
            for div = 1:3
                A{div}(i,nt) = V(div);
            end
            %         figure
            %                 plot(sg.pdf.truth.x,noise,'k',sg.pdf.truth.x,sg.pdf.truth.y,'r')
            %  plot(xh2,ytruth,'k',xh2,yh2,'r')
            %                 pause
            %                 close
            %                 mean(ytruth-yh2)^2
        end
        %       plot(A{3}(:,nt))
        %       pause
        
    end
    toc
    
    
    for b =1:3
        plot(bin,mean(A{b}')); hold on
        %     boxplot(A{b}',bin)
        xlabel('bin')
        ylabel('Divergencia')
        %     pause
        %     close
        
    end
    B= mean(A{b}');
    indminnt = find(B==min(B),1);
    IND(NV) = bin(indminnt);
end
%
% M = mean(A{b}');
% indmin = find(mean(A{b}')==min(mean(A{b}')));
% plot([bin(indmin) bin(indmin)],[0 max(mean(A{3}'))],':'); hold on
% plot([round(mean(SCOTT)) round(mean(SCOTT))],[0 max(mean(A{3}'))],':')
% legend('Bias','Variance','MISE','BIN MISE','BIN SCOTT')
legend('Bias','Variance','MISE')
%
% % histogram(SS)
% % hold on
%
h = 3.5*sg.g1.std*length(sg.evt)^(-1/3);
bin_truth = ceil((max(sg.evt)-min(sg.evt))/h);
%
%
figure

x=linspace(1,max(bin),100000);
yfd = normpdf(x,mean(FD),std(FD));
ysc = normpdf(x,mean(SCOTT),std(SCOTT));
ymi = normpdf(x,mean(IND),std(IND));
plot(x,yfd,'r',x,ysc,'k',x,ymi,'b',bin_truth,0,'*g')
% histogram(FD)
% hold on
% histogram(SCOTT)
% hold on
% histogram(IND)
legend('FD','SCOTT','MISE','TRUTH_{SCOTT}')