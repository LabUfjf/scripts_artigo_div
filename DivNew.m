%% TESTE Bias X Variance
% VERIFICAR SE O setup.DIV = 1;

clear variables; close all; clc


for name = {'Gauss','Bimodal','Rayleigh','Logn','Gamma'};
    % for name = {'Gauss'};
    [setup] = IN(10000,100); setup.DIV = 1;
    [sg,~] = datasetGenSingle(setup,name{1});
    
%     wb = waitbar(0,'Aguarde...');
    nt_max = 100;
    vest = 10:100:2000;
    vgrid = 10:1000:10000;
    
    for itp = {'nearest','linear'};
        %     for itp = {'nearest'};
        i=0;
        for nest=vest
            i = i+1;
            xest = linspace(sg.pdf.truth.x(1),sg.pdf.truth.x(end),nest);
            [yest] = GridNew(sg,xest,name);
            j=0;
            
            
            for ngrid = vgrid
                j=j+1;
                xgrid = linspace(sg.pdf.truth.x(1),sg.pdf.truth.x(end),ngrid);
                dest = diff(xgrid); dest=dest(1);
                d = dest/nt_max;
                
                for nt = 1:nt_max;
                    
                    xgrid = d+xgrid;
                    
                    ytruth = GridNew(sg,xgrid+(-nt_max/2)*d,name);
                    ygrid = interp1(xest,yest,xgrid+(-nt_max/2)*d,itp{1},'extrap');
                    dgrid = diff(xgrid);
                    
                    plot(xgrid_new,ygrid);hold on
                     plot(xgrid_new,ytruth)
                     pause
                     close
                    AT(nt)  = rsum(ytruth-ygrid,dgrid(1));        
                    [V{nt}] = DFSelectDx(xgrid,ygrid,ytruth,'no');
                    
                end
                   
                d = 0;
                A(i,j) = mean(AT);
                B(i,j)= std(AT)/sqrt(nt_max);
%                 plot(abs((ytruth-ygrid).*abs(dgrid(1))))
%                     pause 
%                 A(i,j)
                for div = 1:15
                    for nt = 1:nt_max;
                        Mdiv{div}(nt) = V{nt}(div);
                    end
                end
                
                
                for div = 1:15
                    Adiv{div}(i,j) = mean(Mdiv{div});
                    Bdiv{div}(i,j) = std(Mdiv{div})/sqrt(nt_max);
                end
                
            end
            
            waitbar(i/length(vest))
        end
%         close(wb)
        
        figure
        subplot(1,2,1);plotSURF(vest,vgrid,A,'X_{EST}','X_{GRID}','Riemann Sum')
        subplot(1,2,2); plotSURF(vest,vgrid,B,'X_{EST}','X_{GRID}','Error')
        set(gcf, 'Position', get(0, 'Screensize'));
%         saveas(gcf,['MESH_HIST_ERROR[' name{1} ']INTERP[' itp{1} ']' ],'fig')
%         save(['MESH_HIST_ERROR[' name{1} ']INTERP[' itp{1} ']' ],'A','B','Adiv','Bdiv')
%         close
%         clear A B Mdiv Adiv Bdiv V
    end
end
% surf(vest,vgrid,B','FaceColor',[0.5 0.5 0.5],'EdgeColor','none')
% camlight left; lighting phong;
% axis tight; set(gca,'gridlinestyle',':');
% alpha(0.9)
% shading interp;
% surfl(vest,vgrid,B');
% shading interp
% colormap gray
% axis tight; set(gca,'gridlinestyle',':');
% lighting pong
% light('Position',[-1 0 0],'Style','local')