% RIEMANN SUM TEST
clear variables; close all; clc

for name = {'Gauss'};
    % for name = {'Gauss','Bimodal','Rayleigh','Logn','Gamma'};
    [setup] = IN(10000,10000); setup.DIV = 1;
    [sg,~] = datasetGenSingle(setup,name{1});
    
    nt_max = 500;
    vest = 10:10:100;
    vgrid = 10:10:100;
    
    wb = waitbar(0,'Aguarde...');
    
    for itp = {'nearest'};
        %     for itp = {'nearest','linear'};
        i=0;
        for nest=vest
            i = i+1;
            xest = linspace(sg.pdf.truth.x(1),sg.pdf.truth.x(end),nest);
            dest = diff(xest); dest=dest(1);
            [yest] = GridNew(sg,xest,name);
            j=0;            
            for ngrid = vgrid
                j = j+1;
                xgrid = linspace(sg.pdf.truth.x(1),sg.pdf.truth.x(end),ngrid);
                dgrid = diff(xgrid); dgrid=dgrid(1);
                
                for nt = 1:nt_max;
                    d = (2*rand -1)*dgrid;
                    li = sg.pdf.truth.x(1)+d;
                    ls = sg.pdf.truth.x(end)+d;
                    xgrid_new = linspace(li,ls,ngrid);
%                     XG(nt,:) =xgrid_new;
                    ytruth = GridNew(sg,xgrid_new,name);
                    ygrid = interp1(xest,yest,xgrid_new,itp{1},'extrap');
                    
                    AT(nt)  = rsum(xgrid_new,abs(ygrid-ytruth));
                    [DIVT{nt}] = DFSelectDx(xgrid_new,ygrid,ytruth);
                    
                end                
%                      hist(XG(:),1000)
%                      pause
%                      clear XG
%                      close
                AT_GRID(i,j) = mean(AT);
                BT_GRID(i,j) = std(AT)/sqrt(nt_max);
                CT_GRID(i,j) = min(AT);
                DT_GRID(i,j) = max(AT);
                
                for div = 1:15
                    for nt = 1:nt_max;
                        Mdiv{div}(nt) = DIVT{nt}(div);
                    end
                end
                for div = 1:15
                    A_DIV{div}(i,j) = mean(Mdiv{div});
                    B_DIV{div}(i,j) = std(Mdiv{div})/sqrt(nt_max);
                end
                
            end
            waitbar(i/length(vest))
       
        end
    end
end
close(wb)

subplot(1,2,1);plotSURF(vest,vgrid,AT_GRID,'X_{EST}','X_{GRID}','Riemann Sum',[0.5 0.5 0.5]);
subplot(1,2,2);plotSURF(vest,vgrid,BT_GRID,'X_{EST}','X_{GRID}','Error',[0.5 0.5 0.5]);

VL={'Bias','Variance','MISE','Linf','Lp','Sorensen','Gower','IP','Harmonic','Cosine','Hellinger','Squared','AddSym','Kullback','Kumar'};
CL=['kkkggrrbbbkggrb'];
ML=[':::::::::::::::'];
%
figure
for d=1:15
    subplot(3,5,d);plotSURF(vest,vgrid,A_DIV{d},'X_{EST}','X_{GRID}','Riemann Sum',[0.5 0.5 0.5]);
    % subplot(3,5,d);plotSURF(vest,vgrid,B_DIV{d},'X_{EST}','X_{GRID}','Error',[0.5 0.5 0.5]);
    title([VL{d} '(D)'])
    xlabel('X_{EST}')
    ylabel('X_{GRID}')
end



plotSURF(vest,vgrid,CT_GRID,'X_{EST}','X_{GRID}','Riemann Sum',[0.5 0.5 0.5]);
hold on
plotSURF(vest,vgrid,DT_GRID,'X_{EST}','X_{GRID}','Riemann Sum',[0.5 0.5 0.5]);

